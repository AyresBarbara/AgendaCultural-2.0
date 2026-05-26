package com.agenda.agendacultural.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class BackupService {

    private static final Logger logger = LoggerFactory.getLogger(BackupService.class);
    private static final String BACKUP_DIR = "./backups/";

    @Value("${mysqldump.path:mysqldump}")
    private String mysqldumpPath;

    @Value("${spring.datasource.username:root}")
    private String dbUser;

    @Value("${spring.datasource.password:}")
    private String dbPassword;

    @Value("${spring.datasource.url:jdbc:mysql://localhost:3306/agenda_cultural}")
    private String dbUrl;

    public String realizarBackup(String prefixo) throws Exception {
        logger.info("Iniciando backup...");
        
        File pastaBackup = new File(BACKUP_DIR);
        if (!pastaBackup.exists()) pastaBackup.mkdirs();

        String dbName = extractDatabaseName(dbUrl);
        String dataHora = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String nomeArquivo = prefixo + "_" + dbName + "_" + dataHora + ".sql";
        String caminhoCompleto = BACKUP_DIR + nomeArquivo;

        List<String> comando = new ArrayList<>();
        comando.add(mysqldumpPath);
        comando.add("--no-defaults");
        comando.add("--set-gtid-purged=OFF");
        comando.add("--skip-comments");
        comando.add("-u" + dbUser);
        comando.add("-p" + dbPassword);
        comando.add(dbName);

        ProcessBuilder pb = new ProcessBuilder(comando);
        pb.redirectOutput(new File(caminhoCompleto));
        pb.redirectErrorStream(true);
        
        int exitCode = pb.start().waitFor();

        if (exitCode == 0) {
            logger.info("Backup criado: {}", nomeArquivo);
            return nomeArquivo;
        } else {
            throw new RuntimeException("Erro no backup. Código: " + exitCode);
        }
    }

    public List<Map<String, Object>> listarBackups() {
        File pasta = new File(BACKUP_DIR);
        if (!pasta.exists()) return Collections.emptyList();

        List<Map<String, Object>> backups = new ArrayList<>();
        for (File f : pasta.listFiles((dir, name) -> name.endsWith(".sql"))) {
            Map<String, Object> info = new HashMap<>();
            info.put("nome", f.getName());
            info.put("tamanho", f.length());
            info.put("data", new Date(f.lastModified()));
            backups.add(info);
        }
        backups.sort((a, b) -> b.get("nome").toString().compareTo(a.get("nome").toString()));
        return backups;
    }

    public void restaurarBackup(String nomeArquivo) throws Exception {
        File arquivo = new File(BACKUP_DIR + nomeArquivo);
        if (!arquivo.exists()) throw new FileNotFoundException("Backup não encontrado: " + nomeArquivo);
        executarRestore(arquivo);
    }

    public void restaurarBackupStream(InputStream fileStream, String fileName) throws Exception {
        File tempFile = new File(BACKUP_DIR + "temp_" + fileName);
        try (OutputStream out = new FileOutputStream(tempFile)) {
            byte[] buffer = new byte[8192];
            int bytes;
            while ((bytes = fileStream.read(buffer)) != -1) out.write(buffer, 0, bytes);
        }
        executarRestore(tempFile);
        tempFile.delete();
    }

    private void executarRestore(File arquivoSQL) throws Exception {
        String mysqlPath = mysqldumpPath.replace("mysqldump.exe", "mysql.exe").replace("mysqldump", "mysql");
        String dbName = extractDatabaseName(dbUrl);
        
        // Filtra apenas linhas que são comandos SQL válidos
        List<String> linhasSQL = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(arquivoSQL), "UTF-8"))) {
            String linha;
            while ((linha = reader.readLine()) != null) {
                linha = linha.trim();
                if (linha.isEmpty()) continue;
                if (linha.startsWith("--")) continue;
                if (linha.contains("Using a password")) continue;
                linhasSQL.add(linha);
            }
        }
        
        // Cria arquivo temporário apenas com SQL
        File sqlLimpo = new File(BACKUP_DIR + "restore_" + System.currentTimeMillis() + ".sql");
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sqlLimpo), "UTF-8"))) {
            for (String linha : linhasSQL) {
                writer.write(linha);
                writer.newLine();
            }
        }
        
        ProcessBuilder pb = new ProcessBuilder(mysqlPath, "-u" + dbUser, "-p" + dbPassword, dbName);
        pb.redirectInput(sqlLimpo);
        pb.redirectErrorStream(true);
        
        Process process = pb.start();
        process.waitFor();
        sqlLimpo.delete();
        
        logger.info("✅ Restore concluído!");
    }

    private String extractDatabaseName(String url) {
        int lastSlash = url.lastIndexOf('/');
        if (lastSlash > 0) {
            String db = url.substring(lastSlash + 1);
            int questionMark = db.indexOf('?');
            if (questionMark > 0) return db.substring(0, questionMark);
            return db;
        }
        return "agenda_cultural";
    }

    @Scheduled(cron = "0 0 2 * * ?")
    public void backupAgendado() {
        try {
            realizarBackup("backup_agendado");
        } catch (Exception e) {
            logger.error("Erro no backup agendado: {}", e.getMessage());
        }
    }
}
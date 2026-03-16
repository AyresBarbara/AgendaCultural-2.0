package com.agenda.agendacultural.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.http.MediaType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("/api/admin")
public class BackupController {

    private static final Logger logger = LoggerFactory.getLogger(BackupController.class);
    private static final String BACKUP_DIR = "./backups/";

    @Value("${mysqldump.path:mysqldump}")
    private String mysqldumpPath;

    @Value("${spring.datasource.username:root}")
    private String dbUser;

    @Value("${spring.datasource.password:}")
    private String dbPassword;

    @Value("${spring.datasource.url:jdbc:mysql://localhost:3306/agenda_cultural}")
    private String dbUrl;

    @PostMapping("/backup")
public ResponseEntity<?> realizarBackup() {
    try {
        logger.info("Iniciando backup do banco de dados...");
        
        File pastaBackup = new File(BACKUP_DIR);
        if (!pastaBackup.exists()) pastaBackup.mkdirs();

        String dbName = extractDatabaseName(dbUrl);
        String dataHora = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String nomeArquivo = "backup_" + dbName + "_" + dataHora + ".sql";
        String caminhoCompleto = BACKUP_DIR + nomeArquivo;

        // Usar --no-defaults para suprimir avisos
        List<String> comando = new ArrayList<>();
        comando.add(mysqldumpPath);
        comando.add("--no-defaults");  // <-- ISSO ELIMINA O AVISO
        comando.add("-u" + dbUser);
        comando.add("-p" + dbPassword);
        comando.add(dbName);

        logger.info("Comando: {}", String.join(" ", comando));

        ProcessBuilder processBuilder = new ProcessBuilder(comando);
        processBuilder.redirectOutput(new File(caminhoCompleto));
        processBuilder.redirectErrorStream(true);
        
        Process processo = processBuilder.start();
        int codigoSaida = processo.waitFor();

        if (codigoSaida == 0) {
            return ResponseEntity.ok(Map.of(
                "mensagem", "Backup realizado com sucesso!",
                "arquivo", nomeArquivo
            ));
        } else {
            throw new Exception("Erro no backup");
        }

    } catch (Exception e) {
        return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
    }
}

    @GetMapping("/backups")
    public ResponseEntity<?> listarBackups() {
        try {
            File pastaBackup = new File(BACKUP_DIR);
            if (!pastaBackup.exists()) {
                return ResponseEntity.ok(Collections.emptyList());
            }

            File[] arquivos = pastaBackup.listFiles((dir, name) -> name.endsWith(".sql"));
            List<Map<String, Object>> backups = new ArrayList<>();

            if (arquivos != null) {
                for (File arquivo : arquivos) {
                    Map<String, Object> info = new HashMap<>();
                    info.put("nome", arquivo.getName());
                    info.put("tamanho", arquivo.length() + " bytes");
                    info.put("data", new Date(arquivo.lastModified()).toString());
                    backups.add(info);
                }
            }

            // Ordenar do mais novo para o mais velho
            backups.sort((a, b) -> b.get("nome").toString().compareTo(a.get("nome").toString()));

            return ResponseEntity.ok(backups);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
        }
    }

    private String extractDatabaseName(String url) {
        // jdbc:mysql://localhost:3306/agenda_cultural
        int lastSlash = url.lastIndexOf('/');
        if (lastSlash > 0) {
            String db = url.substring(lastSlash + 1);
            int questionMark = db.indexOf('?');
            if (questionMark > 0) {
                return db.substring(0, questionMark);
            }
            return db;
        }
        return "agenda_cultural";
    }

    @PostMapping("/restore")
public ResponseEntity<?> restaurarBackup(@RequestBody Map<String, String> request) {
    try {
        String nomeArquivo = request.get("arquivo");
        
        if (nomeArquivo == null || nomeArquivo.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("erro", "Nome do arquivo não fornecido"));
        }

        logger.info("===== INICIANDO RESTORE =====");
        logger.info("Arquivo solicitado: {}", nomeArquivo);
        
        String caminhoCompleto = BACKUP_DIR + nomeArquivo;
        File arquivoBackup = new File(caminhoCompleto);
        
        logger.info("Caminho completo: {}", caminhoCompleto);
        logger.info("Arquivo existe? {}", arquivoBackup.exists());
        logger.info("Tamanho do arquivo: {} bytes", arquivoBackup.length());
        
        if (!arquivoBackup.exists()) {
            return ResponseEntity.status(404).body(Map.of("erro", "Arquivo de backup não encontrado: " + nomeArquivo));
        }

        // Extrair nome do banco da URL
        String dbName = extractDatabaseName(dbUrl);
        logger.info("Banco de dados: {}", dbName);

        // Caminho correto do mysql (mesmo lugar do mysqldump)
        String mysqlPath = "C:\\Program Files\\MySQL\\MySQL Server 8.1\\bin\\mysql.exe";
        logger.info("Caminho do mysql: {}", mysqlPath);

        // Verificar se o mysql.exe existe
        File mysqlFile = new File(mysqlPath);
        logger.info("mysql.exe existe? {}", mysqlFile.exists());

        // Construir comando mysql para restaurar
        List<String> comando = new ArrayList<>();
        comando.add(mysqlPath);
        comando.add("-u" + dbUser);
        comando.add("-p" + dbPassword);
        comando.add(dbName);

        logger.info("Comando completo: {}", String.join(" ", comando));

        // Executar restore (redirecionando o arquivo SQL para a entrada do mysql)
        ProcessBuilder processBuilder = new ProcessBuilder(comando);
        processBuilder.redirectInput(arquivoBackup);
        processBuilder.redirectErrorStream(true);
        
        logger.info("Executando processo...");
        Process processo = processBuilder.start();
        
        // Capturar TODA a saída em tempo real
        BufferedReader reader = new BufferedReader(new InputStreamReader(processo.getInputStream()));
        String linha;
        StringBuilder output = new StringBuilder();
        
        logger.info("===== SAÍDA DO MYSQL =====");
        while ((linha = reader.readLine()) != null) {
            logger.info("MYSQL: {}", linha);
            output.append(linha).append("\n");
        }
        
        int codigoSaida = processo.waitFor();
        logger.info("Código de saída do processo: {}", codigoSaida);
        logger.info("===== FIM DA SAÍDA DO MYSQL =====");

        if (codigoSaida == 0) {
            logger.info("✅ RESTORE CONCLUÍDO COM SUCESSO!");
            
            Map<String, Object> resposta = new HashMap<>();
            resposta.put("mensagem", "Restore realizado com sucesso!");
            resposta.put("arquivo", nomeArquivo);
            resposta.put("data", LocalDateTime.now().toString());
            
            return ResponseEntity.ok(resposta);
        } else {
            logger.error("❌ ERRO NO RESTORE. Código: {}", codigoSaida);
            logger.error("Saída completa: {}", output.toString());
            
            return ResponseEntity.status(500).body(Map.of(
                "erro", "Falha no restore. Código: " + codigoSaida,
                "detalhes", output.toString()
            ));
        }

    } catch (Exception e) {
        logger.error("❌ EXCEÇÃO NO RESTORE: ", e);
        
        Map<String, String> erro = new HashMap<>();
        erro.put("erro", "Falha no restore: " + e.getMessage());
        erro.put("detalhes", e.toString());
        
        return ResponseEntity.status(500).body(erro);
    }
}

    @PostMapping(value = "/restore/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<?> restaurarBackupUpload(@RequestParam("file") MultipartFile file) {
    try {
        logger.info("Iniciando restore via upload: {}", file.getOriginalFilename());
        
        // Salvar arquivo temporariamente
        File tempFile = new File(BACKUP_DIR + "temp_" + file.getOriginalFilename());
        file.transferTo(tempFile);

        // Extrair nome do banco da URL
        String dbName = extractDatabaseName(dbUrl);

        // Construir comando mysql para restaurar
        List<String> comando = new ArrayList<>();
        comando.add(mysqldumpPath.replace("mysqldump", "mysql"));
        comando.add("-u" + dbUser);
        comando.add("-p" + dbPassword);
        comando.add(dbName);

        // Executar restore
        ProcessBuilder processBuilder = new ProcessBuilder(comando);
        processBuilder.redirectInput(tempFile);
        processBuilder.redirectErrorStream(true);
        
        Process processo = processBuilder.start();
        int codigoSaida = processo.waitFor();

        // Apagar arquivo temporário
        tempFile.delete();

        if (codigoSaida == 0) {
            return ResponseEntity.ok(Map.of(
                "mensagem", "Restore realizado com sucesso!",
                "arquivo", file.getOriginalFilename()
            ));
        } else {
            throw new Exception("Erro ao restaurar backup");
        }

    } catch (Exception e) {
        logger.error("Erro: ", e);
        return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
    }
}
}
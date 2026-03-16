package com.agenda.agendacultural.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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
            logger.info("Usando mysqldump: {}", mysqldumpPath);
            
            // Criar pasta de backups se não existir
            File pastaBackup = new File(BACKUP_DIR);
            if (!pastaBackup.exists()) {
                pastaBackup.mkdirs();
                logger.info("Pasta de backups criada: {}", BACKUP_DIR);
            }

            // Extrair nome do banco da URL
            String dbName = extractDatabaseName(dbUrl);
            
            // Nome do arquivo: backup_AAAAMMDD_HHMMSS.sql
            String dataHora = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
            String nomeArquivo = "backup_" + dbName + "_" + dataHora + ".sql";
            String caminhoCompleto = BACKUP_DIR + nomeArquivo;

            logger.info("Arquivo de backup: {}", caminhoCompleto);

            // Construir comando mysqldump
            List<String> comando = new ArrayList<>();
            comando.add(mysqldumpPath);
            comando.add("-u" + dbUser);
            comando.add("-p" + dbPassword);
            comando.add(dbName);

            logger.info("Comando: {}", String.join(" ", comando));

            // Executar backup
            ProcessBuilder processBuilder = new ProcessBuilder(comando);
            processBuilder.redirectOutput(new File(caminhoCompleto));
            processBuilder.redirectErrorStream(true);
            
            Process processo = processBuilder.start();
            int codigoSaida = processo.waitFor();

            // Ler saída para log
            BufferedReader reader = new BufferedReader(new InputStreamReader(processo.getInputStream()));
            String linha;
            StringBuilder output = new StringBuilder();
            while ((linha = reader.readLine()) != null) {
                output.append(linha).append("\n");
            }

            if (codigoSaida == 0) {
                logger.info("Backup concluído com sucesso!");
                
                Map<String, Object> resposta = new HashMap<>();
                resposta.put("mensagem", "Backup realizado com sucesso!");
                resposta.put("arquivo", nomeArquivo);
                resposta.put("caminho", caminhoCompleto);
                resposta.put("data", LocalDateTime.now().toString());
                resposta.put("tamanho", new File(caminhoCompleto).length() + " bytes");
                
                return ResponseEntity.ok(resposta);
            } else {
                logger.error("Erro no mysqldump. Código: {}", codigoSaida);
                logger.error("Saída: {}", output.toString());
                throw new Exception("Erro ao executar backup. Código: " + codigoSaida);
            }

        } catch (Exception e) {
            logger.error("Erro detalhado: ", e);
            
            Map<String, String> erro = new HashMap<>();
            erro.put("erro", "Falha no backup: " + e.getMessage());
            erro.put("detalhes", e.toString());
            
            return ResponseEntity.status(500).body(erro);
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
}
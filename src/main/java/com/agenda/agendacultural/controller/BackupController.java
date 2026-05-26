package com.agenda.agendacultural.controller;

import com.agenda.agendacultural.service.BackupService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.MediaType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class BackupController {

    private static final Logger logger = LoggerFactory.getLogger(BackupController.class);
    private final BackupService backupService;

    public BackupController(BackupService backupService) {
        this.backupService = backupService;
    }

    @PostMapping("/backup")
    public ResponseEntity<?> fazerBackup() {
        try {
            String nomeArquivo = backupService.realizarBackup("backup_manual");
            return ResponseEntity.ok(Map.of(
                "mensagem", "Backup realizado com sucesso!",
                "arquivo", nomeArquivo
            ));
        } catch (Exception e) {
            logger.error("Erro ao fazer backup: {}", e.getMessage());
            return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
        }
    }

    @GetMapping("/backups")
    public ResponseEntity<?> listarBackups() {
        try {
            return ResponseEntity.ok(backupService.listarBackups());
        } catch (Exception e) {
            logger.error("Erro ao listar backups: {}", e.getMessage());
            return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
        }
    }

    @PostMapping("/restore")
    public ResponseEntity<?> restaurarBackup(@RequestBody Map<String, String> request) {
        try {
            backupService.restaurarBackup(request.get("arquivo"));
            return ResponseEntity.ok(Map.of("mensagem", "Restore realizado com sucesso!"));
        } catch (Exception e) {
            logger.error("Erro ao restaurar: {}", e.getMessage());
            return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
        }
    }

    @PostMapping(value = "/restore/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> restaurarBackupUpload(@RequestParam("file") MultipartFile file) {
        try {
            backupService.restaurarBackupStream(file.getInputStream(), file.getOriginalFilename());
            return ResponseEntity.ok(Map.of("mensagem", "Restore via upload realizado com sucesso!"));
        } catch (Exception e) {
            logger.error("Erro no upload: {}", e.getMessage());
            return ResponseEntity.status(500).body(Map.of("erro", e.getMessage()));
        }
    }
}
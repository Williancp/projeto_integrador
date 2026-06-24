package com.projetointegrador.controller;

import com.projetointegrador.dto.CultivoDTO;
import com.projetointegrador.model.Cultivo;
import com.projetointegrador.service.CultivoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/cultivos")
public class CultivoController {

    @Autowired
    private CultivoService cultivoService;

    @GetMapping
    public ResponseEntity<List<CultivoDTO>> getAllCultivos() {
        List<CultivoDTO> cultivos = cultivoService.findAll().stream()
                .map(CultivoDTO::fromEntity)
                .collect(Collectors.toList());
        return ResponseEntity.ok(cultivos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CultivoDTO> getCultivoById(@PathVariable Long id) {
        return cultivoService.findById(id)
                .map(CultivoDTO::fromEntity)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/propriedade/{idPropriedade}")
    public ResponseEntity<List<CultivoDTO>> getCultivosByPropriedade(@PathVariable Long idPropriedade) {
        List<CultivoDTO> cultivos = cultivoService.findByPropriedade(idPropriedade).stream()
                .map(CultivoDTO::fromEntity)
                .collect(Collectors.toList());
        return ResponseEntity.ok(cultivos);
    }

    @PostMapping
    public ResponseEntity<CultivoDTO> createCultivo(@RequestBody CultivoDTO cultivoDTO) {
        Cultivo savedCultivo = cultivoService.save(cultivoDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(CultivoDTO.fromEntity(savedCultivo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CultivoDTO> updateCultivo(@PathVariable Long id, @RequestBody CultivoDTO cultivoDTO) {
        Cultivo updatedCultivo = cultivoService.update(id, cultivoDTO);
        return ResponseEntity.ok(CultivoDTO.fromEntity(updatedCultivo));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole(\'ADMINISTRADOR\')")
    public ResponseEntity<Void> deleteCultivo(@PathVariable Long id) {
        cultivoService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleValidationError(IllegalArgumentException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }
}

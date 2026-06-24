package com.projetointegrador.controller;

import com.projetointegrador.dto.PropriedadeDTO;
import com.projetointegrador.service.PropriedadeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/properties")
@RequiredArgsConstructor
@CrossOrigin(origins = "*", maxAge = 3600)
public class PropriedadeController {

    private final PropriedadeService propriedadeService;

    @GetMapping
    public ResponseEntity<List<PropriedadeDTO>> getAllPropriedades() {
        List<PropriedadeDTO> propriedades = propriedadeService.getAllPropriedades();
        return ResponseEntity.ok(propriedades);
    }

    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<List<PropriedadeDTO>> getPropriedadesByUsuario(@PathVariable Long idUsuario) {
        List<PropriedadeDTO> propriedades = propriedadeService.getPropriedadesByUsuario(idUsuario);
        return ResponseEntity.ok(propriedades);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PropriedadeDTO> getPropriedadeById(@PathVariable Long id) {
        PropriedadeDTO propriedade = propriedadeService.getPropriedadeById(id);
        return ResponseEntity.ok(propriedade);
    }

    @PostMapping
    public ResponseEntity<PropriedadeDTO> createPropriedade(@RequestBody PropriedadeDTO propriedadeDTO) {
        PropriedadeDTO createdPropriedade = propriedadeService.createPropriedade(propriedadeDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdPropriedade);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PropriedadeDTO> updatePropriedade(@PathVariable Long id, @RequestBody PropriedadeDTO propriedadeDTO) {
        PropriedadeDTO updatedPropriedade = propriedadeService.updatePropriedade(id, propriedadeDTO);
        return ResponseEntity.ok(updatedPropriedade);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePropriedade(@PathVariable Long id) {
        propriedadeService.deletePropriedade(id);
        return ResponseEntity.noContent().build();
    }
}

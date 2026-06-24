package com.projetointegrador.service;

import com.projetointegrador.dto.PropriedadeDTO;
import com.projetointegrador.model.Propriedade;
import com.projetointegrador.model.Usuario;
import com.projetointegrador.repository.PropriedadeRepository;
import com.projetointegrador.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class PropriedadeService {

    private final PropriedadeRepository propriedadeRepository;
    private final UsuarioRepository usuarioRepository;

    public List<PropriedadeDTO> getAllPropriedades() {
        return propriedadeRepository.findAll().stream()
                .map(PropriedadeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public List<PropriedadeDTO> getPropriedadesByUsuario(Long idUsuario) {
        return propriedadeRepository.findByUsuarioIdUsuario(idUsuario).stream()
                .map(PropriedadeDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public PropriedadeDTO getPropriedadeById(Long id) {
        Propriedade propriedade = propriedadeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propriedade não encontrada com ID: " + id));
        return PropriedadeDTO.fromEntity(propriedade);
    }

    public PropriedadeDTO createPropriedade(PropriedadeDTO propriedadeDTO) {
        Usuario usuario = usuarioRepository.findById(propriedadeDTO.getIdUsuario())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado com ID: " + propriedadeDTO.getIdUsuario()));

        Propriedade propriedade = Propriedade.builder()
                .nome(propriedadeDTO.getNome())
                .localidade(propriedadeDTO.getLocalidade())
                .cidade(propriedadeDTO.getCidade())
                .telefone(propriedadeDTO.getTelefone())
                .areaTotal(propriedadeDTO.getAreaTotal())
                .latitude(propriedadeDTO.getLatitude())
                .longitude(propriedadeDTO.getLongitude())
                .usuario(usuario)
                .build();

        Propriedade savedPropriedade = propriedadeRepository.save(propriedade);
        return PropriedadeDTO.fromEntity(savedPropriedade);
    }

    public PropriedadeDTO updatePropriedade(Long id, PropriedadeDTO propriedadeDTO) {
        Propriedade propriedade = propriedadeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propriedade não encontrada com ID: " + id));

        propriedade.setNome(propriedadeDTO.getNome());
        propriedade.setLocalidade(propriedadeDTO.getLocalidade());
        propriedade.setCidade(propriedadeDTO.getCidade());
        propriedade.setTelefone(propriedadeDTO.getTelefone());
        propriedade.setAreaTotal(propriedadeDTO.getAreaTotal());
        propriedade.setLatitude(propriedadeDTO.getLatitude());
        propriedade.setLongitude(propriedadeDTO.getLongitude());

        Propriedade updatedPropriedade = propriedadeRepository.save(propriedade);
        return PropriedadeDTO.fromEntity(updatedPropriedade);
    }

    public void deletePropriedade(Long id) {
        Propriedade propriedade = propriedadeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Propriedade não encontrada com ID: " + id));
        propriedadeRepository.delete(propriedade);
    }
}

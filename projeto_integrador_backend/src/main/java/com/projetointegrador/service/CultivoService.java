package com.projetointegrador.service;

import com.projetointegrador.dto.CultivoDTO;
import com.projetointegrador.model.Cultivo;
import com.projetointegrador.model.Propriedade;
import com.projetointegrador.repository.CultivoRepository;
import com.projetointegrador.repository.PropriedadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CultivoService {

    @Autowired
    private CultivoRepository cultivoRepository;

    @Autowired
    private PropriedadeRepository propriedadeRepository;

    public List<Cultivo> findAll() {
        return cultivoRepository.findAll();
    }

    public Optional<Cultivo> findById(Long id) {
        return cultivoRepository.findById(id);
    }

    public List<Cultivo> findByPropriedade(Long idPropriedade) {
        return cultivoRepository.findByPropriedadeIdPropriedade(idPropriedade);
    }

    public Cultivo save(CultivoDTO cultivoDTO) {
        Propriedade propriedade = propriedadeRepository.findById(cultivoDTO.getIdPropriedade())
                .orElseThrow(() -> new RuntimeException("Propriedade não encontrada"));

        Cultivo cultivo = new Cultivo();
        cultivo.setPropriedade(propriedade);
        cultivo.setCultura(cultivoDTO.getCultura());
        cultivo.setCanalVenda(cultivoDTO.getCanalVenda());
        cultivo.setPercentualReceita(cultivoDTO.getPercentualReceita());
        cultivo.setAnoImplantacao(cultivoDTO.getAnoImplantacao());
        cultivo.setNumeroPlantas(cultivoDTO.getNumeroPlantas());
        cultivo.setPercentualVendaCanal(cultivoDTO.getPercentualVendaCanal());
        cultivo.setNumeroPontosVenda(cultivoDTO.getNumeroPontosVenda());
        cultivo.setDistanciaEntrega(cultivoDTO.getDistanciaEntrega());

        return cultivoRepository.save(cultivo);
    }

    public Cultivo update(Long id, CultivoDTO cultivoDTO) {
        Cultivo cultivo = cultivoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cultivo não encontrado com id " + id));

        cultivo.setCultura(cultivoDTO.getCultura());
        cultivo.setCanalVenda(cultivoDTO.getCanalVenda());
        cultivo.setPercentualReceita(cultivoDTO.getPercentualReceita());
        cultivo.setAnoImplantacao(cultivoDTO.getAnoImplantacao());
        cultivo.setNumeroPlantas(cultivoDTO.getNumeroPlantas());
        cultivo.setPercentualVendaCanal(cultivoDTO.getPercentualVendaCanal());
        cultivo.setNumeroPontosVenda(cultivoDTO.getNumeroPontosVenda());
        cultivo.setDistanciaEntrega(cultivoDTO.getDistanciaEntrega());

        if (cultivoDTO.getIdPropriedade() != null) {
            Propriedade propriedade = propriedadeRepository.findById(cultivoDTO.getIdPropriedade())
                    .orElseThrow(() -> new RuntimeException("Propriedade não encontrada"));
            cultivo.setPropriedade(propriedade);
        }

        return cultivoRepository.save(cultivo);
    }

    public void delete(Long id) {
        Cultivo cultivo = cultivoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cultivo não encontrado com id " + id));
        cultivoRepository.delete(cultivo);
    }
}

package com.projetointegrador.service;

import com.projetointegrador.dto.CultivoDTO;
import com.projetointegrador.model.CanalVendaCultivo;
import com.projetointegrador.model.Cultivo;
import com.projetointegrador.model.Propriedade;
import com.projetointegrador.repository.CultivoRepository;
import com.projetointegrador.repository.PropriedadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
        aplicarCanaisVenda(cultivo, cultivoDTO);
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
        aplicarCanaisVenda(cultivo, cultivoDTO);
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

    private void aplicarCanaisVenda(Cultivo cultivo, CultivoDTO cultivoDTO) {
        List<CanalVendaCultivo> canais = obterCanaisVenda(cultivoDTO);
        validarCanaisVenda(canais);
        cultivo.setCanaisVenda(canais);
        cultivo.setCanalVenda(canais.stream()
                .map(canal -> canal.getCanalVenda() + " (" + canal.getPercentualVenda() + "%)")
                .collect(Collectors.joining(", ")));
        cultivo.setPercentualVendaCanal(canais.stream()
                .mapToDouble(CanalVendaCultivo::getPercentualVenda)
                .sum());
    }

    private List<CanalVendaCultivo> obterCanaisVenda(CultivoDTO cultivoDTO) {
        if (cultivoDTO.getCanaisVenda() != null && !cultivoDTO.getCanaisVenda().isEmpty()) {
            return cultivoDTO.getCanaisVenda().stream()
                    .map(canal -> new CanalVendaCultivo(
                            canal.getCanalVenda() == null ? "" : canal.getCanalVenda().trim(),
                            canal.getPercentualVenda()))
                    .collect(Collectors.toList());
        }

        if (cultivoDTO.getCanalVenda() != null && !cultivoDTO.getCanalVenda().trim().isEmpty()) {
            Double percentual = cultivoDTO.getPercentualVendaCanal() == null
                    ? 100.0
                    : cultivoDTO.getPercentualVendaCanal();
            return List.of(new CanalVendaCultivo(cultivoDTO.getCanalVenda().trim(), percentual));
        }

        return List.of();
    }

    private void validarCanaisVenda(List<CanalVendaCultivo> canais) {
        if (canais.isEmpty()) {
            throw new IllegalArgumentException("Informe pelo menos um canal de venda");
        }

        double total = 0.0;
        for (CanalVendaCultivo canal : canais) {
            if (canal.getCanalVenda() == null || canal.getCanalVenda().isBlank()) {
                throw new IllegalArgumentException("O nome do canal de venda é obrigatório");
            }
            if (canal.getPercentualVenda() == null
                    || canal.getPercentualVenda() <= 0
                    || canal.getPercentualVenda() > 100) {
                throw new IllegalArgumentException("Cada canal deve ter percentual maior que 0 e no máximo 100");
            }
            total += canal.getPercentualVenda();
        }

        if (total > 100.0) {
            throw new IllegalArgumentException("A soma dos percentuais dos canais de venda não pode passar de 100%");
        }
    }
}

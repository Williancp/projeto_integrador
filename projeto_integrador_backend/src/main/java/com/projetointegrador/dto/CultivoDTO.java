package com.projetointegrador.dto;

import com.projetointegrador.model.Cultivo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CultivoDTO {
    private Long idCultivo;
    private Long idPropriedade;
    private String cultura;
    private String canalVenda;
    private List<CanalVendaDTO> canaisVenda;
    private Double percentualReceita;
    private Integer anoImplantacao;
    private Integer numeroPlantas;
    private Double percentualVendaCanal;
    private Integer numeroPontosVenda;
    private Double distanciaEntrega;

    public static CultivoDTO fromEntity(Cultivo cultivo) {
        return CultivoDTO.builder()
                .idCultivo(cultivo.getIdCultivo())
                .idPropriedade(cultivo.getPropriedade().getIdPropriedade())
                .cultura(cultivo.getCultura())
                .canalVenda(cultivo.getCanalVenda())
                .canaisVenda(cultivo.getCanaisVenda() == null ? List.of() :
                        cultivo.getCanaisVenda().stream()
                                .map(canal -> CanalVendaDTO.builder()
                                        .canalVenda(canal.getCanalVenda())
                                        .percentualVenda(canal.getPercentualVenda())
                                        .build())
                                .collect(Collectors.toList()))
                .percentualReceita(cultivo.getPercentualReceita())
                .anoImplantacao(cultivo.getAnoImplantacao())
                .numeroPlantas(cultivo.getNumeroPlantas())
                .percentualVendaCanal(cultivo.getPercentualVendaCanal())
                .numeroPontosVenda(cultivo.getNumeroPontosVenda())
                .distanciaEntrega(cultivo.getDistanciaEntrega())
                .build();
    }
}

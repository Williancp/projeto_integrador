package com.projetointegrador.dto;

import com.projetointegrador.model.Cultivo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CultivoDTO {
    private Long idCultivo;
    private Long idPropriedade;
    private String cultura;
    private String canalVenda;
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
                .percentualReceita(cultivo.getPercentualReceita())
                .anoImplantacao(cultivo.getAnoImplantacao())
                .numeroPlantas(cultivo.getNumeroPlantas())
                .percentualVendaCanal(cultivo.getPercentualVendaCanal())
                .numeroPontosVenda(cultivo.getNumeroPontosVenda())
                .distanciaEntrega(cultivo.getDistanciaEntrega())
                .build();
    }
}

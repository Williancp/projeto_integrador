package com.projetointegrador.dto;

import com.projetointegrador.model.Propriedade;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PropriedadeDTO {
    private Long idPropriedade;
    private String nome;
    private String localidade;
    private String cidade;
    private String telefone;
    private BigDecimal areaTotal;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Long idUsuario;

    public static PropriedadeDTO fromEntity(Propriedade propriedade) {
        return PropriedadeDTO.builder()
                .idPropriedade(propriedade.getIdPropriedade())
                .nome(propriedade.getNome())
                .localidade(propriedade.getLocalidade())
                .cidade(propriedade.getCidade())
                .telefone(propriedade.getTelefone())
                .areaTotal(propriedade.getAreaTotal())
                .latitude(propriedade.getLatitude())
                .longitude(propriedade.getLongitude())
                .idUsuario(propriedade.getUsuario().getIdUsuario())
                .build();
    }
}

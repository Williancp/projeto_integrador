package com.projetointegrador.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CanalVendaCultivo {

    @Column(name = "canal_venda", nullable = false)
    private String canalVenda;

    @Column(name = "percentual_venda", nullable = false)
    private Double percentualVenda;
}

package com.projetointegrador.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "cultivos")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cultivo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idCultivo;

    @ManyToOne
    @JoinColumn(name = "id_propriedade", nullable = false)
    private Propriedade propriedade;

    @Column(nullable = false)
    private String cultura;

    @Column(nullable = true)
    private String canalVenda;

    @ElementCollection
    @CollectionTable(
            name = "cultivo_canais_venda",
            joinColumns = @JoinColumn(name = "id_cultivo")
    )
    private List<CanalVendaCultivo> canaisVenda = new ArrayList<>();

    private Double percentualReceita;
    private Integer anoImplantacao;
    private Integer numeroPlantas;
    private Double percentualVendaCanal;
    private Integer numeroPontosVenda;
    private Double distanciaEntrega;
}

package com.projetointegrador.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    @Column(nullable = false)
    private String canalVenda;

    private Double percentualReceita;
    private Integer anoImplantacao;
    private Integer numeroPlantas;
    private Double percentualVendaCanal;
    private Integer numeroPontosVenda;
    private Double distanciaEntrega;
}

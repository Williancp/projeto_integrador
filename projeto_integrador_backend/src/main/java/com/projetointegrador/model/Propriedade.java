package com.projetointegrador.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "propriedade")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Propriedade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_propriedade")
    private Long idPropriedade;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "localidade")
    private String localidade;

    @Column(name = "cidade")
    private String cidade;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "area_total", precision = 10, scale = 2)
    private BigDecimal areaTotal;

    @Column(name = "latitude", precision = 10, scale = 7)
    private BigDecimal latitude;

    @Column(name = "longitude", precision = 10, scale = 7)
    private BigDecimal longitude;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @Column(name = "data_criacao", nullable = false, updatable = false)
    private java.time.LocalDateTime dataCriacao;

    @Column(name = "data_atualizacao")
    private java.time.LocalDateTime dataAtualizacao;

    @PrePersist
    protected void onCreate() {
        dataCriacao = java.time.LocalDateTime.now();
        dataAtualizacao = java.time.LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        dataAtualizacao = java.time.LocalDateTime.now();
    }
}

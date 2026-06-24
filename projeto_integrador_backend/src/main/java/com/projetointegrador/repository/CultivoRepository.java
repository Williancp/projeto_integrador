package com.projetointegrador.repository;

import com.projetointegrador.model.Cultivo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CultivoRepository extends JpaRepository<Cultivo, Long> {
    List<Cultivo> findByPropriedadeIdPropriedade(Long idPropriedade);
}

package com.projetointegrador.repository;

import com.projetointegrador.model.Propriedade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PropriedadeRepository extends JpaRepository<Propriedade, Long> {
    List<Propriedade> findByUsuarioIdUsuario(Long idUsuario);
}

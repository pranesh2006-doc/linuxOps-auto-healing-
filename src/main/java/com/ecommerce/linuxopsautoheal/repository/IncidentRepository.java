package com.ecommerce.linuxopsautoheal.repository;

import com.ecommerce.linuxopsautoheal.entity.Incident;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface IncidentRepository extends JpaRepository<Incident, Long> {

    List<Incident> findBySeverity(String severity);

    List<Incident> findByStatus(String status);

    List<Incident> findBySeverityAndStatus(
            String severity,
            String status
    );
}
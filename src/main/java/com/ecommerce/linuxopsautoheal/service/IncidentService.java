package com.ecommerce.linuxopsautoheal.service;

import com.ecommerce.linuxopsautoheal.dto.IncidentRequest;
import com.ecommerce.linuxopsautoheal.dto.IncidentResponse;
import com.ecommerce.linuxopsautoheal.entity.Incident;
import com.ecommerce.linuxopsautoheal.repository.IncidentRepository;
import com.ecommerce.linuxopsautoheal.exception.IncidentNotFoundException;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class IncidentService {

    private final IncidentRepository incidentRepository;

    public IncidentService(IncidentRepository incidentRepository) {
        this.incidentRepository = incidentRepository;
    }

        public IncidentResponse createIncident(IncidentRequest request) {

            Incident incident = new Incident();

            incident.setType(request.getType());
            incident.setSeverity(request.getSeverity());

            incident.setStatus(
                    request.getStatus() == null
                            ? "OPEN"
                            : request.getStatus()
            );

            incident.setSource(request.getSource());
            incident.setMessage(request.getMessage());
            incident.setCreatedAt(LocalDateTime.now());

            Incident savedIncident =
                    incidentRepository.save(incident);

            return new IncidentResponse(savedIncident);
        }

        public List<IncidentResponse> getAllIncidents() {

            return incidentRepository.findAll()
                    .stream()
                    .map(IncidentResponse::new)
                    .toList();
        }

        public IncidentResponse getIncident(Long id) {

            Incident incident = incidentRepository.findById(id)
                    .orElseThrow(() ->
                            new IncidentNotFoundException(id));

            return new IncidentResponse(incident);

    }public List<IncidentResponse> getIncidents(
        String severity,
        String status) {

    List<Incident> incidents;

    if (severity != null && status != null) {

        incidents = incidentRepository
                .findBySeverityAndStatus(severity, status);

    } else if (severity != null) {

        incidents = incidentRepository
                .findBySeverity(severity);

    } else if (status != null) {

        incidents = incidentRepository
                .findByStatus(status);

    } else {

        incidents = incidentRepository.findAll();
    }

    return incidents.stream()
            .map(IncidentResponse::new)
            .toList();
}
    public IncidentResponse updateStatus(
            Long id,
            String status) {

        Incident incident = incidentRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Incident not found"));

        incident.setStatus(status);

        Incident updatedIncident =
                incidentRepository.save(incident);

        return new IncidentResponse(updatedIncident);
    }}


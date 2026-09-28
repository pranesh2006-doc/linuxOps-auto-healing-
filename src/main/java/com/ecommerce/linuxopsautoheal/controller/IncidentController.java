package com.ecommerce.linuxopsautoheal.controller;

import com.ecommerce.linuxopsautoheal.dto.IncidentRequest;
import com.ecommerce.linuxopsautoheal.dto.IncidentResponse;
import com.ecommerce.linuxopsautoheal.service.IncidentService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/incidents")
public class IncidentController {

    private final IncidentService incidentService;

    public IncidentController(IncidentService incidentService) {
        this.incidentService = incidentService;
    }

    @PostMapping
    public ResponseEntity<IncidentResponse> createIncident(
            @Valid @RequestBody IncidentRequest request) {

        return ResponseEntity.ok(
                incidentService.createIncident(request)
        );
    }

    @GetMapping
    public ResponseEntity<List<IncidentResponse>> getIncidents(
            @RequestParam(required = false) String severity,
            @RequestParam(required = false) String status) {

        return ResponseEntity.ok(
                incidentService.getIncidents(severity, status)
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<IncidentResponse> getIncident(
            @PathVariable Long id) {

        return ResponseEntity.ok(
                incidentService.getIncident(id)
        );
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<IncidentResponse> updateStatus(
            @PathVariable Long id,
            @RequestParam String status) {

        return ResponseEntity.ok(
                incidentService.updateStatus(id, status)
        );
    }
}
package com.ecommerce.linuxopsautoheal.dto;

import com.ecommerce.linuxopsautoheal.entity.Incident;

import java.time.LocalDateTime;

public class IncidentResponse {

    private Long id;
    private String type;
    private String severity;
    private String status;
    private String source;
    private String message;
    private LocalDateTime createdAt;

    public IncidentResponse(Incident incident) {
        this.id = incident.getId();
        this.type = incident.getType();
        this.severity = incident.getSeverity();
        this.status = incident.getStatus();
        this.source = incident.getSource();
        this.message = incident.getMessage();
        this.createdAt = incident.getCreatedAt();
    }

    public Long getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public String getSeverity() {
        return severity;
    }

    public String getStatus() {
        return status;
    }

    public String getSource() {
        return source;
    }

    public String getMessage() {
        return message;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
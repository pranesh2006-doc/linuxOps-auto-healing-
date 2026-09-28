package com.ecommerce.linuxopsautoheal.dto;

import jakarta.validation.constraints.NotBlank;

public class IncidentRequest {

    @NotBlank
    private String type;

    @NotBlank
    private String severity;

    private String status;

    private String source;

    @NotBlank
    private String message;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
package com.ecommerce.linuxopsautoheal.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(IncidentNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleIncidentNotFound(
            IncidentNotFoundException exception) {

        Map<String, Object> response = Map.of(
                "timestamp", LocalDateTime.now(),
                "status", 404,
                "error", "NOT_FOUND",
                "message", exception.getMessage()
        );

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(response);
    }
}
#!/bin/bash

# ==========================================
# LinuxOps - System Monitoring Agent
# Day 2: CPU, Memory, Disk Monitoring
# ==========================================

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=85

# Monitoring interval in seconds
INTERVAL=5

while true
do

    clear

    echo "=========================================="
    echo "          LinuxOps Monitor"
    echo "=========================================="
    echo "Time: $(date)"
    echo ""

    # ----------------------------------------
    # CPU Usage
    # ----------------------------------------

    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

    echo "CPU Usage     : ${CPU_USAGE}%"

    # CPU threshold detection
    if awk "BEGIN {exit !($CPU_USAGE > $CPU_THRESHOLD)}"
    then
        echo "⚠️  WARNING: HIGH CPU USAGE"
    else
        echo "Status        : NORMAL"
    fi

    echo ""

    # ----------------------------------------
    # Memory Usage
    # ----------------------------------------

    MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2)*100}')

    echo "Memory Usage  : ${MEMORY_USAGE}%"

    # Memory threshold detection
    if awk "BEGIN {exit !($MEMORY_USAGE > $MEMORY_THRESHOLD)}"
    then
        echo "⚠️  WARNING: HIGH MEMORY USAGE"
    else
        echo "Status        : NORMAL"
    fi

    echo ""

    # ----------------------------------------
    # Disk Usage
    # ----------------------------------------

    DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    echo "Disk Usage    : ${DISK_USAGE}%"

    # Disk threshold detection
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]
    then
        echo "⚠️  WARNING: HIGH DISK USAGE"
    else
        echo "Status        : NORMAL"
    fi

    echo ""

    # ----------------------------------------
    # Load Average
    # ----------------------------------------

    LOAD_AVERAGE=$(awk '{print $1}' /proc/loadavg)

    echo "Load Average  : ${LOAD_AVERAGE}"

    echo ""

    # ----------------------------------------
    # System Information
    # ----------------------------------------

    echo "Hostname      : $(hostname)"
    echo "Uptime        : $(uptime -p)"

    echo ""

    echo "=========================================="
    echo "Next check in ${INTERVAL} seconds..."
    echo "Press Ctrl+C to stop"
    echo "=========================================="

    sleep "$INTERVAL"

done

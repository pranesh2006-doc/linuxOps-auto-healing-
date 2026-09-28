#!/bin/bash

PROJECT_DIR="$HOME/linuxOps-auto-healing-"
LOG_DIR="$PROJECT_DIR/logs"

LOG_FILE="$LOG_DIR/agent.log"
INCIDENT_LOG="$LOG_DIR/incidents.log"

echo "LinuxOps Agent Started"

while true
do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.2f", ($3/$2)*100}')
    DISK_USAGE=$(df / | awk 'NR==2 {print $5}')
    LOAD_AVERAGE=$(awk '{print $1}' /proc/loadavg)

    echo "$TIMESTAMP | CPU=$CPU_USAGE% | MEMORY=$MEMORY_USAGE% | DISK=$DISK_USAGE | LOAD=$LOAD_AVERAGE" >> "$LOG_FILE"

    # Check Nginx
    if systemctl is-active --quiet nginx
    then
        echo "$TIMESTAMP | nginx=RUNNING" >> "$LOG_FILE"
    else
        echo "$TIMESTAMP | nginx=DOWN" >> "$LOG_FILE"

        echo "$TIMESTAMP | nginx | DOWN | AUTO-HEALING_TRIGGERED" >> "$INCIDENT_LOG"

        "$PROJECT_DIR/linuxOps-agent/auto-heal-nginx.sh"

    # Wait before checking again
    sleep 30
fi
done


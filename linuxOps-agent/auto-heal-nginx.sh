#!/bin/bash

SERVICE="nginx"

PROJECT_DIR="$HOME/linuxOps-auto-healing-"
LOG_FILE="$PROJECT_DIR/logs/incidents.log"

MAX_RETRIES=2
RETRY_DELAY=5

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "===================================="
echo "       LinuxOps Auto-Healing"
echo "===================================="

# Check if service is already running
if systemctl is-active --quiet "$SERVICE"
then
    echo "Service : $SERVICE"
    echo "Status  : RUNNING"
    echo "Action  : No recovery needed"
    echo "===================================="
    exit 0
fi

echo "Service : $SERVICE"
echo "Status  : DOWN"

echo "$TIMESTAMP | $SERVICE | DOWN | RECOVERY_STARTED" >> "$LOG_FILE"

# Recovery attempts
for ((ATTEMPT=1; ATTEMPT<=MAX_RETRIES; ATTEMPT++))
do

    echo "Recovery Attempt : $ATTEMPT/$MAX_RETRIES"

    echo "$TIMESTAMP | $SERVICE | RECOVERY_ATTEMPT=$ATTEMPT" >> "$LOG_FILE"

    sudo systemctl restart "$SERVICE"

    sleep 2

    # Service health check
    if systemctl is-active --quiet "$SERVICE" && curl -fsS http://localhost > /dev/null
    then
        echo "Status  : RECOVERED"

        echo "$(date '+%Y-%m-%d %H:%M:%S') | $SERVICE | RECOVERED | ATTEMPT=$ATTEMPT" >> "$LOG_FILE"

        echo "===================================="

        exit 0
    fi

    echo "Recovery attempt $ATTEMPT failed"

    if [ "$ATTEMPT" -lt "$MAX_RETRIES" ]
    then
        echo "Waiting $RETRY_DELAY seconds before retry..."
        sleep "$RETRY_DELAY"
    fi

done

# All attempts failed
echo "Status  : RECOVERY FAILED"

echo "$(date '+%Y-%m-%d %H:%M:%S') | $SERVICE | RECOVERY_FAILED | ALERT_REQUIRED" >> "$LOG_FILE"

echo "===================================="

exit 1

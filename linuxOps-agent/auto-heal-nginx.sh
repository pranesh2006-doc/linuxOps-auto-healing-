#!/bin/bash

SERVICE="nginx"
LOG_FILE="../logs/incidents.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "===================================="
echo "       LinuxOps Auto-Healing"
echo "===================================="

# Check whether nginx is running
if systemctl is-active --quiet "$SERVICE"
then
    echo "Service : $SERVICE"
    echo "Status  : RUNNING"
    echo "Action  : No recovery needed"
    echo "===================================="
    exit 0
fi

# Service is down
echo "Service : $SERVICE"
echo "Status  : DOWN"
echo "Action  : Restarting $SERVICE"

echo "$TIMESTAMP | $SERVICE | DOWN | RECOVERY_ATTEMPTED" >> "$LOG_FILE"

# Restart service
sudo systemctl restart "$SERVICE"

# Give nginx time to start
sleep 2

# Verify recovery
if systemctl is-active --quiet "$SERVICE" && curl -fsS http://localhost > /dev/null
then
    echo "Status  : RECOVERED"
    echo "$TIMESTAMP | $SERVICE | RECOVERED" >> "$LOG_FILE"
else
    echo "Status  : RECOVERY FAILED"
    echo "$TIMESTAMP | $SERVICE | RECOVERY_FAILED" >> "$LOG_FILE"
fi

echo "===================================="

#!/bin/bash

SERVICE=$1

if [ -z "$SERVICE" ]
then
    echo "Usage: $0 <service-name>"
    exit 1
fi

echo "===================================="
echo "       LinuxOps Service Monitor"
echo "===================================="

if systemctl is-active --quiet "$SERVICE"
then
    echo "Service : $SERVICE"
    echo "Status  : UP"
else
    echo "Service : $SERVICE"
    echo "Status  : DOWN"
fi

echo "===================================="

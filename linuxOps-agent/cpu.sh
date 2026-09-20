#!/bin/bash

echo "===== CPU Monitoring ====="

top -bn1 | grep "Cpu(s)"

echo "=========================="

#!/bin/bash

echo "===================================="
echo "       LinuxOps Process Monitor"
echo "===================================="

echo ""
echo "Top 10 CPU-consuming processes:"
echo ""

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -11

echo ""
echo "===================================="

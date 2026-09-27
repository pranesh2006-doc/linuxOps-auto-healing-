#!/bin/bash

PROCESS=$1

if pgrep "$PROCESS" > /dev/null
then
    echo "$PROCESS is RUNNING"
else
    echo "$PROCESS is NOT RUNNING"
fi

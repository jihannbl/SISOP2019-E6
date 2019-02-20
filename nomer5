#!/bin/bash

cat /var/log/syslog | awk 'BEGIN {IGNORECASE = 1} /cron/ && !/sudo/ {print}' | awk 'NF < 13'

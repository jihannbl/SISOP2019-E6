#!/bin/bash

cat /var/log/syslog | awk 'BEGIN {IGNORECASE = 1} /cron/ && !/sudo/ {print}' | awk 'NF < 13'

crontab
2-30/6 * * * * /home/jihan/nomer5.sh >> /home/jihan/modul1/nomer5.log 2>&1

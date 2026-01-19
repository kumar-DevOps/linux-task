#!/bin/bash
echo "===== System Report: $(date) =====" >> /var/log/system_report.log
htop -b -n 1 >> /var/log/system_report.log
df -h >> /var/log/system_report.log
ps aux --sort=-%cpu | head -n 10 >> /var/log/system_report.log
ps aux --sort=-%mem | head -n 10 >> /var/log/system_report.log

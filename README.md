README - System Administration Tasks

This README provides instructions and verification steps for three system administration tasks: System Monitoring Setup, User Management and Access Control, and Backup Configuration for Web Servers.

Task 1: System Monitoring Setup

Objective

Configure monitoring tools to track system health, performance, and capacity.

Steps

Install monitoring tools:

sudo apt-get install htop nmon -y

Monitor disk usage:

df -h > /var/log/disk_usage.log
du -sh /home/* >> /var/log/disk_usage.log

Monitor processes:

ps aux --sort=-%cpu | head -n 10 > /var/log/top_processes.log
ps aux --sort=-%mem | head -n 10 >> /var/log/top_processes.log

Create reporting script /usr/local/bin/system_report.sh to log metrics.

Schedule cron job:

crontab -e
0 9 * * * /usr/local/bin/system_report.sh

Verification

Check logs: /var/log/system_report.log, /var/log/disk_usage.log, /var/log/top_processes.log.

Screenshots of htop and nmon outputs.

Task 2: User Management and Access Control

Objective

Create secure user accounts and enforce password policies.

Steps

Create users:

sudo adduser Sarah
sudo adduser Mike

Set passwords:

sudo passwd Sarah
sudo passwd Mike

Create isolated directories:

mkdir -p /home/Sarah/workspace
mkdir -p /home/mike/workspace
chown Sarah:Sarah /home/Sarah/workspace
chown Mike:Mike /home/mike/workspace
chmod 700 /home/Sarah/workspace
chmod 700 /home/mike/workspace

Configure password policy in /etc/login.defs:

PASS_MAX_DAYS   30
PASS_MIN_DAYS   1
PASS_WARN_AGE   7

Enforce complexity in /etc/pam.d/common-password:

password requisite pam_pwquality.so retry=3 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1

Verification

Run ls -ld /home/Sarah/workspace /home/mike/workspace to confirm permissions.

Run chage -l Sarah and chage -l Mike to confirm password expiry.

Screenshots of denied access attempts between users.

Task 3: Backup Configuration for Web Servers

Objective

Automate backups for Apache and Nginx servers.

Steps

Create Apache backup script /usr/local/bin/apache_backup.sh:

#!/bin/bash
DATE=$(date +%F)
mkdir -p /backups
tar -czf /backups/apache_backup_$DATE.tar.gz /etc/httpd/ /var/www/html/
tar -tzf /backups/apache_backup_$DATE.tar.gz > /backups/apache_backup_$DATE.log

Create Nginx backup script /usr/local/bin/nginx_backup.sh:

#!/bin/bash
DATE=$(date +%F)
mkdir -p /backups
tar -czf /backups/nginx_backup_$DATE.tar.gz /etc/nginx/ /usr/share/nginx/html/
tar -tzf /backups/nginx_backup_$DATE.tar.gz > /backups/nginx_backup_$DATE.log

Make scripts executable:

chmod +x /usr/local/bin/apache_backup.sh
chmod +x /usr/local/bin/nginx_backup.sh

Schedule cron jobs:

crontab -e
0 0 * * 2 /usr/local/bin/apache_backup.sh
0 0 * * 2 /usr/local/bin/nginx_backup.sh

Verification

Check /backups/ directory for .tar.gz files.

Check .log files for archive contents.

Screenshots of cron job entries and backup verification logs.

Deliverables

Screenshots of terminal outputs for each task.

Log files showing monitoring and backup verification.

Backup files in /backups/.

Summary of challenges encountered during implementation.

Notes

Ensure /backups/ directory exists before running scripts.

Monitor log file sizes to prevent disk space issues.

Test password policies with weak passwords to confirm enforcement.

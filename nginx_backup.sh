#!/bin/bash
DATE=$(date +%F)
tar -czf /backups/nginx_backup_$DATE.tar.gz /etc/nginx/ /usr/share/nginx/html/
tar -tzf /backups/nginx_backup_$DATE.tar.gz > /backups/nginx_backup_$DATE.log

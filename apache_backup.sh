#!/bin/bash
DATE=$(date +%F)
tar -czf /backups/apache_backup_$DATE.tar.gz /etc/httpd/ /var/www/html/
tar -tzf /backups/apache_backup_$DATE.tar.gz > /backups/apache_backup_$DATE.log

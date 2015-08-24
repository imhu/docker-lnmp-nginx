#!/bin/bash
sed -i "s/%fpm-ip%/$FPM_PORT_9000_TCP_ADDR/" /etc/nginx/nginx.conf
FILELIST=`cd /etc/nginx/sites-available && ls *.conf`
for loop in $FILELIST        
do                                    
    ln -s /etc/nginx/sites-available/$loop /etc/nginx/sites-enabled/$loop
done
exec /usr/sbin/nginx

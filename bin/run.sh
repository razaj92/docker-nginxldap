#!/bin/sh
set -e

cat /nginx.conf | envsubst > /etc/nginx/nginx.conf

exec dockerize -stdout /var/log/nginx/access.log -stderr /var/log/nginx/error.log /usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off;"

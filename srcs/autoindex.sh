#!/bin/bash

if grep -q "autoindex off;" /etc/nginx/sites-available/nginx.conf
then sed -i '/autoindex/s/off;/on;/' /etc/nginx/sites-available/nginx.conf
else sed -i '/autoindex/s/on;/off;/' /etc/nginx/sites-available/nginx.conf
fi
service nginx reload
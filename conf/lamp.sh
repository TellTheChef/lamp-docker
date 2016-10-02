#!/bin/bash

tail -f /var/log/apache2/*.log /var/log/apache2/website.err
source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND
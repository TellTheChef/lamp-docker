#!/bin/bash

service filebeat start
source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND
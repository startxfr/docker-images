#!/bin/bash
rm -rf /run/httpd/*
exec /usr/sbin/apachectl -D FOREGROUND
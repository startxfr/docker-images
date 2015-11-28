#!/bin/bash

function check_httpd_environment {
    if [ ! -v SERVER_NAME ]; then
        SERVER_NAME="localhost"
        export SERVER_NAME
        echo "! WARNING : environment var SERVER_NAME is missing..."
        echo "! WARNING : auto-assigned value : $SERVER_NAME"
    fi
    if [ ! -v DOCROOT ]; then
        DOCROOT="/data/www"
        export DOCROOT
        echo "! WARNING : environment var DOCROOT is missing..."
        echo "! WARNING : auto-assigned value : $DOCROOT"
    fi
}

function display_container_httpd_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| ServerName  : $SERVER_NAME"
    fi
    echo "+====================================================="
}

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN APACHE CONFIGURATION"
    mkdir -p /var/run/httpd
    if [ -v DOCROOT ]; then
        echo "=> Set DocumentRoot to $DOCROOT in $HTTPDCONF"
        echo "DocumentRoot \"$DOCROOT\"" >> $HTTPDCONF
    fi
    if [ -v SERVER_NAME ]; then
        echo "=> Set ServerName to $SERVER_NAME in $HTTPDCONF"
        echo "ServerName \"$SERVER_NAME\"" >> $HTTPDCONF
    fi
}

# End configuration process just before starting daemon
function end_config {
    stop_server
    echo "=> END APACHE CONFIGURATION"
}

# Start the httpd server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "=> Starting httpd server"
    /usr/sbin/apachectl &
    sleep 2
}

# Stop the httpd server running in background. 
function stop_server {
    echo "=> Stopping httpd server ..."
    killall httpd
    rm -rf /run/httpd/*
    sleep 2
}

# Start the httpd server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting httpd daemon ..."
    exec /usr/sbin/apachectl -D FOREGROUND
}

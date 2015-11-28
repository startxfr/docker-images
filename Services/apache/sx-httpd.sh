#!/bin/bash

function check_httpd_environment {
    if [ ! -v SERVER_NAME ]; then
        export SERVER_NAME=$CONTAINER_NAME
    fi
}

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN APACHE CONFIGURATION"
    mkdir -p /var/run/httpd
    if [ -v DOCROOT ]; then
        echo "=> Changing document root to $DOCROOT"
        ${DOCROOT=/data/www}
        echo "DocumentRoot \"$DOCROOT\"" >> $HTTPDCONF
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

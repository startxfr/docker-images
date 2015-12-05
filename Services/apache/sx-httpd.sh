#!/bin/bash

function check_httpd_environment {
    check_environment
    if [ ! -v SERVER_NAME ]; then
        SERVER_NAME="localhost"
        export SERVER_NAME
        echo "! WARNING : environment var SERVER_NAME is missing..."
        echo "! WARNING : auto-assigned value : $SERVER_NAME"
    fi
    if [ ! -v APP_PATH ]; then
        APP_PATH="/data/apache"
        export APP_PATH
        DOC_ROOT=$APP_PATH
        export DOC_ROOT
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/data/logs/apache"
        export LOG_PATH
    fi
}

function display_container_httpd_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : $(httpd -v | head -1)" 
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v SERVER_NAME ]; then
        echo "| ServerName  : $SERVER_NAME"
    fi
    if [ -v APP_PATH ]; then
        echo "| App path    : $APP_PATH"
    fi
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    echo "+====================================================="
}

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN APACHE CONFIGURATION"
}

# End configuration process just before starting daemon
function end_config {
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
    echo "=> Starting httpd daemon ..." | tee -a $STARTUPLOG
    display_container_started | tee -a $STARTUPLOG
    exec /usr/sbin/apachectl -D FOREGROUND
}

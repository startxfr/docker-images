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
        APP_PATH="/app"
        export APP_PATH
    fi
    if [ ! -v DATA_PATH ]; then
        DATA_PATH="/data"
        export DATA_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/logs"
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
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v SERVER_NAME ]; then
        echo "| ServerName  : $SERVER_NAME"
    fi
    if [ -v APP_PATH ]; then
        echo "| App path    : $APP_PATH"
    fi
    if [ -v DATA_PATH ]; then
        echo "| Data path   : $DATA_PATH"
    fi
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    echo "+====================================================="
}

function stop_httpd_handler {
    killall httpd
    rm -rf /run/httpd/*
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now STOPPED" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    exit 143; # 128 + 15 -- SIGTERM
}


# Start the httpd server as a deamon and execute it inside 
# the running shell
function start_service_httpd {
    trap 'kill ${!}; stop_httpd_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now RUNNING" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    rm -rf /run/httpd/* /tmp/httpd*
    exec /usr/sbin/httpd -D FOREGROUND &
    while true
    do
      tail -f /dev/null & wait ${!}
    done
}

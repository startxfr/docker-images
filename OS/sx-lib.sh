#!/bin/bash

export TERM=xterm
pid=0

function check_environment {
    if [ ! -v CONTAINER_TYPE ]; then
        CONTAINER_TYPE="unknown"
        export CONTAINER_TYPE
        echo "! WARNING : environment var CONTAINER_TYPE is missing..."
        echo "! WARNING : auto-assigned value : $CONTAINER_TYPE"
    fi
    if [ ! -v CONTAINER_SERVICE ]; then
        CONTAINER_SERVICE=$CONTAINER_TYPE;
        export CONTAINER_SERVICE;
        echo "! WARNING : environment var CONTAINER_SERVICE is missing..."
        echo "! WARNING : auto-assigned value : $CONTAINER_SERVICE"
    fi
    if [ ! -v CONTAINER_INSTANCE ]; then
        CONTAINER_INSTANCE=$CONTAINER_TYPE "_" $CONTAINER_SERVICE;
        export CONTAINER_INSTANCE;
        echo "! WARNING : environment var CONTAINER_INSTANCE is missing..."
        echo "! WARNING : auto-assigned value : $CONTAINER_INSTANCE"
    fi
}

function display_container_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    echo "+====================================================="
}

function stop_handler {
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now STOPPED" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    if [ $pid -ne 0 ]; then
        kill -SIGTERM "$pid"
        wait "$pid"
    fi
    exit 143; # 128 + 15 -- SIGTERM
}

function start_service {
    trap 'kill ${!}; stop_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now RUNNING" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    tail -f /dev/null &
    pid="$!"
    while true
    do
      tail -f /dev/null & wait ${!}
    done
}

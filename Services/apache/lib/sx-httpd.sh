#!/bin/bash

function check_httpd_environment {
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
    if [ ! -v SERVER_NAME ]; then
        SERVER_NAME="localhost"
        export SERVER_NAME
    fi
}

function displayApacheInformation {
    displayInformation $1 
    echo $1 "version   : $SX_VERSION"
    echo $1 "app path  : $APP_PATH"
    echo $1 "log path  : $LOG_PATH"
    echo $1 "data path : $DATA_PATH"
}

function apachePreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayApacheInformation "| "
    echo "+====================================================="
}

function apachePostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayApacheInformation "| "
    echo "+====================================================="
}

function apachePostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayApacheInformation "| "
    echo "+====================================================="
}

function apacheAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayApacheInformation "| "
    echo "+====================================================="
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy source from /tmp/src > $APP_PATH"
    cp -R /tmp/src/* $APP_PATH/
    rm -rf /tmp/src
}

function apacheRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayApacheInformation "| "
    echo "+====================================================="
    start_service_httpd
}

function stop_httpd_handler {
    killall httpd
    rm -rf /run/httpd/*
    echo "+====================================================="
    echo "| Container $HOSTNAME is now STOPPED"
    echo "+====================================================="
    exit 143; # 128 + 15 -- SIGTERM
}


# Start the httpd server as a deamon and execute it inside 
# the running shell
function start_service_httpd {
    trap 'kill ${!}; stop_httpd_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    rm -rf /run/httpd/* /tmp/httpd*
    exec /usr/sbin/httpd -D FOREGROUND &
    while true
    do
        tail -f $LOG_PATH/access.log & wait ${!}
    done
}



# set env var $2 (val $3) in file $1
function setEnvironmentVariableInFile {
    if [ -z "$3" ]; then
            echo "Environment variable '$2' not set."
            return
    fi
    echo "SetEnv $2 $3" >> $1
}


function setSys2HttpEnvironmentVariable {
    echo "adding environement to $1"
    echo "" >> $1
    for _curVar in `env | awk -F = '{print $1}'`;do
        setEnvironmentVariableInFile $1 ${_curVar} ${!_curVar}
    done
}
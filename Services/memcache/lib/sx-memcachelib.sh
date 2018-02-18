#!/bin/bash

function check_memcache_environment {
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/logs"
        export LOG_PATH
    fi
}

function displayMemcacheInformation {
    displayInformation $1 
    echo $1 "log path  : $LOG_PATH"
    echo $1 "memcache  : $(memcached -h | head -1)" 
}

function memcachePreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayMemcacheInformation "| "
    echo "+====================================================="
    echo "Create log directory $LOG_PATH"
    touch $LOG_PATH/access.log
    chown 1001:0 -R $LOG_PATH
    chmod g=u -R $LOG_PATH
}

function memcachePostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayMemcacheInformation "| "
    echo "+====================================================="
}

function memcachePostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayMemcacheInformation "| "
    echo "+====================================================="
}

function memcacheAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayMemcacheInformation "| "
    echo "+====================================================="
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy source from /tmp/src > $APP_PATH"
    cp -R /tmp/src/* $APP_PATH/
    rm -rf /tmp/src
}

function memcacheRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayMemcacheInformation "| "
    echo "+====================================================="
    start_service_memcache
}

function stop_memcache_handler {
    killall memcached
    echo "+====================================================="
    echo "| Container $HOSTNAME is now STOPPED"
    echo "+====================================================="
    exit 143; # 128 + 15 -- SIGTERM
}


# Start the memcache server as a deamon and execute it inside 
# the running shell
function start_service_memcache {
    trap 'kill ${!}; stop_memcache_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    exec memcached -u daemon -v
}
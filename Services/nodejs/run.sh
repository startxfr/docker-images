#!/bin/bash
source /bin/sx-lib.sh


function check_nodejs_environment {
    check_environment
    if [ ! -v APP_PATH ]; then
        APP_PATH="/data/nodejs"
        export APP_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/data/logs/nodejs"
        export LOG_PATH
    fi
}

function display_container_nodejs_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : $(node -v | head -1)" 
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
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
    echo "=> BEGIN NODEJS CONFIGURATION"
}

# End configuration process just before starting daemon
function end_config {
    echo "=> END NODEJS CONFIGURATION"
}

# Start the nodejs executable with application entrypoint
# the running shell
function start_daemon {
    echo "=> Starting nodejs daemon ..."
    display_container_started
    exec node $APP_MAIN
}

if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_nodejs_environment | tee -a $STARTUPLOG
display_container_nodejs_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_daemon | tee -a $STARTUPLOG

#!/bin/bash
source /bin/sx-lib.sh

function check_mariadb_environment {
    check_environment
    if [ ! -v SERVER_NAME ]; then
        SERVER_NAME="localhost"
        export SERVER_NAME
        echo "! WARNING : environment var SERVER_NAME is missing..."
        echo "! WARNING : auto-assigned value : $SERVER_NAME"
    fi
    if [ ! -v DOC_ROOT ]; then
        DOC_ROOT="/data/apache"
        export DOC_ROOT
    fi
    if [ ! -v APP_PATH ]; then
        APP_PATH="/data/apache"
        export APP_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/data/logs/apache"
        export LOG_PATH
    fi
}

function display_container_mariadb_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : " mysql -V
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
    if [ -v APP_PATH ]; then
        echo "| Data path   : $DATA_PATH"
    fi
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    if [ -v LOADSQL_PATH ]; then
        echo "| sql path    : $LOADSQL_PATH"
    fi
    echo "+====================================================="
}


# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN MARIADB CONFIGURATION"
}

# End configuration process just before starting daemon
function end_config {
    echo "=> END MARIADB CONFIGURATION"
}

# Start the mariadb server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting mariadb daemon ..."
    display_container_started
    exec mysqld_safe
}


if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_mariadb_environment | tee -a $STARTUPLOG
display_container_mariadb_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
display_container_started | tee -a $STARTUPLOG
start_daemon | tee -a $STARTUPLOG

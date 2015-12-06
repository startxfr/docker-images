#!/bin/bash
source /bin/sx-lib.sh

function check_mongodb_environment {
    check_environment
    if [ ! -v APP_PATH ]; then
        APP_PATH="/data/mongodb"
        export APP_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/data/logs/mongodb"
        export LOG_PATH
    fi
}

function display_container_mongodb_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : $(mongo --version | head -1)" 
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v DATA_PATH ]; then
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
    echo "=> BEGIN MONGODB CONFIGURATION"
    if [[ ! -d $DATA_PATH ]]; then
        echo "log directory $DATA_PATH not found"
        mkdir -p $DATA_PATH; chmod 0774 $DATA_PATH
        echo "data directory $DATA_PATH CREATED"
    else 
        echo "data directory $DATA_PATH EXIST"
    fi
    if [[ ! -d $LOG_PATH ]]; then
        echo "log directory $LOG_PATH not found"
        mkdir -p $LOG_PATH; chmod 0774 $LOG_PATH
        echo "log directory $LOG_PATH CREATED"
    else 
        echo "log directory $LOG_PATH EXIST"
    fi
    chmod 0774 $DATA_PATH $LOG_PATH; 
    chown mongodb:mongodb $DATA_PATH $LOG_PATH; 
}



# End configuration process just before starting daemon
function end_config {
    echo "=> END MONGODB CONFIGURATION"
}

# Start the mongodb server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting mongodb daemon ..." | tee -a $STARTUPLOG
    su mongodb
    display_container_started | tee -a $STARTUPLOG
    /usr/bin/mongod --logappend --logpath $LOG_PATH/mongodb.log --dbpath $DATA_PATH --journal --fork
    exec tail -f $LOG_PATH/mongodb.log 
}


if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_mongodb_environment | tee -a $STARTUPLOG
display_container_mongodb_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_daemon

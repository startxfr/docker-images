#!/bin/bash
source /bin/sx-lib.sh


function display_container_couchbase_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : $(/opt/couchbase/bin/couchbase-server --version)" 
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    echo "+====================================================="
}


# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN COUCHBASE CONFIGURATION"
    if [[ ! -d $LOG_PATH ]]; then
        echo "log directory $LOG_PATH not found"
        mkdir -p $LOG_PATH;
        echo "log directory $LOG_PATH CREATED"
    else 
        echo "log directory $LOG_PATH EXIST"
    fi
    chmod 0774 $LOG_PATH; 
    if [[ ! -d $DATA_PATH/lib ]]; then
        echo "Initialize Couchbase $DATA_PATH directory"
        mkdir -p $DATA_PATH/lib/couchbase \
            $DATA_PATH/lib/couchbase/config \
            $DATA_PATH/lib/couchbase/data \
            $DATA_PATH/lib/couchbase/stats \
            $DATA_PATH/lib/couchbase/logs \
            $DATA_PATH/lib/moxi
        chown -R couchbase:couchbase $DATA_PATH
        echo "log directory $LOG_PATH CREATED"
    fi
}

# End configuration process just before starting daemon
function end_config {
    echo "=> END COUCHBASE CONFIGURATION"
}

function stop_couchbase_handler {
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now STOPPED" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    if [ $pid -ne 0 ]; then
        kill -SIGTERM "$pid"
        wait "$pid"
    fi
    exit 143; # 128 + 15 -- SIGTERM
}

# Start the couchbase server as a deamon and execute it inside 
# the running shell
function start_service_couchbase {
    trap 'kill ${!}; stop_couchbase_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now RUNNING" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
#    exec couchbase -u daemon -v
    exec tail -f /dev/null  &
    while true
    do
      tail -f /dev/null & wait ${!}
    done
}

check_environment | tee -a $STARTUPLOG
display_container_couchbase_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_service_couchbase

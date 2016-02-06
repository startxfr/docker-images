#!/bin/bash
source /bin/sx-lib.sh


function display_container_ooconv_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Connector   : $(unoconv --version | head -1)" 
    echo "| Engine      : $(unoconv --version | tail -1)" 
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
    echo "=> BEGIN OOCONV CONFIGURATION"
    if [[ ! -d $LOG_PATH ]]; then
        echo "log directory $LOG_PATH not found"
        mkdir -p $LOG_PATH;
        echo "log directory $LOG_PATH CREATED"
    else 
        echo "log directory $LOG_PATH EXIST"
    fi
    chmod 0774 $LOG_PATH; 
}

# End configuration process just before starting daemon
function end_config {
    echo "=> END OOCONV CONFIGURATION"
}

function stop_ooconv_handler {
    killall unoconv soffice.bin 
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now STOPPED" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    exit 143; # 128 + 15 -- SIGTERM
}

# Start the ooconv server as a deamon and execute it inside 
# the running shell
function start_service_ooconv {
    trap 'kill ${!}; stop_ooconv_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    echo "+=====================================================" | tee -a $STARTUPLOG
    echo "| Container $HOSTNAME is now RUNNING" | tee -a $STARTUPLOG
    echo "+=====================================================" | tee -a $STARTUPLOG
    unoconv --listener -vvv | tee -a $STARTUPLOG
    killall unoconv soffice.bin 
    exec unoconv --listener
}

check_environment | tee -a $STARTUPLOG
display_container_ooconv_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_service_ooconv

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

# Start the ooconv server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting ooconv daemon ..." | tee -a $STARTUPLOG
    display_container_started | tee -a $STARTUPLOG
    exec unoconv --listener
}


if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_environment | tee -a $STARTUPLOG
display_container_ooconv_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_daemon

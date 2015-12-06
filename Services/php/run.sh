#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

function display_container_php_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| HTTP engine : $(httpd -v | head -1)" 
    echo "| PHP engine  : $(php --version | head -1)" 
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
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    echo "+====================================================="
}

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_php_config {
    echo "=> BEGIN APACHE + PHP CONFIGURATION"
}

# End configuration process just before starting daemon
function end_php_config {
    echo "=> END APACHE + PHP CONFIGURATION"
}

check_httpd_environment | tee -a $STARTUPLOG
display_container_php_header | tee -a $STARTUPLOG
begin_php_config | tee -a $STARTUPLOG
end_php_config | tee -a $STARTUPLOG
start_daemon

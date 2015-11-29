#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_httpd_environment | tee -a $STARTUPLOG
display_container_httpd_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
display_container_started | tee -a $STARTUPLOG
start_daemon

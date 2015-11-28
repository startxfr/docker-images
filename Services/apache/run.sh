#!/bin/bash
export HTTPDCONF=/etc/httpd/conf.d/app.conf

source /bin/sx-lib.sh
source /bin/sx-httpd.sh

if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_environment
check_httpd_environment
display_container_header
begin_config
end_config
start_daemon
display_container_started

#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

check_httpd_environment | tee -a $STARTUPLOG
display_container_httpd_header | tee -a $STARTUPLOG
start_service_httpd

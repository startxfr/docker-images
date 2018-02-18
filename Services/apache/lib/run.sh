#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

check_httpd_environment
# Dispatch input arguments
case $1 in
    start)                  start_service_httpd;;
    info)                   displayApacheInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
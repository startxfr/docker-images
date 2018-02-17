#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

check_httpd_environment
display_container_httpd_header

# Dispatch input arguments
case $1 in
    start)                  start_service_httpd;;
    info)                   displayInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
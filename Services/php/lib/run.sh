#!/bin/bash
source /bin/sx-php.sh

check_httpd_environment
display_container_php_header

# Dispatch input arguments
case $1 in
    start)                  start_service_httpd;;
    info)                   displayInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac

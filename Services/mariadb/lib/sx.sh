#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-mysql.sh

check_mariadb_environment
# Dispatch input arguments
case $1 in
    init)                   init_service_mariadb;;
    start)                  start_service_mariadb;;
    info)                   displayMysqlInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
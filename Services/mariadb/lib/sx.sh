#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-mysql.sh

check_mariadb_environment
# Dispatch input arguments
case $1 in
    assemble)               mysqlAssemble $@ ;;
    post-build)             mysqlPostBuild $@ ;;
    pre-deploy)             mysqlPreDeploy $@ ;;
    post-deploy)            mysqlPostDeploy $@ ;;
    run)                    mysqlRun $@ ;;
    health)                 displayHealth $@ ;;
    info)                   displayMysqlInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
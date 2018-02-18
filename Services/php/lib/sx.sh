#!/bin/bash
source /bin/sx-phplib.sh

check_httpd_environment
# Dispatch input arguments
case $1 in
    assemble)               phpAssemble $@ ;;
    post-build)             phpPostBuild $@ ;;
    pre-deploy)             phpPreDeploy $@ ;;
    post-deploy)            phpPostDeploy $@ ;;
    run)                    phpRun $@ ;;
    health)                 displayHealth $@ ;;
    info)                   displayInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac

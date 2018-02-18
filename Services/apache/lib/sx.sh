#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

check_httpd_environment
# Dispatch input arguments
case $1 in
    assemble)               apacheAssemble $@ ;;
    post-build)             apachePostBuild $@ ;;
    pre-deploy)             apachePreDeploy $@ ;;
    post-deploy)            apachePostDeploy $@ ;;
    run)                    apacheRun $@ ;;
    health)                 displayHealth $@ ;;
    info)                   displayApacheInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
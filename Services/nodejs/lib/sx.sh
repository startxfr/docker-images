#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-nodelib.sh

check_nodejs_environment
# Dispatch input arguments
case $1 in
    assemble)               nodejsAssemble $@ ;;
    post-build)             nodejsPostBuild $@ ;;
    pre-deploy)             nodejsPreDeploy $@ ;;
    post-deploy)            nodejsPostDeploy $@ ;;
    run)                    nodejsRun $@ ;;
    health)                 displayHealth $@ ;;
    info)                   displayNodejsInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
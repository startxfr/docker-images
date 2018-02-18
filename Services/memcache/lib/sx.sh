#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-memcachelib.sh

check_memcache_environment
# Dispatch input arguments
case $1 in
    assemble)               memcacheAssemble $@ ;;
    post-build)             memcachePostBuild $@ ;;
    pre-deploy)             memcachePreDeploy $@ ;;
    post-deploy)            memcachePostDeploy $@ ;;
    run)                    memcacheRun $@ ;;
    health)                 displayHealth $@ ;;
    info)                   displayMemcacheInformation $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
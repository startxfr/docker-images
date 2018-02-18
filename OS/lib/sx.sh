#!/bin/bash
source /bin/sx-lib.sh

# Dispatch input arguments
case $1 in
    assemble)               genericAssemble $@ ;;
    post-build)             genericPostBuild $@ ;;
    pre-deploy)             genericPreDeploy $@ ;;
    post-deploy)            genericPostDeploy $@ ;;
    run)                    genericRun $@ ;;
    health)                 displayHealth $@ ;;
    usage|help|--help)      displayUsage $@ ;;
    usageS2i)               displayUsageS2I $@ ;;
    info|--info)            displayAllInformation $@ ;;
    daemon)                 displayDaemon $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
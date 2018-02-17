#!/bin/bash
source /bin/sx-lib.sh

# Dispatch input arguments
case $1 in
    usage|help|--help)      displayUsage $@ ;;
    usageS2i)               displayUsageS2I $@ ;;
    info|--info)            displayInformation $@ ;;
    daemon)                 displayDaemon $@ ;;
    version|--version)      displayVersion $@ ;;
    *)                      displayWelcome $@ ;;
esac
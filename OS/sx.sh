#!/bin/bash
source /bin/sx-lib.sh

display_container_header

# Dispatch input arguments
case $1 in
    usage|help)             displayUsage $@ ;;
    info)                   displayInformation $@ ;;
    daemon|-d)              displayDaemon $@ ;;
    version|--version)      displayVersion $@ ;;
    welcome)                displayWelcome $@ ;;
    *)                      displayWelcome $@ ;;
esac
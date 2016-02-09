#!/bin/bash
source /bin/sx-lib.sh

check_environment | tee -a $STARTUPLOG
display_container_header | tee -a $STARTUPLOG
start_service
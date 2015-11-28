#!/bin/bash
source /bin/sx-lib.sh

check_environment
display_container_header
display_container_started
tail -f /etc/redhat-release 
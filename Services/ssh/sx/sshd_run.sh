#!/bin/bash
source /sx/sshd.sh

begin_config
install_host_keys "root@localhost"
end_config

start_daemon
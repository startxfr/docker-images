#!/bin/bash
export TERM=dumb

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin memcached configuration for host $HOSTNAME"
}

# End configuration process just before starting daemon
function end_config {
    stop_server
    echo "=> End memcached configuration ..."
}

# Start the memcached server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting memcached server ..."
    memcached -u daemon -d &
    sleep 8
}

# Stop the memcached server running in background. 
function stop_server {
    echo "===> Stopping memcached server ..."
    killall memcached
    sleep 8
}

# Start the memcached server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting memcached daemon ..."
    exec memcached -u daemon
}


if [[ "$0" == *"memcached.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
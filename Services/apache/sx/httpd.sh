#!/bin/bash

export TERM=dumb

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin httpd configuration for host $HOSTNAME"
    mkdir -p /var/run/httpd
}

# End configuration process just before starting daemon
function end_config {
    echo "=> End httpd configuration ..."
}

# Start the httpd server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting httpd server ..."
    /usr/sbin/apachectl &
    sleep 8
}

# Stop the httpd server running in background. 
function stop_server {
    echo "===> Stopping httpd server ..."
    killall httpd
    rm -rf /run/httpd/*
    sleep 8
}

# Start the httpd server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting httpd daemon ..."
    exec /usr/sbin/apachectl
}


if [[ "$0" == *"httpd.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
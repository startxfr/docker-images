#!/bin/bash
export TERM=dumb

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin nodejs configuration for host $HOSTNAME"
}

# End configuration process just before starting daemon
function end_config {
    echo "=> End nodejs configuration ..."
}

# Start the nodejs server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting nodejs server ..."
    node $MAIN_APP &
    sleep 4
}

# Stop the nodejs server running in background. 
function stop_server {
    echo "===> Stopping nodejs server ..."
    killall node
    sleep 4
}

# Start the nodejs server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting nodejs daemon ..."
    exec node $MAIN_APP
}


if [[ "$0" == *"nodejs.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
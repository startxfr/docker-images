#!/bin/bash
export TERM=dumb

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin ooconv configuration for host $HOSTNAME"
}

# End configuration process just before starting daemon
function end_config {
    echo "=> End ooconv configuration ..."
}

# Start the ooconv server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting ooconv server ..."
    unoconv --listener &
    sleep 4
}

# Stop the ooconv server running in background. 
function stop_server {
    echo "===> Stopping ooconv server ..."
    killall unoconv 
    killall soffice.bin 
}

# Start the ooconv server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting ooconv daemon ..."
    exec unoconv --listener
}


if [[ "$0" == *"ooconv.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
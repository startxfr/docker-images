#!/bin/bash

export TERM=dumb
export MONGO_CONF=/etc/mongodb.conf
export MONGO_LOGDIR=/var/log/mongodb
export MONGO_DATADIR=/var/lib/mongodb


# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin mongod configuration for host $HOSTNAME"
    mkdir -p $MONGO_LOGDIR
    mkdir -p $MONGO_DATADIR
}

# End configuration process just before starting daemon
function end_config {
    stop_server
    echo "=> End mongod configuration ..."
}

# Start the mongod server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting mongod server ..."
    /usr/bin/mongod --config $MONGO_CONF &
    sleep 8
}

# Stop the mongod server running in background. 
function stop_server {
    echo "===> Stopping mongod server ..."
    /usr/bin/mongod --shutdown; sleep 2
    killall mongod; sleep 6
}

# Start the mongod server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting mongod daemon ..."
    exec /usr/bin/mongod --config $MONGO_CONF --quiet run
}


if [[ "$0" == *"mongod.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
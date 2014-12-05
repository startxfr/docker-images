#!/bin/bash

export TERM=dumb
export logfile="/var/log/sshd.log"

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin sshd configuration for host $HOSTNAME"
    mkdir -p /var/run/sshd
}

# End configuration process just before starting daemon
function end_config {
    echo "=> End sshd configuration ..."
}

# Perform installation of ssh keys 
function install_host_keys {
    local mail=$1;
    if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
        echo "===> Installing sshd host keys for $mail ..."
        generate_host_key rsa $mail /etc/ssh/ssh_host_rsa_key
        generate_host_key ecdsa $mail /etc/ssh/ssh_host_ecdsa_key
    else
        echo "===> sshd host key found at /etc/ssh/ssh_host_rsa_key ..."
    fi;
}


# generate key and store
function generate_host_key {
    local format=$1; local mail=$2; local dest=$3;
    echo "===> Generating $format sshd key for $mail recorded in $dest"
    ssh-keygen -t $format -C $mail -f $dest -N ''
}

# Start the sshd server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting sshd server ..."
    /usr/sbin/sshd &
    sleep 8
}

# Stop the sshd server running in background. 
function stop_server {
    echo "===> Stopping sshd server ..."
    killall sshd
    sleep 8
}

# Start the sshd server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting sshd daemon ..."
    exec /usr/sbin/sshd -D
}


if [[ "$0" == *"sshd.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
#!/bin/bash
source /bin/sx-lib.sh
export HTTPDCONF=/etc/httpd/conf.d/app.conf

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN APACHE-PHP CONFIGURATION"
    mkdir -p /var/run/httpd
    if [ -v DOCROOT ]; then
        echo "=> Changing document root to $DOCROOT"
        ${DOCROOT=/data/www}
        echo "DocumentRoot \"$DOCROOT\"" >> $HTTPDCONF
    fi
}

# End configuration process just before starting daemon
function end_config {
    stop_server
    echo "=> END APACHE-PHP CONFIGURATION"
}

# Start the httpd server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "=> Starting httpd + php server"
    /usr/sbin/apachectl &
    sleep 2
}

# Stop the httpd server running in background. 
function stop_server {
    echo "=> Stopping httpd + php server ..."
    killall httpd
    rm -rf /run/httpd/*
    sleep 2
}

# Start the httpd server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting httpd + php daemon ..."
    exec /usr/sbin/apachectl -D FOREGROUND
}



if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_environment
check_httpd_environment
display_container_header
begin_config
end_config
start_daemon
display_container_started

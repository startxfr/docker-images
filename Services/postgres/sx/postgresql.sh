#!/bin/bash
export TERM=dumb

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> Begin postgresql configuration for host $HOSTNAME"
    postgresql-setup initdb
    postgresql-setup upgrade
    start_server
    update_rootuser
}

# End configuration process just before starting daemon
function end_config {
    stop_server
    echo "=> End postgresql configuration ..."
}

# Start the postgresql server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting postgresql server ..."
    /usr/bin/postgres
}

# Stop the postgresql server running in background. 
function stop_server {
    echo "===> Stopping postgresql server ..."
    killall postgres
}

# Set new root password and grant permissions to all databases
function update_rootuser {
    if [ "$pgsql_newadminpwd" = "" ]; then
       export pgsql_newadminpwd=$(pwgen 13 1);
    fi
    local n=$pgsql_newadminpwd;
    echo "===> Update root user password and permission"
    sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$pgsql_newadminpwd';"
    unset pgsql_newadminpwd;
    export PGSQL_ROOTPWD=$n;
    echo "========================================================================";
    echo "You can now connect to this PostgresQL Server using the following credentials:";
    echo " ";
    echo "        user type : administrator";
    echo "        username  : postgres";
    echo "        password  : $n";
    echo " ";
    echo "        psql -h <host> -p <port> --username=postgres; $n";
    echo "========================================================================";
    echo " ";
    return 0
}

# Start the postgresql server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting postgresql daemon ..."
    exec /usr/bin/postgres -D /var/lib/pgsql/data -c config_file=/var/lib/pgsql/postgresql.conf 
}


if [[ "$0" == *"postgresql.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
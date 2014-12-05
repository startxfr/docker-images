#!/bin/bash

export TERM=dumb
export logfile="/var/log/mysql/mysqld.log"

# Begin configuration before starting daemonized process
# redirect mysql.log to /dev/stderr
function begin_config {
    echo "=> Begin mariadb configuration for host $HOSTNAME"
    ln -s /dev/stderr $logfile
    if [ "$(ls -1 /var/lib/mysql | wc -l)" -le "3"  ]; then
        echo "=> directory /var/lib/mysql is empty, start mysql installation ..."
        install_db
    else 
        echo "=> data found in /var/lib/mysql, skip mysql installation ..."
    fi;
    if [ ! -f /var/lib/mysql/mysql.sock ]; then
        echo "=> mysqld is not running, start server ..."
        start_server
    else
        echo "=> mysqld is already running ..."
    fi;
    update_rootuser
}

# End configuration process just before starting daemon
# stop output of mysql.log to /dev/stderr and create mysql.log file
function end_config {
    stop_server
    rm $logfile
    touch $logfile
    echo "=> End mariadb configuration ..."
}

# Preform installation of database structure. Must be used when no
# database is already set
function install_db {
    echo "===> Installing mariadb databases ..."
    mysql_install_db -u mysql > /dev/null 2>&1
    chown -R mysql:mysql /var/lib/mysql
}

# Start the mysqld server in background. Used to perform config
# against the database structure such as user creation
function start_server {
    echo "===> Starting mariadb server ..."
    /usr/bin/mysqld_safe > /dev/null 2>&1 &
    sleep 8
}

# Stop the mysqld server running in background. 
function stop_server {
    echo "===> Stopping mariadb server ..."
    killall mysqld mysqld_safe
    sleep 8
}

# Start the mysqld server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting mariadb daemon ..."
    exec /usr/libexec/mysqld
}

# Set new root password and grant permissions to all databases
function update_rootuser {
    if [ "$mysql_newadminpwd" = "" ]; then
       export mysql_newadminpwd=$(pwgen 13 1);
    fi
    local n=$mysql_newadminpwd;
    echo "===> Update root user password and permission"
    mysqladmin -u root password $n
    mysql -u root -p$n -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$n' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    unset mysql_newadminpwd;
    export MARIADB_ROOTPWD=$n;
    echo "========================================================================";
    echo "You can now connect to this MariaDB Server using the following credentials:";
    echo " ";
    echo "        user type : administrator";
    echo "        username  : root";
    echo "        password  : $n";
    echo " ";
    echo "        mysql -u root -p$n";
    echo "========================================================================";
    echo " ";
    return 0
}

# Find all sqlfiles in /tmp/ and import then using admin user
function import_sqlfiles {
    local filedir=$1; local p=$MARIADB_ROOTPWD; local del=$2;
    if [ "$(ls -1 $filedir | wc -l)" -ge "1"  ]; then
        echo "=> Found SQL files to import ..."
        for filename in "$filedir"; do
                import_sqlfile $filename $del
        done;
    fi;
    return 0
}

# Find all sqlfiles in /tmp/ and import then using admin user
function import_sqlfile {
    local filename=$1; local p=$MARIADB_ROOTPWD; local del=$2;
    if [ -f "$filename" ]; then
        echo "===> Importing sql file : $filename"
        mysql -u root -p$p < $filename
        if [ "$del" = "delete"]; then
            rm -f $filename
            echo "====> Deleting $filename after import"
        fi;
    else 
        echo "====> Could not find sql file $filename. Skip import..."
    fi;
    return 0
}

# Set new root password and grant permissions to all databases
function create_userdb {
    local userdb="$1"; local pass="$2"; local p=$MARIADB_ROOTPWD;
    if [ "$pass" = "" ]; then
       local pass=$(pwgen 13 1);
    fi
    echo "===> Create new user $userdb with database $userdb"
    mysql -u root -p$p -e "CREATE USER '$userdb'@'%';SET PASSWORD FOR '$userdb'@'%' = PASSWORD('$pass');\
                           CREATE USER '$userdb'@'localhost';SET PASSWORD FOR '$userdb'@'localhost' = PASSWORD('$pass');\
                           DROP DATABASE IF EXISTS $userdb; \
                           CREATE DATABASE $userdb DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; \
                           GRANT ALL PRIVILEGES ON $userdb.* TO '$userdb'@'%' IDENTIFIED BY '$pass'; \
                           GRANT ALL PRIVILEGES ON $userdb.* TO '$userdb'@'localhost' IDENTIFIED BY '$pass'; \
                           FLUSH PRIVILEGES;"
    echo "========================================================================";
    echo "You can now connect to this MariaDB Server using the following credentials:";
    echo " ";
    echo "        user type : user ";
    echo "        username  : $userdb ";
    echo "        password  : $pass";
    echo "        database  : $userdb ";
    echo " ";
    echo "        mysql -u $userdb -p$pass $userdb";
    echo "========================================================================";
    echo " ";
    return 0
}

# Set new root password and grant permissions to all databases
function create_user {
    local user="$1"; local pass="$2"; local p=$MARIADB_ROOTPWD;
    if [ "$pass" = "" ]; then
       local pass=$(pwgen 13 1);
    fi
    echo "===> Create new user $user"
    mysql -u root -p$p -e "CREATE USER '$user'@'%';SET PASSWORD FOR '$user'@'%' = PASSWORD('$pass');\
                           CREATE USER '$user'@'localhost';SET PASSWORD FOR '$user'@'localhost' = PASSWORD('$pass');"
    echo "========================================================================";
    echo "You can now connect to this MariaDB Server using the following credentials:";
    echo " ";
    echo "        user type : user ";
    echo "        username  : $user ";
    echo "        password  : $pass ";
    echo " ";
    echo "        mysql -u $user -p$pass";
    echo "========================================================================";
    echo " ";
    return 0
}

# Create a new database
function create_db {
    local db=$1; local p=$MARIADB_ROOTPWD;
    echo "===> Create new database $db"
    mysql -u root -p$p -e "CREATE DATABASE $db DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;";
    echo "===> New database $db CREATED"
    return 0
}

if [[ "$0" == *"mariadb.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi
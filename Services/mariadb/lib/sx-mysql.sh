#!/bin/bash

function check_mariadb_environment {
    if [ ! -v DATA_PATH ]; then
        DATA_PATH="/data"
        export DATA_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/logs"
        export LOG_PATH
    fi
}

function displayMysqlInformation {
    displayInformation $1
    echo $1 "version   : $SX_VERSION"
    echo $1 "engine    : $(mysql -V | head -1)"
    echo $1 "sql path  : $LOADSQL_PATH"
    echo $1 "log path  : $LOG_PATH"
    echo $1 "data path : $DATA_PATH"
}

function mysqlPreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayMysqlInformation "| "
    echo "+====================================================="
}

function mysqlPostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayMysqlInformation "| "
    echo "+====================================================="
}

function mysqlPostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayMysqlInformation "| "
    echo "+====================================================="
}

function mysqlAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayMysqlInformation "| "
    echo "+====================================================="
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy sql scripts from /tmp/src > $LOADSQL_PATH"
    cp -R /tmp/src/*.sql $LOADSQL_PATH/
    rm -rf /tmp/src
    init_service_mariadb
}

function mysqlRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayMysqlInformation "| "
    echo "+====================================================="
    start_service_mariadb
}

# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN MARIADB CONFIGURATION"
    if [[ ! -d $DATA_PATH ]]; then
        echo "data directory $DATA_PATH not found"
        mkdir -p $DATA_PATH; 
        mkdir -p $DATA_PATH/store; 
        chmod 0774 $DATA_PATH;
        chown -R mysql:0 $DATA_PATH; 
        echo "data directory $DATA_PATH CREATED"
    else 
        echo "data directory $DATA_PATH EXIST"
    fi
    if [[ ! -d $LOG_PATH ]]; then
        echo "log directory $LOG_PATH not found"
        mkdir -p $LOG_PATH; 
        chmod 0774 $LOG_PATH;
        chown mysql:0 $LOG_PATH; 
        echo "log directory $LOG_PATH CREATED"
    else 
        echo "log directory $LOG_PATH EXIST"
    fi
    if [[ -d $LOADSQL_PATH ]]; then
        echo "sql directory $LOADSQL_PATH EXIST"
        chmod 0774 $LOADSQL_PATH; 
        chown mysql:0 $LOADSQL_PATH
    fi
    echo "" >> $MY_CONF
    echo "[mysqld]" >> $MY_CONF
    echo "socket=/var/lib/mysql/mysql.sock" >> $MY_CONF
    echo "pid-file=/var/run/mysqld/mysqld.pid" >> $MY_CONF
    echo "datadir=$DATA_PATH" >> $MY_CONF
    echo "log-error=$LOG_PATH/mysqld.log" >> $MY_CONF
    echo "" >> $MY_CONF
    echo "[mariadb]" >> $MY_CONF
    echo "pid-file=/var/run/mariadb/mariadb.pid" >> $MY_CONF
    echo "datadir=$DATA_PATH" >> $MY_CONF
    echo "log-error=$LOG_PATH/mariadb.log" >> $MY_CONF
    VOLUME_HOME=$DATA_PATH/mysql
    if [[ ! -d $VOLUME_HOME ]]; then
        echo "mariadb directory is empty or uninitialized"
        echo "Installing MariaDB in $DATA_PATH ..."
        mysql_install_db --datadir=$DATA_PATH --defaults-file=$MY_CONF --user=mysql > /dev/null 2>&1 
        chown mysql:0 -R $DATA_PATH
        echo "Installing MariaDB in $DATA_PATH is DONE !"
        config_startserver
        config_createadmin
        config_createuser
        config_createdatabase
        config_importsql
        config_stopserver
    else
        echo "mariadb directory is initialized"
        echo "Reusing MariaDB in $DATA_PATH ..."
        chown mysql:0 -R $DATA_PATH
    fi
}

function config_startserver {
    echo "start database for initial setup"
    /usr/bin/mysqld_safe > /dev/null 2>&1 &
    RET=1
    while [[ RET -ne 0 ]]; do
        echo "- waiting for database response"
        sleep 1
        mysql -uroot -e "status" > /dev/null 2>&1
        RET=$?
    done
}

function config_stopserver {
    echo "stop database after initial setup"
    mysqladmin -uroot shutdown
}


function config_createadmin {
    PASS=${MYSQL_ROOT_PASSWORD:-$(pwgen -s 12 1)}
    _word=$( [ ${MYSQL_ROOT_PASSWORD} ] && echo "preset" || echo "random" )
    echo "Creating MariaDB admin user with ${_word} password"
    mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"
    echo ""
    echo " +------------------------------------------------------"
    echo " | SUPERADMIN USER CREATED ! "
    echo " | You can now connect to this server using:"
    echo " | "
    echo " | user     : admin"
    echo " | password : $PASS"
    echo " | "
    echo " | shell    : mysql -uadmin -p$PASS -h<host> -P<port>"
    echo " +------------------------------------------------------"
    echo ""
}

function config_createuser {
    if [[ -n "$MYSQL_USER" ]]; then
        echo "Creating MariaDB $MYSQL_USER user with preset password"
        mysql -uroot -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
        mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION"
        echo ""
        echo " +------------------------------------------------------"
        echo " | USER CREATED ! "
        echo " | You can now connect to this server using:"
        echo " | "
        echo " | user     : $MYSQL_USER"
        echo " | password : $MYSQL_PASSWORD"
        echo " | "
        echo " | shell    : mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h<host> -P<port>"
        echo " +------------------------------------------------------"
        echo ""
    fi
}

function config_createdatabase {
    if [[ -n "$MYSQL_DATABASE" ]]; then
        echo "processing database " $MYSQL_DATABASE
        if [[ ! -d $DIR_DB_DATA/$MYSQL_DATABASE ]]; then
            echo "database " $MYSQL_DATABASE " doesn't exist"
            mysql -uroot -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
            echo ""
            echo " +------------------------------------------------------"
            echo " | DATABASE CREATED ! "
            echo " | You can connect to this database using :"
            echo " | "
            echo " | database : $MYSQL_DATABASE"
            echo " | "
            echo " | shell    : mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h<host> -P<port> $MYSQL_DATABASE"
            echo " +------------------------------------------------------"
            echo ""
        else
            echo "database " $MYSQL_DATABASE " already exist"
        fi
    else
        echo "no database to create"
    fi
}

function config_importsql {
    if [[ -n "$LOADSQL_PATH" ]]; then
        echo "import sql data into " $MYSQL_DATABASE
        if [[ -d $LOADSQL_PATH ]]; then
            if [ "$(ls -A $LOADSQL_PATH/schema-*.sql)" ]; then
                echo "Importing schema from $LOADSQL_PATH "
                SCHEMALIST=$(find $LOADSQL_PATH/schema-*.sql -type f -printf "%f\n")
                for SCHEMAFILE in $SCHEMALIST; do 
                    echo "SET NAMES utf8;"|cat - $LOADSQL_PATH/$SCHEMAFILE > /tmp/out && mv /tmp/out $LOADSQL_PATH/$SCHEMAFILE
                    echo -n "Creating schema " $SCHEMAFILE " ... "
                    mysql -uroot $MYSQL_DATABASE < $LOADSQL_PATH/$SCHEMAFILE
                    echo " DONE"
                done
            fi
            if [ "$(ls -A $LOADSQL_PATH/data-*.sql)" ]; then
                echo "Importing data from $LOADSQL_PATH "
                DATALIST=$(find $LOADSQL_PATH/data-*.sql -type f -printf "%f\n")
                for DATAFILE in $DATALIST; do 
                    echo "SET NAMES utf8;"|cat - $LOADSQL_PATH/$DATAFILE > /tmp/out && mv /tmp/out $LOADSQL_PATH/$DATAFILE
                    echo -n "Creating data " $DATAFILE " ... "
                    mysql -uroot $MYSQL_DATABASE < $LOADSQL_PATH/$DATAFILE
                    echo " DONE"
                done
            fi
        fi
    else
        echo "no sql data to import into " $MYSQL_DATABASE
    fi
}


# End configuration process just before starting daemon
function end_config {
    echo "=> END MARIADB CONFIGURATION"
}

function stop_mariadb_handler {
    mysqladmin -uroot shutdown
    echo "+====================================================="
    echo "| Container $HOSTNAME is now STOPPED"
    echo "+====================================================="
    exit 143; # 128 + 15 -- SIGTERM
}

# Start the mariadb server as a deamon and execute it inside 
# the running shell
function start_service_mariadb {
    trap 'kill ${!}; stop_mariadb_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    exec mysqld_safe &
    while true
    do
      tail -f /dev/null & wait ${!}
    done
}

# Init the mariadb server
function init_service_mariadb {
    begin_config
    end_config
}
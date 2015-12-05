#!/bin/bash
source /bin/sx-lib.sh

function check_postgresql_environment {
    check_environment
    if [ ! -v DATA_PATH ]; then
        DATA_PATH="/data/postgresql"
        export DATA_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/data/logs/postgresql"
        export LOG_PATH
    fi
}

function display_container_postgresql_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    echo "| OS          : $(</etc/redhat-release)"
    echo "| Engine      : $(postgres --version)"
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    if [ -v DATA_PATH ]; then
        echo "| Data path   : $DATA_PATH"
    fi
    if [ -v LOG_PATH ]; then
        echo "| Log path    : $LOG_PATH"
    fi
    if [ -v LOADSQL_PATH ]; then
        echo "| sql path    : $LOADSQL_PATH"
    fi
    echo "+====================================================="
}


# Begin configuration before starting daemonized process
# and start generating host keys
function begin_config {
    echo "=> BEGIN POSTGRESQL CONFIGURATION"
    if [[ ! -d $DATA_PATH ]]; then
        echo "log directory $DATA_PATH not found"
        mkdir -p $DATA_PATH; chmod 0774 $DATA_PATH
        echo "data directory $DATA_PATH CREATED"
    else 
        echo "data directory $DATA_PATH EXIST"
    fi
    if [[ ! -d $LOG_PATH ]]; then
        echo "log directory $LOG_PATH not found"
        mkdir -p $LOG_PATH; chmod 0774 $LOG_PATH
        echo "log directory $LOG_PATH CREATED"
    else 
        echo "log directory $LOG_PATH EXIST"
    fi
    chmod 0774 $DATA_PATH $LOG_PATH; 
    chown postgres:postgres $DATA_PATH $LOG_PATH; 
    if [[ -d $LOADSQL_PATH ]]; then
        echo "sql directory $LOADSQL_PATH EXIST"
        chmod 0774 $LOADSQL_PATH; 
        chown postgres:postgres $LOADSQL_PATH
    fi
    if [ "$(ls -A $DATA_PATH)" ]; then
        echo "postgresql directory is initialized"
        echo "Reusing PostgreSQL in $DATA_PATH ..."
   else
        echo "postgresql directory is empty or uninitialized"
        echo "Installing PostgreSQL in $DATA_PATH ..."
        su - postgres -c "initdb -D $DATA_PATH"
        export POSTGRESQL_CONF=$DATA_PATH/postgresql.conf
        echo "" >> $POSTGRESQL_CONF
        echo "log_directory = '$LOG_PATH'" >> $POSTGRESQL_CONF
        echo "log_connections = on" >> $POSTGRESQL_CONF
        echo "log_hostname = on" >> $POSTGRESQL_CONF
        echo "log_line_prefix = '<%u@%r%%%d>'" >> $POSTGRESQL_CONF
        echo "Installing PostgreSQL in $DATA_PATH is DONE !"
    fi
}

function config_startserver {
    echo "start database for initial setup"
    su - postgres -c "nohup /usr/bin/postgres -D $DATA_PATH >$STARTUPLOG 2>&1 </dev/null &" 
    sleep 6
}

function config_stopserver {
    echo "stop database after initial setup"
    killall postgres
    sleep 3
}


function config_createadmin {
    PASS=${POSTGRESQL_ROOT_PASSWORD:-$(pwgen -s 12 1)}
    _word=$( [ ${POSTGRESQL_ROOT_PASSWORD} ] && echo "preset" || echo "random" )
    echo "Creating PostgreSQL admin user with ${_word} password"
    su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password '$PASS';\""
    echo ""
    echo " +------------------------------------------------------"
    echo " | You can now connect to this server using:"
    echo " | user     : postgres"
    echo " | password : $PASS"
    echo " | shell    : postgres -U postgres -p$PASS -h<host> -P<port>"
    echo " +------------------------------------------------------"
    echo ""
}

function config_createuser {
    if [[ -n "$POSTGRESQL_USER" ]]; then
        echo "Creating PostgreSQL $POSTGRESQL_USER user with preset password"
        su - postgres -c "psql -U postgres -d postgres -c \"CREATE USER '$POSTGRESQL_USER' WITH PASSWORD '$POSTGRESQL_PASSWORD';\""
        echo ""
        echo " +------------------------------------------------------"
        echo " | You can now connect to this server using:"
        echo " | user     : $POSTGRESQL_USER"
        echo " | password : $POSTGRESQL_PASSWORD"
        echo " | shell    : mysql -u$POSTGRESQL_USER -p$POSTGRESQL_PASSWORD -h<host> -P<port>"
        echo " +------------------------------------------------------"
        echo ""
    fi
}

function config_createdatabase {
    if [[ -n "$POSTGRESQL_DATABASE" ]]; then
        echo "processing database " $POSTGRESQL_DATABASE
        if [[ ! -d $DIR_DB_DATA/$POSTGRESQL_DATABASE ]]; then
            echo "database " $POSTGRESQL_DATABASE " doesn't exist"
            su - postgres -c "psql -U postgres -d postgres -c \"CREATE DATABASE $POSTGRESQL_DATABASE;\""
            echo "database " $POSTGRESQL_DATABASE " CREATED"
        else
            echo "database " $POSTGRESQL_DATABASE " already exist"
        fi
    else
        echo "no database to create"
    fi
}

function config_importsql {
    if [[ -n "$LOADSQL_PATH" ]]; then
        echo "import sql data into " $POSTGRESQL_DATABASE
        if [[ -d $LOADSQL_PATH ]]; then
            SCHEMALIST=$(find $LOADSQL_PATH/schema-*.sql -type f -printf "%f\n")
            for SCHEMAFILE in $SCHEMALIST; do 
                echo -n "Creating schema " $SCHEMAFILE " ... "
                su - postgres -c "psql -U postgres -d postgres < $LOADSQL_PATH/$SCHEMAFILE"
                echo " DONE"
            done
            DATALIST=$(find $LOADSQL_PATH/data-*.sql -type f -printf "%f\n")
            for DATAFILE in $DATALIST; do 
                echo -n "Creating data " $DATAFILE " ... "
                su - postgres -c "psql -U postgres -d postgres < $LOADSQL_PATH/$DATAFILE"
                echo " DONE"
            done
        fi
    else
        echo "no sql data to import into " $POSTGRESQL_DATABASE
    fi
}


# End configuration process just before starting daemon
function end_config {
    echo "=> END POSTGRESQL CONFIGURATION"
}

# Start the postgresql server as a deamon and execute it inside 
# the running shell
function start_daemon {
    echo "=> Starting postgresql daemon ..." | tee -a $STARTUPLOG
    display_container_started | tee -a $STARTUPLOG
    su - postgres -c "/usr/bin/postgres -D $DATA_PATH "
}


if [[ "$0" == *"run.sh" && ! $1 = "" ]];then
    eval "$@"; 
fi

check_postgresql_environment | tee -a $STARTUPLOG
display_container_postgresql_header | tee -a $STARTUPLOG
begin_config | tee -a $STARTUPLOG
config_startserver | tee -a $STARTUPLOG
config_createadmin | tee -a $STARTUPLOG
config_createuser | tee -a $STARTUPLOG
config_createdatabase | tee -a $STARTUPLOG
config_importsql | tee -a $STARTUPLOG
config_stopserver | tee -a $STARTUPLOG
end_config | tee -a $STARTUPLOG
start_daemon

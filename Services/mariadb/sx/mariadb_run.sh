#!/bin/bash
source /sx/mariadb.sh

begin_config

## if you wan't to add a new user with database
#create_userdb 'dbuser1' 'password'
## if you wan't to add a new user with database (generated password)
#create_userdb 'dbuser2'
## if you wan't to add a new user
#create_user 'username' 'password'
## if you wan't to add a new database
#create_db 'dbname'
## Execute an SQL request to get the user list
#mysql -u root -p$MARIADB_ROOTPWD -e 'select user, host FROM mysql.user;'
## Execute SQL scripts located into a directory
#import_sqlfiles /tmp/sql/*.sql
## Execute a single SQL script
#import_sqlfile /tmp/sql/example.sql

end_config
start_daemon
#!/bin/bash
ln -s /dev/stderr /var/log/mysql/mysqld.log
if [ ! -f /var/lib/mysql/.created ]; then
  function wait_for_mysqld_start {
    for i in {1..30}; do
      if echo 'select 1' | mysql -u root > /dev/null 2>&1; then
        return 0
      fi
      sleep 1
    done

    echo "MariaDB did not start in time"
    exit 1
  }



  password=${DB_PASSWORD:-password}
  dbname=${DB_NAME:-master}

  /usr/bin/mysql_install_db -u mysql

  /usr/libexec/mysqld &
  pid=$!

  wait_for_mysqld_start

  echo "Creating database $dbname ..."

  sql=$(cat <<SQL
  drop database if exists test;
  create database \`$dbname\`
     DEFAULT CHARACTER SET utf8 DEFAULT
     COLLATE utf8_general_ci;
SQL
)
  echo $sql | mysql -u root

  #delete from user;

  sql=$(cat <<SQL
    delete from user where user='';
    grant all on *.* to 'mysql'@'localhost' identified by '$password' with grant option;
    grant all on *.* to 'mysql'@'%' identified by '$password' with grant option;
    flush privileges;
SQL
)
  echo $sql | mysql -u root mysql

  touch /var/lib/mysql/.created
  kill -TERM $pid

  echo "Starting mysqld ..."
fi

exec /usr/libexec/mysqld
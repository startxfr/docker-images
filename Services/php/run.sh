#!/bin/bash
source /bin/sx-php.sh

check_httpd_environment | tee -a $STARTUPLOG
setSys2HttpEnvironmentVariable $APP_PATH/.htaccess
display_container_php_header | tee -a $STARTUPLOG
start_service_httpd

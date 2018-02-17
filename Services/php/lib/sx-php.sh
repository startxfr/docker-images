#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

function displayPhpInformation {
    displayApacheInformation
    echo "httpd     : $(httpd -v | head -1)" 
    echo "php       : $(php --version | head -1)" 
}

function display_container_php_header {
    echo "+====================================================="
    displayPhpInformation
    echo "+====================================================="
}
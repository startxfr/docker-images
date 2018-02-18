#!/bin/bash
source /bin/sx-lib.sh
source /bin/sx-httpd.sh

function displayPhpInformation {
    displayApacheInformation $1 
    echo $1 "php       : $(php --version | head -1)" 
}

function phpPreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayPhpInformation "| "
    echo "+====================================================="
    echo "Create log directory $LOG_PATH"
    touch $LOG_PATH/access.log
    chown 1001:0 -R $LOG_PATH
    chmod g=u -R $LOG_PATH
}

function phpPostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayPhpInformation "| "
    echo "+====================================================="
}

function phpPostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayPhpInformation "| "
    echo "+====================================================="
}

function phpAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayPhpInformation "| "
    echo "+====================================================="
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy source from /tmp/src > $APP_PATH"
    cp -R /tmp/src/* $APP_PATH/
    rm -rf /tmp/src
}

function phpRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayPhpInformation "| "
    echo "+====================================================="
    start_service_httpd
}
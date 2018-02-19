#!/bin/bash

function check_nodejs_environment {
    if [ ! -v APP_PATH ]; then
        APP_PATH="/app"
        export APP_PATH
    fi
    if [ ! -v APP_MAIN ]; then
        APP_MAIN="app.js"
        export APP_MAIN
    fi
    if [ ! -v DATA_PATH ]; then
        DATA_PATH="/data"
        export DATA_PATH
    fi
    if [ ! -v LOG_PATH ]; then
        LOG_PATH="/logs"
        export LOG_PATH
    fi
}

function displayNodejsInformation {
    displayInformation $1 
    echo $1 "app path  : $APP_PATH"
    echo $1 "log path  : $LOG_PATH"
    echo $1 "data path : $DATA_PATH"
    echo $1 "node      : $(node -v | head -1)" 
    echo $1 "npm       : $(npm -v | head -1)" 
}

function nodejsPreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayNodejsInformation "| "
    echo "+====================================================="
}

function nodejsPostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayNodejsInformation "| "
    echo "+====================================================="
}

function nodejsPostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayNodejsInformation "| "
    echo "+====================================================="
}

function nodejsAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayNodejsInformation "| "
    echo "+====================================================="
    echo "Fixing perm on ~/.config"
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy source from /tmp/src > $APP_PATH"
    cp -R /tmp/src/* $APP_PATH/
    rm -rf /tmp/src
    echo "Build modules in $APP_PATH"
    cd $APP_PATH
    npm install -production
    cd -
}

function nodejsRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayNodejsInformation "| "
    echo "+====================================================="
    start_service_nodejs
}

function stop_nodejs_handler {
    killall node
    echo "+====================================================="
    echo "| Container $HOSTNAME is now STOPPED"
    echo "+====================================================="
    exit 143; # 128 + 15 -- SIGTERM
}


# Start the nodejs server as a deamon and execute it inside 
# the running shell
function start_service_nodejs {
    cd $APP_PATH
    trap 'kill ${!}; stop_nodejs_handler' SIGHUP SIGINT SIGQUIT SIGTERM SIGKILL SIGSTOP SIGCONT
    if [ ! -d "$APP_PATH/node_modules" ]; then
        npm install -production
    fi
    exec node $APP_MAIN 
}
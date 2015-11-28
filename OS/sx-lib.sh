#!/bin/bash

export TERM=dumb

function check_environment {
    if [ ! -v CONTAINER_TYPE ]; then
        CONTAINER_TYPE="unknown"
        export CONTAINER_TYPE
        echo "! WARNING : environment var CONTAINER_TYPE is missing..."
        echo "! WARNING : auto-assigned value : $CONTAINER_TYPE"
    fi
    if [ ! -v CONTAINER_SERVICE ]; then
        CONTAINER_SERVICE=$CONTAINER_TYPE;
        export CONTAINER_SERVICE;
        echo "! WARNING : environment var CONTAINER_SERVICE is missing..."
        echo "! WARNING : auto-assigned value : $CONTAINER_SERVICE"
    fi
    if [ ! -v CONTAINER_INSTANCE ]; then
        echo "ERROR : environment var CONTAINER_INSTANCE is missing. EXIT !!!"
        exit 1;
    fi
}

function display_container_header {
    echo "+====================================================="
    echo "| Container   : $HOSTNAME"
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type        : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance    : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service     : $CONTAINER_SERVICE"
    fi
    echo "+====================================================="
}

function display_container_started {
    echo "+====================================================="
    echo "| Container $HOSTNAME is now running..."
    echo "+====================================================="
}
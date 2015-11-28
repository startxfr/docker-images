#!/bin/bash

export TERM=dumb

function display_container_header {
    echo "+====================================================="
    echo "| Container : $HOSTNAME"
    if [ -v CONTAINER_TYPE ]; then
        echo "| Type      : $CONTAINER_TYPE"
    fi
    if [ -v CONTAINER_INSTANCE ]; then
        echo "| Instance  : $CONTAINER_INSTANCE"
    fi
    if [ -v CONTAINER_SERVICE ]; then
        echo "| Service   : $CONTAINER_SERVICE"
    fi
    echo "+====================================================="
}

#!/bin/bash
OS=`cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}'`

export TERM=xterm
pid=0

function display_container_header {
    echo "+====================================================="
    displayInformation
    echo "+====================================================="
}


#######################################
# Display general usage
#######################################
function displayUsage {
cat <<EOF
docker run $SX_ID help

Usage:
  docker run $SX_ID [command]

- General Commands:
  usage            this message
  help             display information about this tools
  info             give information about the running container
  version          give the version of the running container
  daemon           execute the container as a daemon (keep alive)

EOF
exit 0;
}



#######################################
# Display general welcome message
#######################################
function displayWelcome {
cat <<EOF
Welcome to the $SX_ID base image. If you see this message, you have
probably run this container without arguments. See usage for more informations.

docker run $SX_ID usage

EOF
exit 0;
}

#######################################
# Display information
#######################################
function displayInformation {
echo "ID        : $SX_ID"
echo "type      : $SX_TYPE"
echo "service   : $SX_SERVICE"
echo "OS        : $OS"
echo "container : $HOSTNAME"
echo "name      : $SX_NAME"
echo "version   : $SX_VERSION"
exit 0;
}

#######################################
# Display version
#######################################
function displayVersion {
echo $SXDBTOOLS_VERSION
if [ `isDebug` == "true" ]; then
    env
fi 
exit 0;
}

#######################################
# Display daemon
#######################################
function displayDaemon {
    while true; do
        if [ `isDebug` == "true" ]; then
            echo "$HOSTNAME is alive and running $SX_ID:$SX_VERSION"
        else
            echo "$HOSTNAME is alive"
        fi
        sleep 10
    done
}

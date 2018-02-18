#!/bin/bash
OS=`cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g'`

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
Basic OS container to execute arbitrary commands

Usage:
  docker run $SX_ID /bin/sx [command]

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
# Display S2I usage
#######################################
function displayUsageS2I {
cat <<EOF
Startx builder container to use with s2i or openshift

Usage:
  s2i $SX_ID <code_repo_url> ≤image_name>

Code repository must have a `run` script who will be executed on container startup

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

docker run $SX_ID /bin/sx usage

EOF
exit 0;
}

#######################################
# Display information
#######################################
function displayInformation {
echo "name      : $SX_NAME"
echo "ID        : $SX_ID:$SX_VERSION"
echo "type      : $SX_TYPE"
echo "service   : $SX_SERVICE"
echo "OS        : $OS"
echo "container : $HOSTNAME"
env
exit 0;
}

#######################################
# Display version
#######################################
function displayVersion {
echo $SXDBTOOLS_VERSION
exit 0;
}

#######################################
# Display daemon
#######################################
function displayDaemon {
    while true; do
        echo "$HOSTNAME is alive and running $SX_ID:$SX_VERSION"
        sleep 10
    done
}

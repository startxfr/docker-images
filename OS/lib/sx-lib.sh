#!/bin/bash
OS=`cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g'`

export TERM=xterm
pid=0

function display_container_header {
    echo "+====================================================="
    echo "| Container $HOSTNAME is now RUNNING"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
}

function genericPreDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running PRE-DEPLOY HOOK"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
}

function genericPostDeploy {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-DEPLOY HOOK"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
}

function genericPostBuild {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running POST-BUILD HOOK"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
}

function genericAssemble {
    echo "+====================================================="
    echo "| Container $HOSTNAME is running ASSEMBLE"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
    echo "Fixing perm on /tmp/src"
    chown 1001:0 -R /tmp/src
    chmod g=u -R /tmp/src
    echo "Copy source from /tmp/src > /tmp"
    cp -R /tmp/src/* /tmp/
    rm -rf /tmp/src
}

function genericRun {
    echo "+====================================================="
    echo "| Container $HOSTNAME is RUNNING"
    echo "| "
    displayInformation "| "
    echo "+====================================================="
    displayDaemon
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
  assemble         execute for building output image when using s2i 
  post-build       execute after building image
  pre-deploy       execute before the deployment begins (openshift).
  post-deploy      execute after the deployment strategy completes (openshift).
  run              execute the service on container startup
  health           return the service health
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
echo $1 "name      : $SX_NAME"
echo $1 "ID        : $SX_ID:$SX_VERSION"
echo $1 "type      : $SX_TYPE"
echo $1 "service   : $SX_SERVICE"
echo $1 "OS        : $OS"
echo $1 "container : $HOSTNAME"
}

#######################################
# Display information
#######################################
function displayAllInformation {
displayInformation
env
}

#######################################
# Display version
#######################################
function displayVersion {
echo $SXDBTOOLS_VERSION
exit 0;
}

#######################################
# Display health
#######################################
function displayHealth {
echo "OK"
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

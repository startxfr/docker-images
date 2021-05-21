#!/bin/bash
CONF_FILE=~/.podman-sx
DEFAULT_PROJECT=startx
DEFAULT_FLAVOUR=latest
DEFAULT_OS_FLAVOUR=latest
SXDC_PROJECT=$DEFAULT_PROJECT
SXDC_FLAVOUR=$DEFAULT_FLAVOUR
SXDC_OS_FLAVOUR=$DEFAULT_OS_FLAVOUR

# Create lib
function testBuild {
    podman build -t $SXDC_PROJECT/$2:$3 $1
}

function testDeploy {
    podman stop ${SXDC_PROJECT}_$2_$3
    podman rm -vf ${SXDC_PROJECT}_$2_$3
    podman run -d --name ${SXDC_PROJECT}_$2_$3 $SXDC_PROJECT/$2:$3
}

function testVersion {
    podman stop ${SXDC_PROJECT}_$2_$3-version &>/dev/null
    podman rm -f ${SXDC_PROJECT}_$2_$3-version &>/dev/null
    echo -e "== Display informations on \e[1m$2\e[0m in \e[1m$3\e[0m version"
    podman run --name ${SXDC_PROJECT}_$2_$3-version $SXDC_PROJECT/$2:$3 /bin/sx-$2 info
    podman rm -f ${SXDC_PROJECT}_$2_$3-version &>/dev/null
}

function testOSVersion {
    podman stop ${SXDC_PROJECT}_$2_$3-version &>/dev/null
    podman rm -f ${SXDC_PROJECT}_$2_$3-version &>/dev/null
    echo -e "== Display informations on \e[1m$2\e[0m in \e[1m$3\e[0m version"
    podman run --name ${SXDC_PROJECT}_$2_$3-version $SXDC_PROJECT/$2:$3 /bin/sx info
    podman rm -f ${SXDC_PROJECT}_$2_$3-version &>/dev/null
}

function temporize {
    x=$1
    echo "temporize during ${x}sec"
    while [ $x -gt 0 ]
    do
        sleep $2
        x=$(( $x - $2 ))
        echo "wait for ${x}sec..."
    done
}

## start application

#test if podman client is present
ov=`podman version | grep ^Version`
if [ $? != 0 ]; then
    echo "Podman is not installed."
    echo "Install podman client (podman) first"
    echo "Exit"
    exit 1;
fi

# append key to conf
function appendConf {
    echo "$1=$2" >> $CONF_FILE
}

# reload conf file
function reloadConf {
    source $CONF_FILE
}


# Display general usage
function menuUsage {
cat <<EOF

Startx podman helper script using local copy of startx docker-images project
to build and start podman containers with startx images and examples

Usage:
  startx-podman-helper.sh [command]

- General commands:
  setup                  setup project environement (interactive)
  setup project ≤name>   setup podman project name
  setup flavour ≤name>   setup startx image flavour
  delete                 Remove all the current objects
  usage                  this message

- Test commands:
  buildrun               Build and run all container for the given flavour
  run ≤name>             Run one container with defined flavour
  run all                Run all containers with defined flavour
  build ≤name>           Build one container with defined flavour
  build all              Build all containers with defined flavour
  version ≤name>         Run (and build) container to extract application informations
  version all            Run (and build) all container to extract application informations
  versions               Alias of the previous command

  Using podman $ov
EOF
}

# Display menu setup
function menuSetup {
    case $2 in
        project|p)   menuSetupProject $3 ;;
        flavour|f)   menuSetupFlavour $3 ;;
        *)           menuSetupAll $@ ;;
    esac
}

# Display sub-menu setup
function menuSetupAll {
    menuSetupProject $2
    menuSetupFlavour $2
}

# Display sub-menu setup - project
function menuSetupProject {
    if [[ "$1" != "" ]]; then
        appendConf SXDC_PROJECT $1
    else
        echo -en "Project name \e[2m(\e[0m\e[1m$DEFAULT_PROJECT\e[0m\e[2m)\e[0m :"
        read project
        if [[ "$project" != "" ]]; then
            appendConf SXDC_PROJECT $project
        else
            appendConf SXDC_PROJECT $DEFAULT_PROJECT
        fi
    fi
    reloadConf
}

# Display sub-menu setup - flavour
function menuSetupFlavour {
    flavour=$DEFAULT_FLAVOUR
    if [[ "$1" != "" ]]; then
        flavour=$1
    else
        echo -en "Image flavour \e[2m(\e[0m\e[1m$DEFAULT_FLAVOUR\e[0m\e[2m)\e[0m :"
        read project
        if [[ "$project" != "" ]]; then
            flavour=$project
        fi
    fi
    case $flavour in
        alpine)  appendConf SXDC_FLAVOUR alpine
        appendConf SXDC_OS_FLAVOUR 'alpine';;
        ubi8)     appendConf SXDC_FLAVOUR ubi8
        appendConf SXDC_OS_FLAVOUR 'ubi';;
        centos8)  appendConf SXDC_FLAVOUR centos8
        appendConf SXDC_OS_FLAVOUR 'centos';;
        centos7)  appendConf SXDC_FLAVOUR centos7
        appendConf SXDC_OS_FLAVOUR 'centos';;
        centos6)  appendConf SXDC_FLAVOUR centos6
        appendConf SXDC_OS_FLAVOUR 'centos';;
        fc34)     appendConf SXDC_FLAVOUR fc34
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc33)     appendConf SXDC_FLAVOUR fc33
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc32)     appendConf SXDC_FLAVOUR fc32
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc31)     appendConf SXDC_FLAVOUR fc31
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc30)     appendConf SXDC_FLAVOUR fc30
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc29)     appendConf SXDC_FLAVOUR fc29
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        fc28)     appendConf SXDC_FLAVOUR fc28
        appendConf SXDC_OS_FLAVOUR 'fedora';;
        *)        appendConf SXDC_FLAVOUR latest
        appendConf SXDC_OS_FLAVOUR 'fedora';;
    esac
    reloadConf
    echo -e "Set flavour to \e[1m$SXDC_FLAVOUR\e[0m"
    echo -e "Set OS flavour to \e[1m$SXDC_OS_FLAVOUR\e[0m"
    if [[ "$SXDC_FLAVOUR" == "latest" ]]; then
        BRANCH="master"
    else
        BRANCH=$SXDC_FLAVOUR
    fi
    git checkout $BRANCH
    echo -e "Switched to branch \e[1m$BRANCH\e[0m"
}

# Display menu test build templates
function menuBuild {
    case $2 in
        os|fedora|centos|alpine)   testBuild OS $SXDC_OS_FLAVOUR latest;;
        apache|http)               testBuild Services/apache apache $SXDC_FLAVOUR;;
        couchbase)                 testBuild Services/couchbase couchbase $SXDC_FLAVOUR;;
        mariadb|mysql)             testBuild Services/mariadb mariadb $SXDC_FLAVOUR;;
        memcache)                  testBuild Services/memcache memcache $SXDC_FLAVOUR;;
        mongo)                     testBuild Services/mongo mongo $SXDC_FLAVOUR;;
        nodejs)                    testBuild Services/nodejs nodejs $SXDC_FLAVOUR;;
        ooconv)                    testBuild Services/ooconv ooconv $SXDC_FLAVOUR;;
        php)                       testBuild Services/php php $SXDC_FLAVOUR;;
        postgres)                  testBuild Services/postgres postgres $SXDC_FLAVOUR;;
        runner-ansible)            testBuild GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
        runner-apache)             testBuild GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
        runner-bash)               testBuild GitlabRunner/bash runner-bash $SXDC_FLAVOUR;;
        runner-nodejs)             testBuild GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR;;
        runner-php)                testBuild GitlabRunner/php runner-php $SXDC_FLAVOUR;;
        runner-oc)                 testBuild GitlabRunner/oc runner-oc $SXDC_FLAVOUR;;
        chrome)                    testBuild VDI/chrome chrome $SXDC_FLAVOUR;;
        firefox)                   testBuild VDI/firefox firefox $SXDC_FLAVOUR;;
        all)
            testBuild              OS $SXDC_OS_FLAVOUR latest
            testBuild              Services/apache apache $SXDC_FLAVOUR
            testBuild              Services/couchbase couchbase $SXDC_FLAVOUR
            testBuild              Services/mariadb mariadb $SXDC_FLAVOUR
            testBuild              Services/memcache memcache $SXDC_FLAVOUR
            testBuild              Services/mongo mongo $SXDC_FLAVOUR
            testBuild              Services/nodejs nodejs $SXDC_FLAVOUR
            testBuild              Services/ooconv ooconv $SXDC_FLAVOUR
            testBuild              Services/php php $SXDC_FLAVOUR
            testBuild              Services/postgres postgres $SXDC_FLAVOUR
            testBuild              GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR
            testBuild              GitlabRunner/apache runner-apache $SXDC_FLAVOUR
            testBuild              GitlabRunner/bash runner-bash $SXDC_FLAVOUR
            testBuild              GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
            testBuild              GitlabRunner/php runner-nodejs $SXDC_FLAVOUR
            testBuild              VDI/chrome chrome $SXDC_FLAVOUR
            testBuild              VDI/firefox firefox $SXDC_FLAVOUR;;
        *)                         menuUsage
esac
}

# Display menu test deploy templates
function menuRun {
    case $2 in
        os|fedora|centos|alpine)   testDeploy OS $SXDC_OS_FLAVOUR latest;;
        apache|http)               testDeploy Services/apache apache $SXDC_FLAVOUR;;
        couchbase)                 testDeploy Services/couchbase couchbase $SXDC_FLAVOUR;;
        mariadb|mysql)             testDeploy Services/mariadb mariadb $SXDC_FLAVOUR;;
        memcache)                  testDeploy Services/memcache memcache $SXDC_FLAVOUR;;
        mongo)                     testDeploy Services/mongo mongo $SXDC_FLAVOUR;;
        nodejs)                    testDeploy Services/nodejs nodejs $SXDC_FLAVOUR;;
        ooconv)                    testDeploy Services/ooconv ooconv $SXDC_FLAVOUR;;
        php)                       testDeploy Services/php php $SXDC_FLAVOUR;;
        postgres)                  testDeploy Services/postgres postgres $SXDC_FLAVOUR;;
        runner-ansible)            testDeploy GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
        runner-apache)             testDeploy GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
        runner-bash)               testDeploy GitlabRunner/bash runner-bash $SXDC_FLAVOUR;;
        runner-nodejs)             testDeploy GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR;;
        runner-php)                testDeploy GitlabRunner/php runner-nodejs $SXDC_FLAVOUR;;
        chrome)                    testDeploy VDI/chrome chrome $SXDC_FLAVOUR;;
        firefox)                   testDeploy VDI/firefox firefox $SXDC_FLAVOUR;;
        all)
             testDeploy            OS $SXDC_OS_FLAVOUR latest
             testDeploy            Services/apache apache $SXDC_FLAVOUR
             testDeploy            Services/couchbase couchbase $SXDC_FLAVOUR
             testDeploy            Services/mariadb mariadb $SXDC_FLAVOUR
             testDeploy            Services/memcache memcache $SXDC_FLAVOUR
             testDeploy            Services/mongo mongo $SXDC_FLAVOUR
             testDeploy            Services/nodejs nodejs $SXDC_FLAVOUR
             testDeploy            Services/ooconv ooconv $SXDC_FLAVOUR
             testDeploy            Services/php php $SXDC_FLAVOUR
             testDeploy            Services/postgres postgres $SXDC_FLAVOUR
             testDeploy            GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR
             testDeploy            GitlabRunner/apache runner-apache $SXDC_FLAVOUR
             testDeploy            GitlabRunner/bash runner-bash $SXDC_FLAVOUR
             testDeploy            GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
             testDeploy            GitlabRunner/php runner-nodejs $SXDC_FLAVOUR
             testDeploy            VDI/chrome chrome $SXDC_FLAVOUR
             testDeploy            VDI/firefox firefox $SXDC_FLAVOUR;;
         *)                        menuUsage
esac
}

# Display menu test deploy templates
function menuVersion {
    case $2 in
        os|fedora|centos|alpine)   testOSVersion OS $SXDC_OS_FLAVOUR latest;;
        apache|http)               testVersion Services/apache apache $SXDC_FLAVOUR;;
        couchbase)                 testVersion Services/couchbase couchbase $SXDC_FLAVOUR;;
        mariadb|mysql)             testVersion Services/mariadb mariadb $SXDC_FLAVOUR;;
        memcache)                  testVersion Services/memcache memcache $SXDC_FLAVOUR;;
        mongo)                     testVersion Services/mongo mongo $SXDC_FLAVOUR;;
        nodejs)                    testVersion Services/nodejs nodejs $SXDC_FLAVOUR;;
        ooconv)                    testVersion Services/ooconv ooconv $SXDC_FLAVOUR;;
        php)                       testVersion Services/php php $SXDC_FLAVOUR;;
        postgres)                  testVersion Services/postgres postgres $SXDC_FLAVOUR;;
        runner-ansible)            testVersion GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
        runner-apache)             testVersion GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
        runner-bash)               testVersion GitlabRunner/bash runner-bash $SXDC_FLAVOUR;;
        runner-nodejs)             testVersion GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR;;
        runner-php)                testVersion GitlabRunner/php runner-nodejs $SXDC_FLAVOUR;;
        chrome)                    testVersion VDI/chrome chrome $SXDC_FLAVOUR;;
        firefox)                   testVersion VDI/firefox firefox $SXDC_FLAVOUR;;
        all)
             testOSVersion          OS $SXDC_OS_FLAVOUR latest
             testVersion            Services/apache apache $SXDC_FLAVOUR
             testVersion            Services/couchbase couchbase $SXDC_FLAVOUR
             testVersion            Services/mariadb mariadb $SXDC_FLAVOUR
             testVersion            Services/memcache memcache $SXDC_FLAVOUR
             testVersion            Services/mongo mongo $SXDC_FLAVOUR
             testVersion            Services/nodejs nodejs $SXDC_FLAVOUR
             testVersion            Services/ooconv ooconv $SXDC_FLAVOUR
             testVersion            Services/php php $SXDC_FLAVOUR
             testVersion            Services/postgres postgres $SXDC_FLAVOUR
             testVersion            GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR
             testVersion            GitlabRunner/apache runner-apache $SXDC_FLAVOUR
             testVersion            GitlabRunner/bash runner-bash $SXDC_FLAVOUR
             testVersion            GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
             testVersion            GitlabRunner/php runner-nodejs $SXDC_FLAVOUR
             testVersion            VDI/chrome chrome $SXDC_FLAVOUR
             testVersion            VDI/firefox firefox $SXDC_FLAVOUR;;
         *)                        menuUsage
esac
}

# Display menu test all
function menuBuildRun {
    menuBuild build all
    temporize 60 10
    menuRun deploy all
    temporize 30 5
}

# Display menu test all
function menuAllVersions {
    menuVersion version all
}

# Display menu delete
function menuDelete {
    podman stop $(podman ps -q -f label=$SXDC_PROJECT)
    podman container prune
    podman image prune
}

# Dispatch input arguments
case $1 in
    setup)                  menuSetup $@ ;;
    build)                  menuBuild $@ ;;
    run)                    menuRun $@ ;;
    buildrun)               menuBuildRun $@ ;;
    version)                menuVersion $@ ;;
    versions)               menuAllVersions $@ ;;
    delete)                 menuDelete $@ ;;
    usage|help|--help)      menuUsage $@ ;;
    *)                      menuUsage $@ ;;
esac

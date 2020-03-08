#!/bin/bash
ORIGIN_REPO_URL=https://startxfr@github.com/startxfr/docker-images.git

# check if git is installed
function checkGitInstalled {
    retn=`git --version | grep version`
    if [ $? != 0 ]; then
        echo "git is not installed."
        echo "Install git client first"
        exit 1;
    fi
}

# check if is in git directory
function checkDirectoryIsGit {
    retn=`git status &>/dev/null`
    if [ $? != "0" ]; then
        echo "your are not in a git repository"
        echo "please run 'git clone $ORIGIN_REPO_URL docker-images && cd docker-images' first"
        exit 2;
    fi
}

# check if git repo is the good one
function checkGitRepoIsOrigin {
    retn=`git remote show origin | grep 'Fetch URL: ' | sed 's/ *//g' | cut -c 10-`
    if [ $retn != "$ORIGIN_REPO_URL" ]; then
        echo "your are not in the $ORIGIN_REPO_URL repo"
        echo "please run 'mv ..' first"
        exit 3;
    fi
}

# check if git branch is master
function checkGitBranchIsMaster {
    git branch | grep '* master' &> /tmp/aaa
    if [[ `cat /tmp/aaa` != '* master' ]]; then
        echo "your are not in the master branch"
        echo "please run 'git checkout master' first"
        git checkout master
        git branch | grep '* master' &> /tmp/aaa
        if [[ `cat /tmp/aaa` != '* master' ]]; then
            echo "your are not in the master branch"
            echo "please run 'git checkout master' first"
        fi
        exit 4;
    fi
    rm -f /tmp/aaa
}

# check if git branch has no file to commit
function checkGitBranchIsCommited {
    retn=`git status -s | wc -l`
    if [ $retn -gt 0 ]; then
        echo "There is some file waiting for commit"
        echo "please run 'git commit' first"
        git status
        exit 5;
    fi
}


# check if git branch has no file to commit
function checkReadyForRun {
    checkGitInstalled
    checkDirectoryIsGit
    checkGitRepoIsOrigin
    checkGitBranchIsMaster
    checkGitBranchIsCommited
}







checkReadyForRun











exit;

CONF_FILE=~/.podman-sx
DEFAULT_PROJECT=startx
DEFAULT_FLAVOUR=latest
DEFAULT_OS_FLAVOUR=latest
SXDC_PROJECT=$DEFAULT_PROJECT
SXDC_FLAVOUR=$DEFAULT_FLAVOUR
SXDC_OS_FLAVOUR=$DEFAULT_OS_FLAVOUR

# config file
touch $CONF_FILE
source $CONF_FILE


# Create lib
function testBuild {
    podman build -t $SXDC_PROJECT/$2:$3 $1
}

function testDeploy {
    podman stop $SXDC_PROJECT-$2-$3
    podman rm -vf $SXDC_PROJECT-$2-$3
    podman run -d --name $SXDC_PROJECT-$2-$3 $SXDC_PROJECT/$2:$3
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
        alpine3)  appendConf SXDC_FLAVOUR alpine3
        appendConf SXDC_OS_FLAVOUR 'alpine';;
        ubi8)     appendConf SXDC_FLAVOUR ubi8
        appendConf SXDC_OS_FLAVOUR 'ubi';;
        centos8)  appendConf SXDC_FLAVOUR centos8
        appendConf SXDC_OS_FLAVOUR 'centos';;
        centos7)  appendConf SXDC_FLAVOUR centos7
        appendConf SXDC_OS_FLAVOUR 'centos';;
        centos6)  appendConf SXDC_FLAVOUR centos6
        appendConf SXDC_OS_FLAVOUR 'centos';;
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
        runner-php)                testBuild GitlabRunner/php runner-nodejs $SXDC_FLAVOUR;;
        chrome)                    testBuild VDI/chrome chrome $SXDC_FLAVOUR;;
        firefox)                   testBuild VDI/firefox firefox $SXDC_FLAVOUR;;
        all)
            testBuild OS $SXDC_OS_FLAVOUR latest
            testBuild Services/apache apache $SXDC_FLAVOUR
            testBuild Services/couchbase couchbase $SXDC_FLAVOUR
            testBuild Services/mariadb mariadb $SXDC_FLAVOUR
            testBuild Services/memcache memcache $SXDC_FLAVOUR
            testBuild Services/mongo mongo $SXDC_FLAVOUR
            testBuild Services/nodejs nodejs $SXDC_FLAVOUR
            testBuild Services/ooconv ooconv $SXDC_FLAVOUR
            testBuild Services/php php $SXDC_FLAVOUR
            testBuild Services/postgres postgres $SXDC_FLAVOUR
        testBuild GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
    testBuild GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
    testBuild GitlabRunner/bash runner-bash $SXDC_FLAVOUR
    testBuild GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
    testBuild GitlabRunner/php runner-nodejs $SXDC_FLAVOUR
    testBuild VDI/chrome chrome $SXDC_FLAVOUR
testBuild VDI/firefox firefox $SXDC_FLAVOUR;;
*)                         menuUsage;;
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
            testDeploy OS $SXDC_OS_FLAVOUR latest
            testDeploy Services/apache apache $SXDC_FLAVOUR
            testDeploy Services/couchbase couchbase $SXDC_FLAVOUR
            testDeploy Services/mariadb mariadb $SXDC_FLAVOUR
            testDeploy Services/memcache memcache $SXDC_FLAVOUR
            testDeploy Services/mongo mongo $SXDC_FLAVOUR
            testDeploy Services/nodejs nodejs $SXDC_FLAVOUR
            testDeploy Services/ooconv ooconv $SXDC_FLAVOUR
            testDeploy Services/php php $SXDC_FLAVOUR
            testDeploy Services/postgres postgres $SXDC_FLAVOUR
        testDeploy GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
    testDeploy GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
    testDeploy GitlabRunner/bash runner-bash $SXDC_FLAVOUR
    testDeploy GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
    testDeploy GitlabRunner/php runner-nodejs $SXDC_FLAVOUR
    testDeploy VDI/chrome chrome $SXDC_FLAVOUR
testDeploy VDI/firefox firefox $SXDC_FLAVOUR;;
*)                         menuUsage;;
esac
}

# Display menu test all
function menuBuildRun {
    menuBuild build all
    temporize 60 10
    menuRun deploy all
    temporize 30 5
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
    buildrun)               menuBuildRun $@ ;;
    run)                    menuRun $@ ;;
    build)                  menuBuild $@ ;;
    delete)                 menuDelete $@ ;;
    usage|help|--help)      menuUsage $@ ;;
    *)                      menuUsage $@ ;;
esac
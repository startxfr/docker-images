#!/bin/bash
CONF_FILE=~/.oks-sx
DEFAULT_PROJECT="startx"
DEFAULT_FLAVOUR="latest"
DEFAULT_OS_FLAVOUR="latest"
DEFAULT_STAGE="test"
SXDC_PROJECT=$DEFAULT_PROJECT
SXDC_FLAVOUR=$DEFAULT_FLAVOUR
SXDC_OS_FLAVOUR=$DEFAULT_OS_FLAVOUR
SXDC_STAGE=$DEFAULT_STAGE

# config file
touch $CONF_FILE
# shellcheck source=~/.oks-sx
source $CONF_FILE


# Create lib
function importImages {
    oc create -f "$1"/openshift-imageStreams.yml -n $SXDC_PROJECT
}

function importBuild {
    oc create -f "$1"/openshift-template-build.yml -n $SXDC_PROJECT
}

function importDeploy {
    oc create -f "$1"/openshift-template-deploy.yml -n $SXDC_PROJECT
}

function testBuild {
    oc process -f "$1"/openshift-template-build.yml -p APP_NAME="$2"-"$3"-build -p APP_STAGE=$SXDC_STAGE -p BUILDER_TAG="$3" -n $SXDC_PROJECT | oc create -f -
}

function testDeployOS {
    oc process -f "$1"/openshift-template-deploy.yml -p APP_NAME="$2"-"$3"-deploy -p APP_STAGE=$SXDC_STAGE -p BUILDER_IMAGE=startx/"$2":"$3" -n $SXDC_PROJECT | oc create -f -
}

function testDeploy {
    oc process -f "$1"/openshift-template-deploy.yml -p APP_NAME="$2"-"$3"-deploy -p APP_STAGE=$SXDC_STAGE -p BUILDER_TAG="$3" -n $SXDC_PROJECT | oc create -f -
}

function temporize {
    x="$1"
    echo "temporize during ${x}sec"
    while [ "$x" -gt 0 ]
    do
        sleep "$2"
        x=$(( "$x" - "$2" ))
        echo "wait for ${x}sec..."
    done
}

## start application

#test if openshift client is present
ov=$(oc version | grep Client)
ovrc="$?"
if [ $ovrc != 0 ]; then
    echo "Openshift is not installed."
    echo "Install openshift client (oc) first"
    echo "Exit"
    exit 1;
else
    echo -e "Openshift client version $ov found"
fi

#test if openshift is connected
ou=`oc whoami`
if [ $? != 0 ]; then
    echo "Openshift is not logged."
    echo "Log to openshift cluster first (oc login -u <user> -p <pwd> <host>)"
    echo "Exit"
    exit 1;
else
    echo -e "Logged as \033[1m$ou\033[0m"
fi

# append key to conf
function appendConf {
    echo "$1=$2" >> $CONF_FILE
}

# reload conf file
function reloadConf {
    # shellcheck source=~/.oks-sx
    source $CONF_FILE
}


# Display general usage
function menuUsage {
cat <<EOF

Startx openshift helper script using local copy of startx docker-images project
to load a remote openshift cluster with startx images and examples

Usage:
  startx-oks-helper.sh [command]

- General commands:
  setup project ≤name>   setup openshift project name
  setup flavour ≤name>   setup startx image flavour (for test only)
  setup stage ≤name>     setup startx stage (for test only)
  setup                  setup project environement (interactive)
  clean                  Clean all test running in the current project
  clean all              Clean all test + images and templates in the current project
  delete                 Remove the current project
  usage                  this message

- Loading commands:
  load                   Load all images and templates
  load-is ≤name>         Load one image streams
  load-is all            Load all images streams
  load-deploy ≤name>     Load one deploy template
  load-deploy all        Load all deploy templates
  load-build ≤name>      Load one build template
  load-build all         Load all build templates

- Test commands:
  test                   Test all templates for the given flavour
  test-deploy ≤name>     Test one deploy template with defined flavour
  test-deploy all        Test all deploy templates with defined flavour
  test-build ≤name>      Test one build template with defined flavour
  test-build all         Test all build templates with defined flavour

EOF
}

# Display menu setup
function menuSetup {
    case $2 in
        project|p)   menuSetupProject "$3" ;;
        flavour|f)   menuSetupFlavour "$3" ;;
        stage|s)     menuSetupStage "$3" ;;
        *)           menuSetupAll "$@" ;;
    esac
}

# Display sub-menu setup
function menuSetupAll {
    menuSetupProject "$2"
    menuSetupFlavour "$2"
    menuSetupStage "$2"
}

# Display sub-menu setup - project
function menuSetupProject {
    if [[ "$1" != "" ]]; then
        appendConf SXDC_PROJECT "$1"
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
    echo -e "Set project name to \e[1m$SXDC_PROJECT\e[0m"
    oc project $SXDC_PROJECT &> /dev/null
    optstrc="$?"
    if [[ "$optstrc" != 0 ]]; then
        echo -e "Creating project \033[1m$SXDC_PROJECT\033[0m"
        oc new-project $SXDC_PROJECT &> /dev/null
    else
        echo -e "Moving to project \033[1m$SXDC_PROJECT\033[0m"
        oc project $SXDC_PROJECT &> /dev/null
    fi
}

# Display sub-menu setup - flavour
function menuSetupFlavour {
    flavour=$DEFAULT_FLAVOUR
    if [[ "$1" != "" ]]; then
        flavour="$1"
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
}

# Display sub-menu setup - stage
function menuSetupStage {
    if [[ "$1" != "" ]]; then
        appendConf SXDC_STAGE "$1"
    else
        echo -en "Project stage \e[2m(\e[0m\e[1m$DEFAULT_STAGE\e[0m\e[2m)\e[0m :"
        read stage
        if [[ "$stage" != "" ]]; then
            appendConf SXDC_STAGE $stage
        else
            appendConf SXDC_STAGE $DEFAULT_STAGE
        fi
    fi
    reloadConf
    echo -e "Set project stage to \e[1m$SXDC_STAGE\e[0m"
}

# Display menu load images streams
function menuLoadIs {
    case $2 in
        os|fedora|centos|alpine)   importImages OS;;
        apache|http)               importImages Services/apache;;
        couchbase)                 importImages Services/couchbase;;
        mariadb|mysql)             importImages Services/mariadb;;
        memcache)                  importImages Services/memcache;;
        mongo)                     importImages Services/mongo;;
        nodejs)                    importImages Services/nodejs;;
        ooconv)                    importImages Services/ooconv;;
        php)                       importImages Services/php;;
        postgres)                  importImages Services/postgres;;
        runner-ansible)            importImages GitlabRunner/ansible;;
        runner-apache)             importImages GitlabRunner/apache;;
        runner-bash)               importImages GitlabRunner/bash;;
        runner-nodejs)             importImages GitlabRunner/nodejs;;
        runner-php)                importImages GitlabRunner/php;;
        runner-oc)                 importImages GitlabRunner/oc;;
        chrome)                    importImages VDI/chrome;;
        firefox)                   importImages VDI/firefox;;
        all)
                                   importImages OS
                                   importImages Services/apache
                                   importImages Services/couchbase
                                   importImages Services/mariadb
                                   importImages Services/memcache
                                   importImages Services/mongo
                                   importImages Services/nodejs
                                   importImages Services/ooconv
                                   importImages Services/php
                                   importImages Services/postgres
                                   importImages GitlabRunner/ansible
                                   importImages GitlabRunner/apache
                                   importImages GitlabRunner/bash
                                   importImages GitlabRunner/nodejs
                                   importImages GitlabRunner/php
                                   importImages VDI/chrome
                                   importImages VDI/firefox;;
        *)                         menuUsage;;
    esac
}

# Display menu load deploy templates
function menuLoadTemplateDeploy {
    case $2 in
        os|fedora|centos|alpine)   importDeploy OS;;
        apache|http)               importDeploy Services/apache;;
        couchbase)                 importDeploy Services/couchbase;;
        mariadb|mysql)             importDeploy Services/mariadb;;
        memcache)                  importDeploy Services/memcache;;
        mongo)                     importDeploy Services/mongo;;
        nodejs)                    importDeploy Services/nodejs;;
        ooconv)                    importDeploy Services/ooconv;;
        php)                       importDeploy Services/php;;
        postgres)                  importDeploy Services/postgres;;
        runner-ansible)            importDeploy GitlabRunner/ansible;;
        runner-apache)             importDeploy GitlabRunner/apache;;
        runner-bash)               importDeploy GitlabRunner/bash;;
        runner-nodejs)             importDeploy GitlabRunner/nodejs;;
        runner-php)                importDeploy GitlabRunner/php;;
        runner-oc)                 importDeploy GitlabRunner/oc;;
        chrome)                    importDeploy VDI/chrome;;
        firefox)                   importDeploy VDI/firefox;;
        all)
                                   importDeploy OS
                                   importDeploy Services/apache
                                   importDeploy Services/couchbase
                                   importDeploy Services/mariadb
                                   importDeploy Services/memcache
                                   importDeploy Services/mongo
                                   importDeploy Services/nodejs
                                   importDeploy Services/ooconv
                                   importDeploy Services/php
                                   importDeploy Services/postgres
                                   importDeploy GitlabRunner/ansible
                                   importDeploy GitlabRunner/apache
                                   importDeploy GitlabRunner/bash
                                   importDeploy GitlabRunner/nodejs
                                   importDeploy GitlabRunner/php
                                   importDeploy VDI/chrome
                                   importDeploy VDI/firefox;;
        *)                         menuUsage;;
    esac
}

# Display menu load build templates
function menuLoadTemplateBuild {
    case $2 in
        os|fedora|centos|alpine)   importBuild OS;;
        apache|http)               importBuild Services/apache;;
        couchbase)                 importBuild Services/couchbase;;
        mariadb|mysql)             importBuild Services/mariadb;;
        memcache)                  importBuild Services/memcache;;
        mongo)                     importBuild Services/mongo;;
        nodejs)                    importBuild Services/nodejs;;
        ooconv)                    importBuild Services/ooconv;;
        php)                       importBuild Services/php;;
        postgres)                  importBuild Services/postgres;;
        runner-ansible)            importBuild GitlabRunner/ansible;;
        runner-apache)             importBuild GitlabRunner/apache;;
        runner-bash)               importBuild GitlabRunner/bash;;
        runner-nodejs)             importBuild GitlabRunner/nodejs;;
        runner-php)                importBuild GitlabRunner/php;;
        runner-oc)                 importBuild GitlabRunner/oc;;
        chrome)                    importBuild VDI/chrome;;
        firefox)                   importBuild VDI/firefox;;
        all)
                                   importBuild OS
                                   importBuild Services/apache
                                   importBuild Services/couchbase
                                   importBuild Services/mariadb
                                   importBuild Services/memcache
                                   importBuild Services/mongo
                                   importBuild Services/nodejs
                                   importBuild Services/ooconv
                                   importBuild Services/php
                                   importBuild Services/postgres
                                   importBuild GitlabRunner/ansible
                                   importBuild GitlabRunner/apache
                                   importBuild GitlabRunner/bash
                                   importBuild GitlabRunner/nodejs
                                   importBuild GitlabRunner/php
                                   importBuild VDI/chrome
                                   importBuild VDI/firefox;;
        *)                         menuUsage;;
    esac
}

# Display menu test build templates
function menuTestBuild {
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
                                   testBuild GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR
                                   testBuild GitlabRunner/apache runner-apache $SXDC_FLAVOUR
                                   testBuild GitlabRunner/bash runner-bash $SXDC_FLAVOUR
                                   testBuild GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
                                   testBuild GitlabRunner/php runner-php $SXDC_FLAVOUR
                                   testBuild GitlabRunner/oc runner-oc $SXDC_FLAVOUR
                                   testBuild VDI/chrome chrome $SXDC_FLAVOUR
                                   testBuild VDI/firefox firefox $SXDC_FLAVOUR;;
        *)                         menuUsage;;
    esac
}

# Display menu test deploy templates
function menuTestDeploy {
    case $2 in
        os|fedora|centos|alpine)   testDeployOS OS $SXDC_OS_FLAVOUR latest;;
        apache|http)               testDeploy Services/apache apache $SXDC_FLAVOUR;;
        couchbase)                 testDeploy Services/couchbase couchbase $SXDC_FLAVOUR;;
        mariadb|mysql)             testDeploy Services/mariadb mariadb $SXDC_FLAVOUR;;
        memcache)                  testDeploy Services/memcache memcache $SXDC_FLAVOUR;;
        mongo)                     testDeploy Services/mongo mongo $SXDC_FLAVOUR;;
        nodejs)                    testDeploy Services/nodejs nodejs $SXDC_FLAVOUR;;
        ooconv)                    testDeploy Services/ooconv ooconv $SXDC_FLAVOUR;;
        php)                       testDeploy Services/php php $SXDC_FLAVOUR;;
        postgres)                  testDeploy Services/postgres postgres $SXDC_FLAVOUR;;
        runner-ansible)            testBuild GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR;;
        runner-apache)             testBuild GitlabRunner/apache runner-apache $SXDC_FLAVOUR;;
        runner-bash)               testBuild GitlabRunner/bash runner-bash $SXDC_FLAVOUR;;
        runner-nodejs)             testBuild GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR;;
        runner-php)                testBuild GitlabRunner/php runner-php $SXDC_FLAVOUR;;
        runner-oc)                 testBuild GitlabRunner/oc runner-oc $SXDC_FLAVOUR;;
        chrome)                    testBuild VDI/chrome chrome $SXDC_FLAVOUR;;
        firefox)                   testBuild VDI/firefox firefox $SXDC_FLAVOUR;;
        all)
                                   testDeployOS OS $SXDC_OS_FLAVOUR latest
                                   testDeploy Services/apache apache $SXDC_FLAVOUR
                                   testDeploy Services/couchbase couchbase $SXDC_FLAVOUR
                                   testDeploy Services/mariadb mariadb $SXDC_FLAVOUR
                                   testDeploy Services/memcache memcache $SXDC_FLAVOUR
                                   testDeploy Services/mongo mongo $SXDC_FLAVOUR
                                   testDeploy Services/nodejs nodejs $SXDC_FLAVOUR
                                   testDeploy Services/ooconv ooconv $SXDC_FLAVOUR
                                   testDeploy Services/php php $SXDC_FLAVOUR
                                   testDeploy Services/postgres postgres $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/ansible runner-ansible $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/apache runner-apache $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/bash runner-bash $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/nodejs runner-nodejs $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/php runner-php $SXDC_FLAVOUR
                                   testDeploy GitlabRunner/oc runner-oc $SXDC_FLAVOUR
                                   testDeploy VDI/chrome chrome $SXDC_FLAVOUR
                                   testDeploy VDI/firefox firefox $SXDC_FLAVOUR;;
        *)                         menuUsage;;
    esac
}

# Display menu clean resources
function menuClean {
    case $2 in
        all)
            oc delete all,secret,configmap -l stage=test -l provider=startx -n $SXDC_PROJECT
        oc delete template,is -l provider=startx -n $SXDC_PROJECT;;
        *)
        oc delete all,secret,configmap -l stage=test -l provider=startx -n $SXDC_PROJECT;;
    esac
    
}

# Display menu load all
function menuLoad {
    menuLoadIs load all
    temporize 8 2
    menuLoadTemplateDeploy load all
    temporize 2 1
    menuLoadTemplateBuild load all
    temporize 2 1
}

# Display menu test all
function menuTest {
    menuTestDeploy deploy all
    temporize 80 20
    menuTestBuild build all
    temporize 120 20
}

# Display menu delete
function menuDelete {
    oc delete project $SXDC_PROJECT
}

# Dispatch input arguments
case $1 in
    setup)                  menuSetup "$@" ;;
    load)                   menuLoad "$@" ;;
    load-is)                menuLoadIs "$@" ;;
    load-deploy)            menuLoadTemplateDeploy "$@" ;;
    load-build)             menuLoadTemplateBuild "$@" ;;
    test)                   menuTest "$@" ;;
    test-deploy)            menuTestDeploy "$@" ;;
    test-build)             menuTestBuild "$@" ;;
    clean)                  menuClean "$@" ;;
    delete)                 menuDelete "$@" ;;
    usage|help|--help)      menuUsage "$@" ;;
    *)                      menuUsage "$@" ;;
esac
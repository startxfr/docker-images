#!/bin/bash
CONF_FILE=~/.oks-sx
DEFAULT_PROJECT=startx
DEFAULT_FLAVOUR=latest
DEFAULT_OS_FLAVOUR=latest
DEFAULT_STAGE=test
SXDC_PROJECT=$DEFAULT_PROJECT
SXDC_FLAVOUR=$DEFAULT_FLAVOUR
SXDC_OS_FLAVOUR=$DEFAULT_OS_FLAVOUR
SXDC_STAGE=$DEFAULT_STAGE

# config file
touch $CONF_FILE
source $CONF_FILE


# Create lib
function importImages {
  oc create -f $1/openshift-imageStreams.yml -n $SXDC_PROJECT
}

function importBuild {
  oc create -f $1/openshift-template-build.yml -n $SXDC_PROJECT
}

function importDeploy {
  oc create -f $1/openshift-template-deploy.yml -n $SXDC_PROJECT
}

function testBuild {
  oc process -f $1/openshift-template-build.yml -p APP_NAME=$2-$3-build -p APP_STAGE=test -p BUILDER_TAG=$3 -n $SXDC_PROJECT | oc create -f -
}

function testDeployOS {
  oc process -f $1/openshift-template-deploy.yml -p APP_NAME=$2-$3-deploy -p APP_STAGE=test -p BUILDER_IMAGE=$2:$3 -n $SXDC_PROJECT | oc create -f -
}

function testDeploy {
  oc process -f $1/openshift-template-deploy.yml -p APP_NAME=$2-$3-deploy -p APP_STAGE=test -p BUILDER_TAG=$3 -n $SXDC_PROJECT | oc create -f -
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

#test if openshift client is present
ov=`oc version | grep openshift`
if [ $? != 0 ]; then
  echo "Openshift is not installed."
  echo "Install openshift client (oc) first"
  echo "Exit"
  exit 1;
else
  echo $ov
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
      project|p)   menuSetupProject $3 ;;
      flavour|f)   menuSetupFlavour $3 ;;
      stage|s)     menuSetupStage $3 ;;
      *)           menuSetupAll $@ ;;
  esac
}

# Display sub-menu setup
function menuSetupAll {
  menuSetupProject $2
  menuSetupFlavour $2
  menuSetupStage $2
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
  echo -e "Set project name to \e[1m$SXDC_PROJECT\e[0m"
  optst=`oc project $SXDC_PROJECT &> /dev/null`
  if [[ $? != 0 ]]; then
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
      centos7)  appendConf SXDC_FLAVOUR centos7
                appendConf SXDC_OS_FLAVOUR 'centos';;
      centos6)  appendConf SXDC_FLAVOUR centos6
                appendConf SXDC_OS_FLAVOUR 'centos';;
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
    appendConf SXDC_STAGE $1
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
                                 importImages Services/postgres;;
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
                                 importDeploy Services/postgres;;
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
                                 importBuild Services/postgres;;
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
                                 testBuild Services/postgres postgres $SXDC_FLAVOUR;;
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
                                 testDeploy Services/postgres postgres $SXDC_FLAVOUR;;
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
    setup)                  menuSetup $@ ;;
    load)                   menuLoad $@ ;;
    load-is)                menuLoadIs $@ ;;
    load-deploy)            menuLoadTemplateDeploy $@ ;;
    load-build)             menuLoadTemplateBuild $@ ;;
    test)                   menuTest $@ ;;
    test-deploy)            menuTestDeploy $@ ;;
    test-build)             menuTestBuild $@ ;;
    clean)                  menuClean $@ ;;
    delete)                 menuDelete $@ ;;
    usage|help|--help)      menuUsage $@ ;;
    *)                      menuUsage $@ ;;
esac









































#!/bin/bash

CONF_FILE=~/.sx-demo
TEMPLATE_BASE=https://raw.githubusercontent.com/startxfr/docker-images
TEMPLATE_BRANCH=master
TEMPLATE_SERVICE=apache
TEMPLATE_DIR=Services/$TEMPLATE_SERVICE
TEMPLATE_URL=$TEMPLATE_BASE/$TEMPLATE_BRANCH/$TEMPLATE_DIR
DEFAULT_PROJECT=demo-storage
DEFAULT_FLAVOUR=latest
SXDC_PROJECT=$DEFAULT_PROJECT
SXDC_FLAVOUR=$DEFAULT_FLAVOUR
SXDC_CLUSTER=https://openshift.cloud.startx.fr:8443
SXDC_USER=dev

# config file
touch $CONF_FILE

# append key to conf
function appendConf {
  echo "$1=$2" >> $CONF_FILE
  export $1=$2
}

# reload conf file
function reloadConf {
  source $CONF_FILE
}

# do menu install
function menuInstall {
	echo -e "Install \033[1mgit,curl, oc\033[0m dependencies"
	sudo yum install -y curl git atomic-openshift-clients 
}

# do menu login
function menuLogin {
	#test if openshift is connected
	ou=`oc whoami`
	if [[ $? != 0 || $2 == 'force' ]]; then
	  	echo "Openshift is not logged."
		echo -en "User name : "
		read un
		echo -en "Password  : "
		read pw
		echo -en "Cluster  \e[2m(\e[0m\e[1m$SXDC_CLUSTER\e[0m\e[2m)\e[0m : "
		read cl
		if [[ "$cl" != "" ]]; then
			appendConf SXDC_CLUSTER $cl
	  		echo -e "Switching to cluster \033[1m$SXDC_CLUSTER\033[0m"
		fi
		if [[ "$un" != "" && "$pw" != "" ]]; then
			lg=`oc login $SXDC_CLUSTER -u $un -p $pw`
			if [[ "$?" != 0 ]]; then
			  	echo -e "Could not login to \033[1m$SXDC_CLUSTER\033[0m with user \033[1m$un\033[0m"
			  	echo -e "Log to openshift cluster first 'oc login $SXDC_CLUSTER -u $un -p <pwd>'"
			  	echo -e "or run 'demo-sx login'"
			  	exit 1;
			else
				appendConf SXDC_USER $un
				echo -e "Logged to \033[1m$SXDC_CLUSTER\033[0m with user \033[1m$SXDC_USER\033[0m"
			  	exit 0;
			fi
		else
		  echo -e "Log to openshift cluster first 'oc login $SXDC_CLUSTER -u <user> -p <pwd>'"
		  echo -e "or run 'demo-sx login'"
		  exit 1;
		fi
	else
		appendConf SXDC_USER $ou
		echo -e "Logged to \033[1m$SXDC_CLUSTER\033[0m with user \033[1m$SXDC_USER\033[0m"
	fi
}

# do menu project
function menuProject {
	#test current project
	pj=`oc project -q`
	pjr=$?
	if [[ $pj != '' && $SXDC_PROJECT != $pj ]]; then
		appendConf SXDC_PROJECT $pj
	fi
	oc project $SXDC_PROJECT &> /dev/null
	pjr=$?
	if [[ $pjr != 0 || $2 = "force" ]]; then
		if [ $2 = "force" ]; then
	  		echo "Force new project"
		else
	  		echo "No project found"
		fi
		echo -en "Project name \e[2m(\e[0m\e[1m$SXDC_PROJECT\e[0m\e[2m)\e[0m : "
		read pjn
		if [[ "$pjn" != "" ]]; then
			appendConf SXDC_PROJECT $pjn
			oc new-project $SXDC_PROJECT
		fi
	fi
	echo -e "Switching to project \033[1m$SXDC_PROJECT\033[0m"
	oc project $SXDC_PROJECT
}

# do menu get
function menuGet {
	echo -e "Get all resource in project \033[1m$SXDC_PROJECT\033[0m"
	oc get secret,configmap,is,template -n $SXDC_PROJECT
}

# do menu load
function menuLoad {
	echo -e "Loading \033[1mstartx\033[0m images streams (10 images x 8 flavours) in project \033[1m$SXDC_PROJECT\033[0m"
	oc create -f $TEMPLATE_BASE/$TEMPLATE_BRANCH/openshift-imageStreams.yml -n $SXDC_PROJECT
	echo -e "Loading template \033[1mstartx-$TEMPLATE_SERVICE-deploy-template\033[0m in project \033[1m$SXDC_PROJECT\033[0m"
	oc create -f $TEMPLATE_URL/openshift-template-deploy.yml -n $SXDC_PROJECT
}

# do menu remove
function menuDelete {
	echo -e "Delete \033[1mstartx\033[0m images streams in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete is,secret,configmap,all -l provider=startx -n $SXDC_PROJECT
	echo -e "Delete template \033[1mstartx-$TEMPLATE_SERVICE-deploy-template\033[0m in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete template startx-$TEMPLATE_SERVICE-deploy-template -n $SXDC_PROJECT
}

# do menu usage
function menuUsage {
cat <<EOF

Startx demo showing various usage of volume storage backend 

Usage:
  demo [command] [sub-command]

- Commands:
  install                Setup openshift client (oc) and auto-completion if installed
  login                  Login to openshift cluster (detect active connection)
  login force            Force re-connection to the openshift cluster
  project                Setup openshift demo project (detect current project)
  project force          Force creating a new project
  load                   Load openshift demo resource (images streams and templates)
  get                    List al ressources used in this demo
  ...                    you must then use a demo sub-command to use this demo script
  delete                 Delete all resources used from this demo


- Ephemeral demo commands:
  ephemeral start        Start ephemeral demo
  ephemeral watch        Watch resources for ephemeral demo resources
  ephemeral ps           List resources for ephemeral demo resources
  ephemeral ls           List storage backend for ephemeral demo
  ephemeral delete       Delete all resources for ephemeral demo

EOF
}

# do sub-menu usage
function menuSubUsage {
cat <<EOF

Startx $2 demo sub-command

Usage:
  demo $2 [command]

- Commands:
  $2 start        Start $2 demo
  $2 watch        Watch resources for $2 demo resources
  $2 ps           List resources for $2 demo resources
  $2 ls           List storage backend for $2 demo
  $2 delete       Delete all resources for $2 demo

EOF
}


## Ephemeral sub-section
# do menu ephemeral
function menuEphemeral {
case $2 in
    start)               
	echo -e "Start \033[1m$TEMPLATE_SERVICE-ephemeral\033[0m demo in project \033[1m$SXDC_PROJECT\033[0m"
	oc process startx-$TEMPLATE_SERVICE-deploy-template -p APP_NAME=$TEMPLATE_SERVICE-ephemeral -n $SXDC_PROJECT | oc create -n $SXDC_PROJECT -f -
	;;
    watch)
	echo -e "Watch \033[1m$TEMPLATE_SERVICE-ephemeral\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-ephemeral_$TEMPLATE_SERVICE-ephemeral | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following ephemeral storage volumes : $listVolumes"
	watch -n .5 "oc get configmap,po,dc,svc,route -n $SXDC_PROJECT; echo ""; ls -la $listVolumes;"
	;;
    ps)
	echo -e "Get all \033[1m$TEMPLATE_SERVICE-ephemeral\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc get configmap,po,dc,svc,route -n $SXDC_PROJECT
	;;
    ls)
	echo -e "List all ephemeral storage for \033[1m$TEMPLATE_SERVICE-ephemeral\033[0m application in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-ephemeral_$TEMPLATE_SERVICE-ephemeral | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following ephemeral storage volumes : $listVolumes"
	ls -la $listVolumes
	;;
    delete)
	echo -e "Delete \033[1m$TEMPLATE_SERVICE-ephemeral\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete all,configmap,secret,pvc,route -l template=startx-$TEMPLATE_SERVICE-deploy-template -n $SXDC_PROJECT
	;;
    *)  menuSubUsage $1 ;;
esac
}


## Volatile sub-section
# do menu volatile
function menuVolatile {
case $2 in
    start)               
	echo -e "Start \033[1m$TEMPLATE_SERVICE-volatile\033[0m demo in project \033[1m$SXDC_PROJECT\033[0m"
	oc process startx-$TEMPLATE_SERVICE-deploy-template -p APP_NAME=$TEMPLATE_SERVICE-volatile -n $SXDC_PROJECT | oc create -n $SXDC_PROJECT -f -
	;;
    watch)
	echo -e "Watch \033[1m$TEMPLATE_SERVICE-volatile\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-volatile_$TEMPLATE_SERVICE-volatile | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following volatile storage volumes : $listVolumes"
	watch -n .5 "oc get configmap,po,dc,svc,route -n $SXDC_PROJECT; echo ""; ls -la $listVolumes;"
	;;
    ps)
	echo -e "Get all \033[1m$TEMPLATE_SERVICE-volatile\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc get configmap,po,dc,svc,route -n $SXDC_PROJECT
	;;
    ls)
	echo -e "List all volatile storage for \033[1m$TEMPLATE_SERVICE-volatile\033[0m application in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-volatile_$TEMPLATE_SERVICE-volatile | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following volatile storage volumes : $listVolumes"
	ls -la $listVolumes
	;;
    delete)
	echo -e "Delete \033[1m$TEMPLATE_SERVICE-volatile\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete all,configmap,secret,pvc,route -l template=startx-$TEMPLATE_SERVICE-deploy-template -n $SXDC_PROJECT
	;;
    *)  menuSubUsage $1 ;;
esac
}

## Resilient sub-section
# do menu Resilient
function menuResilient {
case $2 in
    start)               
	echo -e "Start \033[1m$TEMPLATE_SERVICE-resilient\033[0m demo in project \033[1m$SXDC_PROJECT\033[0m"
	oc process startx-$TEMPLATE_SERVICE-deploy-template -p APP_NAME=$TEMPLATE_SERVICE-resilient -n $SXDC_PROJECT | oc create -n $SXDC_PROJECT -f -
	;;
    watch)
	echo -e "Watch \033[1m$TEMPLATE_SERVICE-resilient\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-resilient_$TEMPLATE_SERVICE-resilient | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following resilient storage volumes : $listVolumes"
	watch -n .5 "oc get configmap,po,dc,svc,route -n $SXDC_PROJECT; echo ""; ls -la $listVolumes;"
	;;
    ps)
	echo -e "Get all \033[1m$TEMPLATE_SERVICE-resilient\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc get configmap,po,dc,svc,route -n $SXDC_PROJECT
	;;
    ls)
	echo -e "List all resilient storage for \033[1m$TEMPLATE_SERVICE-resilient\033[0m application in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-resilient_$TEMPLATE_SERVICE-resilient | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following resilient storage volumes : $listVolumes"
	ls -la $listVolumes
	;;
    delete)
	echo -e "Delete \033[1m$TEMPLATE_SERVICE-resilient\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete all,configmap,secret,pvc,route -l template=startx-$TEMPLATE_SERVICE-deploy-template -n $SXDC_PROJECT
	;;
    *)  menuSubUsage $1 ;;
esac
}

## Distributed sub-section
# do menu Distributed
function menuDistributed {
case $2 in
    start)               
	echo -e "Start \033[1m$TEMPLATE_SERVICE-distributed\033[0m demo in project \033[1m$SXDC_PROJECT\033[0m"
	oc process startx-$TEMPLATE_SERVICE-deploy-template -p APP_NAME=$TEMPLATE_SERVICE-distributed -n $SXDC_PROJECT | oc create -n $SXDC_PROJECT -f -
	;;
    watch)
	echo -e "Watch \033[1m$TEMPLATE_SERVICE-distributed\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-distributed_$TEMPLATE_SERVICE-distributed | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following distributed storage volumes : $listVolumes"
	watch -n .5 "oc get configmap,po,dc,svc,route -n $SXDC_PROJECT; echo ""; ls -la $listVolumes;"
	;;
    ps)
	echo -e "Get all \033[1m$TEMPLATE_SERVICE-distributed\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc get configmap,po,dc,svc,route -n $SXDC_PROJECT
	;;
    ls)
	echo -e "List all distributed storage for \033[1m$TEMPLATE_SERVICE-distributed\033[0m application in project \033[1m$SXDC_PROJECT\033[0m"
	dockerIds=$(docker ps -sa | grep k8s_$TEMPLATE_SERVICE-distributed_$TEMPLATE_SERVICE-distributed | grep "Up " | cut -d\  -f1)
	echo -e "Found the following docker container(s) : $dockerIds"
	listVolumes=$(docker inspect $dockerIds | grep :/var/log/httpd | cut -d\" -f2 | cut -d: -f1 | tr '\n' ' ')
	echo -e "Found the following distributed storage volumes : $listVolumes"
	ls -la $listVolumes
	;;
    delete)
	echo -e "Delete \033[1m$TEMPLATE_SERVICE-distributed\033[0m resources in project \033[1m$SXDC_PROJECT\033[0m"
	oc delete all,configmap,secret,pvc,route -l template=startx-$TEMPLATE_SERVICE-deploy-template -n $SXDC_PROJECT
	;;
    *)  menuSubUsage $1 ;;
esac
}



## Start prog switch
reloadConf
clear
case $1 in
    install)                menuInstall $@ ;;
    login)                  menuLogin $@ ;;
    project)                menuProject $@ ;;
    load)                   menuLoad $@ ;;
    get)                    menuGet $@ ;;
    ephemeral)              menuEphemeral $@ ;;
    volatile)               menuVolatile $@ ;;
    resilient)              menuResilient $@ ;;
    distributed)            menuDistributed $@ ;;
    delete)                 menuDelete $@ ;;
    *)                      menuUsage $@ ;;
esac

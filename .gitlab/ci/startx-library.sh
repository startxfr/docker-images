#!/bin/bash

# 
# set default values
# 

SXDI_VERSION=0.95.29
SXDI_ROOTPATH=$(pwd)
SXDI_ENGINE=${SXDI_ENGINE:-podman}
SXDI_RTMODE=${SXDI_RTMODE:-return}
SXDI_GIT_DOMAIN=${SXDI_GIT_DOMAIN:-gitlab.com}
SXDI_GIT_SSH_USER=${SXDI_GIT_SSH_USER:-git@gitlab.com}
SX_VERBOSE=${SX_VERBOSE:-false}
SX_DEBUG=${SX_DEBUG:-false}
SXDI_PATH=${SXDI_PATH:-OS}
SXDI_OSTAG=${SXDI_OSTAG:-latest}
SXDI_OSNAME=${SXDI_OSNAME:-fedora}
SXDI_OTHERTAG=${SXDI_OTHERTAG:-latest}
SXDI_REGISTRY_NS=${SXDI_REGISTRY_NS:-startx}

# 
# startx gitlab library version 0.0.1-container
# 

# Check if requirements are present
function checkRequirements {
    shellcheck --version &>/dev/null
    if [[ $? != 0 ]]; then
        echo "Missing shellcheck binary, see https://snapcraft.io/install/shellcheck/rhel"
        exit 1
    fi
    mdl --version &>/dev/null
    if [[ $? != 0 ]]; then
        echo "Missing mdl binary, see https://snapcraft.io/install/mdl/rhel"
        exit 1
    fi
    bc --version &>/dev/null
    if [[ $? != 0 ]]; then
        echo "Missing bc binary, execute 'dnf install bc -y'"
        exit 1
    fi
    python3 --version &>/dev/null
    if [[ $? != 0 ]]; then
        echo "Missing python3 binary, see https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/assembly_installing-and-using-python_configuring-basic-system-settings"
        exit 1
    fi
}

# Display the debug checks
function DisplayCheckDebug {
    local VS_PYTHON=$(python3 --version | cut -d ' ' -f 2)
    local MDL_PYTHON=$(mdl --version)
    local SS_PYTHON=$(shellcheck --version | head -n 2 | tail -n 1 | cut -d ':' -f 2 | xargs)
    local DDSIZE=$(du -sh .)
    if [[ $SX_DEBUG == "true" ]]; then
    cat <<EOF
    python version     : $VS_PYTHON
    mdl version        : $MDL_PYTHON
    shellcheck version : $SS_PYTHON
    directory size     : $DDSIZE
EOF
    else
    cat <<EOF
    python version     : $VS_PYTHON
    directory size     : $DDSIZE
EOF
    fi
}

# Display the info checks
function DisplayCheckInfo {
    if [[ $SX_DEBUG == "true" ]]; then
    cat <<EOF
    ======== USER INFO
    ID         : $GITLAB_USER_ID
    e-mail     : $GITLAB_USER_EMAIL
    Username   : $GITLAB_USER_NAME
    
    ======== SERVER INFO
    Hostname   : $HOSTNAME
    Runner     : $CI_RUNNER_DESCRIPTION
    Arch       : $CI_RUNNER_EXECUTABLE_ARCH
    Version    : $CI_RUNNER_VERSION ($CI_SERVER_REVISION)
    Image      : $CI_JOB_IMAGE
    
    ======== PROJECT INFO
    Namespace  : $CI_PROJECT_ROOT_NAMESPACE
    Name       : $CI_PROJECT_TITLE
    Path       : $CI_PROJECT_PATH ($CI_PROJECT_VISIBILITY)
    URL        : $CI_PROJECT_URL
    Language   : $CI_PROJECT_REPOSITORY_LANGUAGES
    Labels     : $CI_PROJECT_CLASSIFICATION_LABEL
    
    ======== JOB INFO
    ID         : $CI_JOB_NAME ($CI_JOB_ID)
    Started    : $CI_JOB_STARTED_AT
    Pipeline   : $CI_PIPELINE_ID ($CI_PIPELINE_CREATED_AT)
    URL        : $CI_PIPELINE_URL
    Language   : $CI_PROJECT_REPOSITORY_LANGUAGES
    Labels     : $CI_PROJECT_CLASSIFICATION_LABEL
    
    ======== COMMIT INFO
    Previous   : $CI_COMMIT_BEFORE_SHA
    Current    : $CI_COMMIT_SHA
    Date       : $CI_COMMIT_TIMESTAMP
    Branch     : $CI_COMMIT_BRANCH
    Autor      : $CI_COMMIT_AUTHOR
    Title      : $CI_COMMIT_TITLE
EOF
    else
    cat <<EOF
    User info  : $GITLAB_USER_ID ($GITLAB_USER_EMAIL)
    Runner     : $HOSTNAME ($CI_RUNNER_EXECUTABLE_ARCH : CI_RUNNER_VERSION ($CI_SERVER_REVISION))
    Image      : $CI_JOB_IMAGE
    Project    : $CI_PROJECT_ROOT_NAMESPACE ($CI_PROJECT_PATH ($CI_PROJECT_VISIBILITY))
    Job ID     : $CI_JOB_NAME ($CI_JOB_ID) - started at $CI_JOB_STARTED_AT
    Pipeline   : $CI_PIPELINE_ID ($CI_PIPELINE_CREATED_AT)
    Commit     : $CI_COMMIT_SHA - at $CI_COMMIT_TIMESTAMP
    Branch     : $CI_COMMIT_BRANCH
    Autor      : $CI_COMMIT_AUTHOR
    Title      : $CI_COMMIT_TITLE
EOF
    fi
}

# Display the requirements checks
function DisplayCheckRequirements {
    echo "INFO:  CHECK REQUIREMENTS"
    DoCheckCheckRequirementsFileExist LICENSE
    DoCheckCheckRequirementsFileExist README.md
    DoCheckCheckRequirementsDirectoryExist docs
    DoCheckCheckRequirementsFileExist docs/index.md
    DoCheckCheckRequirementsFileExecutable podman-helper.sh
    DoCheckCheckRequirementsFileExecutable okd-helper.sh
    DoCheckCheckRequirementsFileExist .gitlab/ci/startx-library.sh
}

# Perform a file check or exit
function DoCheckCheckRequirementsFileExist {
    echo "INFO: Check if file $1 exist"
    if [[ -f $1 ]]; then 
      echo "$1 file is found"; 
    else 
      echo "NO $1 file found"; 
      exit 1; 
    fi
}

# Perform a directory check or exit
function DoCheckCheckRequirementsDirectoryExist {
    echo "INFO: Check if directory $1 exist"
    if [[ -d $1 ]]; then 
      echo "$1 directory is found"; 
    else 
      echo "NO $1 directory found"; 
      exit 1; 
    fi
}

# Perform a file check is binary or exit
function DoCheckCheckRequirementsFileExecutable {
    echo "INFO: Check if file $1 exist and is executable"
    if [[ -f $1 ]]; then 
      echo "$1 is found"; 
      if [[ -x $1 ]]; then 
        echo "$1 is executable"; 
      else 
        echo "Could not execute $1"; 
        exit 1; 
      fi
    else 
      echo "NO $1 is found"; 
      exit 1; 
    fi
}



# Display the markdown checks
function DisplayCheckMarkdown {
    echo "INFO:  CHECK MARKDOWN SYNTAX"
    DoCheckMarkdown "*.md"
    DoCheckMarkdown "docs/*.md"
    DoCheckMarkdown "docs/*/*.md"
}

# Perform a markdown check agaisn't a file expression
function DoCheckMarkdown {
    echo "INFO: Check all markdown file coresponding to $1"
    # shellcheck disable=SC2086
    RESULT=$(mdl --skip-default-ruleset $1)
    if [ "$SX_DEBUG" == "true" ]; then
        echo "$RESULT"
    fi
}

# Display the readthedocs genation
function DisplayCheckReadthedocs {
    echo "INFO:  CHECK READTHEDOCS GENERATION"
    echo "INFO: Readthedocs is generating documentation that can be followed at https://readthedocs.org/projects"
}

# Display the shellcheck checks
function DisplayCheckShellcheck {
    echo "INFO:  CHECK SHELL SYNTAX"
    shellcheck podman-helper.sh
    shellcheck okd-helper.sh
    shellcheck .gitlab/ci/startx-library.sh
}

# Display the build of a container image
function DisplayImageBuild {
    echo "INFO:  BUILD IMAGE"
    DoImageBuildPrepare
}

# Display the build of a container image
function DoImageBuildPrepare {
    echo "INFO:  PREPARE IMAGE BUILD"
    DoImageBuildPrepareDaemon
    if [[ "$DOCKER_USER" == "" || "$DOCKER_PASS" == "" ]]; then
        echo "You must set DOCKER_USER and DOCKER_PASS environments variables"
    else
        DoImageBuildPrepareRepositoryAuth docker.io "$DOCKER_USER" "$DOCKER_PASS"
    fi
    if [[ "$QUAY_USER" == "" || "$QUAY_PASS" == "" ]]; then
        echo "You must set QUAY_USER and QUAY_PASS environments variables"
    else
        DoImageBuildPrepareRepositoryAuth quay.io "$QUAY_USER" "$QUAY_PASS"
    fi
    if [ "$CI_REGISTRY" != "" ]; then
        DoImageBuildPrepareRepositoryAuth "$CI_REGISTRY" "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD"
    fi
}

# Prepare the docker daemon for optimal layer generation
function DoImageBuildPrepareDaemon {
    return 0;
    # echo "INFO: Updating ${SXDI_ENGINE:-docker} configuration"
    # if [ "$SXDI_ENGINE" == "docker" ]; then
    #     echo "INFO: Updating docker configuration (experimental)"
    #     echo '{ "experimental": true, "dns" : [ "8.8.8.8" ], "storage-driver": "overlay2", "max-concurrent-downloads": 50, "max-concurrent-uploads": 50 }' | tee /etc/docker/daemon.json
    #     service docker restart
    # fi
}

# Execute a docker login command for the given registry with the given credentials
function DoImageBuildPrepareRepositoryAuth {
    echo "INFO: Login to $1 registry"
    if [ "$SX_DEBUG" == "true" ]; then
        ${SXDI_ENGINE} login -u "$2" -p "$3" "$1" &> /dev/null
    else
        ${SXDI_ENGINE} login -u "$2" -p "$3" "$1"
    fi
}

# Execute a docker pull of an image comming from the given registry. Must be authenticated prior to this pull if image is private.
function DoImagePullImage {
    echo "INFO: Pull image $1/$2:$3"
    if [[ "$SX_DEBUG" == "true" ]]; then
        ${SXDI_ENGINE} pull "$1/$2:$3" &> /dev/null
    else
        ${SXDI_ENGINE} pull "$1/$2:$3"
    fi
}

# Execute a docker push of an image comming from the given registry. Must be authenticated prior to this push.
function DoImagePushImage {
    echo "INFO: Push image $1/$2:$3"
    if [ "$SX_DEBUG" == "true" ]; then
        ${SXDI_ENGINE} push "$1/$2:$3" &> /dev/null
    else
        ${SXDI_ENGINE} push "$1/$2:$3"
    fi
}

# Execute a docker build
function DoImageBuildExecute {
    local path=${SXDI_ROOTPATH}/${1:-$SXDI_PATH}
    local registry=${2:-localhost}
    local namespace=${3:-$SXDI_REGISTRY_NS}
    local image=${4:-$SXDI_OSNAME}
    local tag=${5:-$SXDI_OSTAG}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local IMAGE_TAG=${registry}/${namespace}/${image}:${tag}
    echo "INFO: Build $path to image ${IMAGE_TAG}"
    cd "$path"  &>/dev/null || ${SXDI_RTMODE} 2
    RESULT=$(${SXDI_ENGINE} build -t "$IMAGE_TAG" .)
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" == "true" ] ; then
            echo "$RESULT"
        fi
        echo "INFO: > BUILDED container image $IMAGE_TAG"
        ${SXDI_RTMODE} 0
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not build container image $IMAGE_TAG"
        if [[ "$ISFATAL" = "true" ]]; then
            ${SXDI_RTMODE} 10;
        else
            ${SXDI_RTMODE} 5;
        fi
    fi
    cd - &>/dev/null || ${SXDI_RTMODE} 2
}

# Test the builded image
function DoImageBuildTest {
    local IMAGE_TAG=${1:-docker.io/startx/fedora}
    local namespace=${2:-$SXDI_REGISTRY_NS}
    local image=${3:-$SXDI_OSNAME}
    local tag=${4:-$SXDI_OSTAG}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local TEST_NAME="$namespace"_"$image"_"$tag"
    echo "INFO: > TEST Container instance $TEST_NAME based on image $IMAGE_TAG"
    ${SXDI_ENGINE} rm -f "$TEST_NAME" &>/dev/null
    RESULT=$(${SXDI_ENGINE} run -d --name "$TEST_NAME" "$IMAGE_TAG")
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" == "true" ] ; then
            echo "$RESULT"
            ${SXDI_ENGINE} logs "$TEST_NAME"
        fi
        echo "INFO: > TESTED Container instance $TEST_NAME"
        echo "$TEST_NAME" > /tmp/istested_"$TEST_NAME"
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not start container instance $TEST_NAME"
        if [[ "$ISFATAL" = "true" ]]; then
            ${SXDI_RTMODE} 20;
        else
            ${SXDI_RTMODE} 0;
        fi
    fi
}

# Test the builded image
function DoImageCleanTest {
    local namespace=${1:-$SXDI_REGISTRY_NS}
    local image=${2:-$SXDI_OSNAME}
    local tag=${3:-$SXDI_OSTAG}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local TEST_NAME="$namespace"_"$image"_"$tag"
    echo "INFO: > CLEAN test Container instance $TEST_NAME"
    RESULT=$(${SXDI_ENGINE} rm -f "$TEST_NAME" &>/dev/null)
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        echo "INFO: > CLEANED Container instance $TEST_NAME"
        if [ "$SX_DEBUG" == "true" ] ; then
            echo "$RESULT"
        fi
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not remove container instance $TEST_NAME"
        ${SXDI_RTMODE} 0;
    fi
}

# Clean the local cached image
function DoImageCleanImage {
    local IMAGE_TAG=${1:-docker.io/startx/fedora}
    echo "INFO: > CLEAN Container instance image $IMAGE_TAG"
    RESULT=$(${SXDI_ENGINE} rmi -f "$IMAGE_TAG" &>/dev/null)
    if [[ "$?" == 0 ]]; then
        echo "INFO: > CLEANED Container image $IMAGE_TAG"
        if [ "$SX_DEBUG" == "true" ] ; then
            echo "$RESULT"
        fi
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not clean container instance $IMAGE_TAG"
        ${SXDI_RTMODE} 0;
    fi
}

# Publish the builded image
function DoImageBuildPublish {
    local registry=${1:-localhost}
    local namespace=${2:-$SXDI_REGISTRY_NS}
    local image=${3:-$SXDI_OSNAME}
    local tag=${4:-$SXDI_OSTAG}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local IMAGE_TAG=${registry}/${namespace}/${image}:${tag}
    local TEST_NAME="$namespace"_"$image"_"$tag"
    echo "INFO: > PUBLISH Container image $IMAGE_TAG"
    if [ -f /tmp/istested_"$TEST_NAME" ] ; then
        DoImagePushImage $IMAGE_TAG
    else
        echo "INFO: > PUBLISHING Container image $IMAGE_TAG skipped because test failed"
        if [[ "$ISFATAL" = "true" ]]; then
            exit 30;
        else
            exit 0;
        fi
    fi
}

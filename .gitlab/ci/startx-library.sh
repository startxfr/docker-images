#!/bin/bash

# 
# set default values
# 

SXDI_VERSION=0.95.31
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
    if ! shellcheck --version &>/dev/null; then
        echo "Missing shellcheck binary, see https://snapcraft.io/install/shellcheck/rhel"
        exit 1
    fi
    if ! mdl --version &>/dev/null; then
        echo "Missing mdl binary, see https://snapcraft.io/install/mdl/rhel"
        exit 1
    fi
    if ! bc --version &>/dev/null; then
        echo "Missing bc binary, execute 'dnf install bc -y'"
        exit 1
    fi
    if ! python3 --version &>/dev/null; then
        echo "Missing python3 binary, see https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/assembly_installing-and-using-python_configuring-basic-system-settings"
        exit 1
    fi
}

# Display the debug checks
function DisplayCheckDebug {
    local VS_PYTHON MDL_PYTHON SS_PYTHON DDSIZE
    VS_PYTHON=$(python3 --version | cut -d ' ' -f 2)
    MDL_PYTHON=$(mdl --version)
    SS_PYTHON=$(shellcheck --version | head -n 2 | tail -n 1 | cut -d ':' -f 2 | xargs)
    DDSIZE=$(du -sh .)
    if [[ $SX_DEBUG != "false" ]]; then
    cat <<EOF
    SXDI version       : $SXDI_VERSION
    python version     : $VS_PYTHON
    mdl version        : $MDL_PYTHON
    shellcheck version : $SS_PYTHON
    directory size     : $DDSIZE
EOF
    else
    cat <<EOF
    SXDI version       : $SXDI_VERSION
    python version     : $VS_PYTHON
    directory size     : $DDSIZE
EOF
    fi
}

# Display the info checks
function DisplayCheckInfo {
    if [[ $SX_DEBUG != "false" ]]; then
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
    if [ "$SX_DEBUG" != "false" ]; then
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
    if [ "$SX_DEBUG" == "false" ]; then
        ${SXDI_ENGINE} login -u "$2" -p "$3" "$1" &> /dev/null
    else
        ${SXDI_ENGINE} login -u "$2" -p "$3" "$1"
    fi
}

# Execute a docker pull of an image comming from the given registry. Must be authenticated prior to this pull if image is private.
function DoImagePullImage {
    echo "INFO: Pull image $1/$2:$3"
    if [[ "$SX_DEBUG" == "false" ]]; then
        ${SXDI_ENGINE} pull "$1/$2:$3" &> /dev/null
    else
        ${SXDI_ENGINE} pull "$1/$2:$3"
    fi
}

# Execute a docker push of an image comming from the given registry. Must be authenticated prior to this push.
function DoImagePushImage {
    echo "INFO: Push image $1"
    if [ "$SX_DEBUG" == "false" ]; then
        ${SXDI_ENGINE} push "$1" &> /dev/null
    else
        ${SXDI_ENGINE} push "$1"
    fi
}

# Execute a cosign on the image
function DoImageSignImage {
    echo "INFO: Signing image $1"
    local image=${1:-"quay.io/startx/fedora:latest"}
    local keyfile=${SXDI_COSIGN_KEY_FILE:-"/tmp/cosign.key"}
    if [ "$SXDI_COSIGN_KEY_RAW64" != "" ]; then
        echo "DEBUG: Found SXDI_COSIGN_KEY_RAW64 environment, generating key file ${keyfile}"
        echo "${SXDI_COSIGN_KEY_RAW64}" | base64 -d > "${keyfile}"
        chmod u+rw "${keyfile}" &> /dev/null
        chmod go-rwx "${keyfile}" &> /dev/null
    fi
    if [ -f "$keyfile" ]; then
        echo "DEBUG: Found ${keyfile} cosign key"
    fi
    if cosign version &> /dev/null
    then
        echo "DEBUG: Signing image is possible because cosign is found"
        if [[ "$DOCKER_USER" != "" && "$DOCKER_PASS" != "" ]]; then
            echo "DEBUG: Cosign login to registry docker.io with user ${DOCKER_USER}"
            cosign login docker.io -u "$DOCKER_USER" -p "$DOCKER_PASS" 
        fi
        if [[ "$QUAY_USER" != "" && "$QUAY_PASS" != "" ]]; then
            echo "DEBUG: Cosign login to registry quay.io with user ${QUAY_USER}"
            cosign login quay.io -u "$QUAY_USER" -p "$QUAY_PASS" 
        fi
        if [[ "$CI_REGISTRY" != "" && "$CI_REGISTRY_USER" != "" ]]; then
            echo "DEBUG: Cosign login to registry ${CI_REGISTRY} with user ${CI_REGISTRY_USER}"
            cosign login "$CI_REGISTRY" -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" 
        fi
        echo "INFO: Signing image ${image}"
        cosign sign -y --key "${keyfile}" "${image}"
    else
        echo "DEBUG: Signing image is not possible because cosign is not found"
    fi
}

# Set the tag according the the gitlab environment variables
function DoSetImagetagFromGitlab {
    local isLatest="${1:-no}"
    local isOS="no"
    case $SXDI_PATH in
        OS) isOS="yes";;
    esac
    if [[ "$isOS" == "yes" ]]; then
        echo "INFO: DoSetImagetagFromGitlab found is an OS image"
        if [[ "$isLatest" == "yes" ]]; then
            echo "INFO: DoSetImagetagFromGitlab found is latest image"
            export SXDI_TAG="latest"
        else
            echo "INFO: DoSetImagetagFromGitlab found is NOT latest image"
            case $CI_COMMIT_BRANCH in
                master)         export SXDI_TAG="latest";;
                centos8)        export SXDI_TAG="8";;
                centos7)        export SXDI_TAG="7";;
                centos6)        export SXDI_TAG="6";;
                ubi8)           export SXDI_TAG="8";;
                rocky)          export SXDI_TAG="8";;
                alma)           export SXDI_TAG="8";;
                alpine)         export SXDI_TAG="3";;
                fc37)           export SXDI_TAG="37";;
                fc36)           export SXDI_TAG="36";;
                fc35)           export SXDI_TAG="35";;
                fc34)           export SXDI_TAG="34";;
                fc33)           export SXDI_TAG="33";;
                fc32)           export SXDI_TAG="32";;
            esac
        fi
        echo "INFO: DoSetImagetagFromGitlab Image will be tagged ${SXDI_TAG}"
    else
        echo "INFO: DoSetImagetagFromGitlab found is NOT an OS image"
        if [[ "$isLatest" == "yes" ]]; then
            echo "INFO: DoSetImagetagFromGitlab found is latest image"
            export SXDI_TAG="latest"
        else
            echo "INFO: DoSetImagetagFromGitlab found is NOT latest image"
            case $CI_COMMIT_BRANCH in
                centos8)        export SXDI_TAG="centos8";;
                centos7)        export SXDI_TAG="centos7";;
                centos6)        export SXDI_TAG="centos6";;
                ubi8)           export SXDI_TAG="ubi8";;
                rocky)          export SXDI_TAG="rocky8";;
                alma)           export SXDI_TAG="alma8";;
                alpine)         export SXDI_TAG="alpine3";;
                fc37)           export SXDI_TAG="fc37";;
                fc36)           export SXDI_TAG="fc36";;
                fc35)           export SXDI_TAG="fc35";;
                fc34)           export SXDI_TAG="fc34";;
                fc33)           export SXDI_TAG="fc33";;
                fc32)           export SXDI_TAG="fc32";;
            esac
        fi
        echo "INFO: DoSetImagetagFromGitlab Image will be tagged ${SXDI_TAG}"
    fi
}

# Execute a docker build for OS environment
function DoImageBuildExecuteAll {
    echo "INFO: Build all images"
    DoImageBuildExecute OS localhost startx "${SXDI_OSNAME}" "${SXDI_OSTAG}"
    DoImageBuildExecute Applications/phpmyadmin localhost startx app-phpmyadmin "${SXDI_OSTAG}"
    DoImageBuildExecute Applications/ocp-reliability localhost startx app-ocp-reliability "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/ansible localhost startx runner-ansible "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/apache localhost startx runner-apache "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/bash localhost startx runner-bash "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/nodejs localhost startx runner-nodejs "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/oc localhost startx runner-oc "${SXDI_OSTAG}"
    DoImageBuildExecute GitlabRunner/php localhost startx runner-php "${SXDI_OSTAG}"
    DoImageBuildExecute VDI/chrome localhost startx vdi-chrome "${SXDI_OSTAG}"
    DoImageBuildExecute VDI/firefox localhost startx vdi-firefox "${SXDI_OSTAG}"
    DoImageBuildExecute Services/apache localhost startx sv-apache "${SXDI_OSTAG}"
    DoImageBuildExecute Services/couchbase localhost startx sv-couchbase "${SXDI_OSTAG}"
    DoImageBuildExecute Services/mariadb localhost startx sv-mariadb "${SXDI_OSTAG}"
    DoImageBuildExecute Services/memcache localhost startx sv-memcache "${SXDI_OSTAG}"
    DoImageBuildExecute Services/mongo localhost startx sv-mongo "${SXDI_OSTAG}"
    DoImageBuildExecute Services/nodejs localhost startx sv-nodejs "${SXDI_OSTAG}"
    DoImageBuildExecute Services/php localhost startx sv-php "${SXDI_OSTAG}"
    DoImageBuildExecute Services/postgres localhost startx sv-postgres "${SXDI_OSTAG}"
}

# Execute a docker build
function DoImageBuildExecute {
    local path=${SXDI_ROOTPATH}/${1:-$SXDI_PATH}
    local registry=${2:-localhost}
    local namespace=${3:-$SXDI_REGISTRY_NS}
    local image=${4:-$SXDI_OSNAME}
    local tag=${5:-$SXDI_OSTAG}
    if [[ "$tag" == "master" || "$tag" == "main" ]]; then
        tag="latest"
    fi
    local IMAGE_TAG=${registry}/${namespace}/${image}:${tag}
    echo "INFO: Build $path to image ${IMAGE_TAG}"
    cd "$path"  &>/dev/null || ${SXDI_RTMODE} 2
    RESULT=$(${SXDI_ENGINE} build -t "$IMAGE_TAG" .)
    RESULTRC=$?
    if [[ "$RESULTRC" == "0" ]]; then
        if [ "$SX_DEBUG" != "false" ] ; then
            echo "$RESULT"
        fi
        echo "INFO: > BUILDED container image $IMAGE_TAG"
        ${SXDI_RTMODE} 0
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not build container image $IMAGE_TAG"
        if [[ "$ISFATAL" == "true" ]]; then
            ${SXDI_RTMODE} 10;
        else
            ${SXDI_RTMODE} 5;
        fi
    fi
    cd - &>/dev/null || ${SXDI_RTMODE} 2
}

# Execute a docker build for OS environment
function DoImageBuildTestAll {
    echo "INFO: Test all images"
    DoImageBuildTest localhost/startx/"${SXDI_OSNAME}":"${SXDI_OSTAG}" startx_"${SXDI_OSNAME}"_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/app-phpmyadmin:"${SXDI_OSTAG}" startx_app-phpmyadmin_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/app-ocp-reliability:"${SXDI_OSTAG}" startx_app-ocp-reliability_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-ansible:"${SXDI_OSTAG}" startx_runner-ansible_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-apache:"${SXDI_OSTAG}" startx_runner-apache_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-bash:"${SXDI_OSTAG}" startx_runner-bash_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-nodejs:"${SXDI_OSTAG}" startx_runner-nodejs_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-oc:"${SXDI_OSTAG}" startx_runner-oc_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/runner-php:"${SXDI_OSTAG}" startx_runner-php_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/vdi-chrome:"${SXDI_OSTAG}" startx_vdi-chrome_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/vdi-firefox:"${SXDI_OSTAG}" startx_vdi-firefox_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-apache:"${SXDI_OSTAG}" startx_sv-apache_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-couchbase:"${SXDI_OSTAG}" startx_sv-couchbase_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-mariadb:"${SXDI_OSTAG}" startx_sv-mariadb_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-memcache:"${SXDI_OSTAG}" startx_sv-memcache_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-mongo:"${SXDI_OSTAG}" startx_sv-mongo_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-nodejs:"${SXDI_OSTAG}" startx_sv-nodejs_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-php:"${SXDI_OSTAG}" startx_sv-php_"${SXDI_OSTAG}"
    DoImageBuildTest localhost/startx/sv-postgres:"${SXDI_OSTAG}" startx_sv-postgres_"${SXDI_OSTAG}"
}

# Test the builded image
function DoImageBuildTest {
    local IMAGE_TAG=${1:-docker.io/startx/fedora}
    local TEST_NAME=${2:-startx_fedora_latest}
    echo "INFO: > TEST Container instance $TEST_NAME based on image $IMAGE_TAG"
    ${SXDI_ENGINE} rm -f "$TEST_NAME" &>/dev/null
    RESULT=$(${SXDI_ENGINE} run -d --name "$TEST_NAME" "$IMAGE_TAG")
    RESULTRC=$?
    if [[ "$RESULTRC" == "0" ]]; then
        if [ "$SX_DEBUG" != "false" ] ; then
            echo "$RESULT"
            ${SXDI_ENGINE} logs "$TEST_NAME"
        fi
        echo "INFO: > TESTED Container instance $TEST_NAME"
        echo "$TEST_NAME" > /tmp/istested_"$TEST_NAME"
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not start container instance $TEST_NAME"
        if [[ "$ISFATAL" == "true" ]]; then
            ${SXDI_RTMODE} 20;
        else
            ${SXDI_RTMODE} 0;
        fi
    fi
}

# Execute a docker build for OS environment
function DoImageCleanTestAll {
    echo "INFO: Clean all test"
    DoImageCleanTest startx "${SXDI_OSNAME}" "${SXDI_OSTAG}"
    DoImageCleanTest startx app-phpmyadmin "${SXDI_OSTAG}"
    DoImageCleanTest startx app-ocp-reliability "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-ansible "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-apache "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-bash "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-nodejs "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-oc "${SXDI_OSTAG}"
    DoImageCleanTest startx runner-php "${SXDI_OSTAG}"
    DoImageCleanTest startx vdi-chrome "${SXDI_OSTAG}"
    DoImageCleanTest startx vdi-firefox "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-apache "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-couchbase "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-mariadb "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-memcache "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-mongo "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-nodejs "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-php "${SXDI_OSTAG}"
    DoImageCleanTest startx sv-postgres "${SXDI_OSTAG}"
}

# Test the builded image
function DoImageCleanTest {
    local namespace=${1:-$SXDI_REGISTRY_NS}
    local image=${2:-$SXDI_OSNAME}
    local tag=${3:-$SXDI_OSTAG}
    if [[ "$tag" == "master" || "$tag" == "main" ]]; then
        tag="latest"
    fi
    local TEST_NAME="$namespace"_"$image"_"$tag"
    echo "INFO: > CLEAN test Container instance $TEST_NAME"
    RESULT=$(${SXDI_ENGINE} rm -f "$TEST_NAME" &>/dev/null)
    RESULTRC=$?
    if [[ "$RESULTRC" == "0" ]]; then
        echo "INFO: > CLEANED Container instance $TEST_NAME"
        if [ "$SX_DEBUG" != "false" ] ; then
            echo "$RESULT"
        fi
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not remove container instance $TEST_NAME"
        ${SXDI_RTMODE} 0;
    fi
}

# Execute a docker build for OS environment
function DoImageCleanImageAll {
    echo "INFO: Clean all images"
    DoImageCleanTest localhost/startx/"${SXDI_OSNAME}":"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/app-phpmyadmin:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/app-ocp-reliability:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-ansible:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-apache:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-bash:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-nodejs:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-oc:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/runner-php:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/vdi-chrome:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/vdi-firefox:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-apache:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-couchbase:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-mariadb:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-memcache:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-mongo:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-nodejs:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-php:"${SXDI_OSTAG}"
    DoImageCleanTest localhost/startx/sv-postgres:"${SXDI_OSTAG}"
}

# Clean the local cached image
function DoImageCleanImage {
    local IMAGE_TAG=${1:-docker.io/startx/fedora}
    echo "INFO: > CLEAN Container instance image $IMAGE_TAG"
    if RESULT=$(${SXDI_ENGINE} rmi -f "$IMAGE_TAG" &>/dev/null); then
        echo "INFO: > CLEANED Container image $IMAGE_TAG"
        if [ "$SX_DEBUG" != "false" ] ; then
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
    local IMAGE_TAG=${1:-"docker.io/startx/fedora:latest"}
    local TEST_NAME=${2:-startx_fedora_latest}
    echo "INFO: > PUBLISH Container image $IMAGE_TAG"
    if [ -f /tmp/istested_"$TEST_NAME" ] ; then
        echo "DEBUG: > Found /tmp/istested_${TEST_NAME}"
        DoImagePushImage "${IMAGE_TAG}"
    else
        echo "DEBUG: > Failed to find /tmp/istested_${TEST_NAME}"
        echo "INFO: > PUBLISHING Container image $IMAGE_TAG skipped because test failed"
        if [[ "$ISFATAL" == "true" ]]; then
            exit 30;
        else
            exit 0;
        fi
    fi
}

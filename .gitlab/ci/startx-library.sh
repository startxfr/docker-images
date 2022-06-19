#!/bin/bash

# 
# startx gitlab library version 0.0.1-container
# 

# Display the debug checks
function DisplayCheckDebug {
    VS_PYTHON=$(python3 --version)
    MDL_PYTHON=$(mdl --version)
    SS_PYTHON=$(shellcheck --version | head -n 2 | tail -n 1)
    DDSIZE=$(du -sh .)
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
    DoImageBuildPrepareRepositoryAuth docker.io "$DOCKER_USER" "$DOCKER_PASS"
    DoImageBuildPrepareRepositoryAuth quay.io "$QUAY_USER" "$QUAY_PASS"
    if [ "$CI_REGISTRY" != "" ]; then
        DoImageBuildPrepareRepositoryAuth "$CI_REGISTRY" "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD"
    fi
}

# Prepare the docker daemon for optimal layer generation
function DoImageBuildPrepareDaemon {
    echo "INFO: Updating ${sxi_docker_images:-docker} configuration"
    # if [ "$sxi_docker_images" == "docker" ]; then
    #     echo "INFO: Updating docker configuration (experimental)"
    #     echo '{ "experimental": true, "dns" : [ "8.8.8.8" ], "storage-driver": "overlay2", "max-concurrent-downloads": 50, "max-concurrent-uploads": 50 }' | tee /etc/docker/daemon.json
    #     service docker restart
    # fi
}

# Execute a docker login command for the given registry with the given credentials
function DoImageBuildPrepareRepositoryAuth {
    echo "INFO: Login to $1 registry"
    if [ "$SX_DEBUG" == "true" ]; then
        ${sxi_docker_images} login -u "$2" -p "$3" "$1" &> /dev/null
    else
        ${sxi_docker_images} login -u "$2" -p "$3" "$1"
    fi
}

# Execute a docker pull of an image comming from the given registry. Must be authenticated prior to this pull if image is private.
function DoImagePullImage {
    echo "INFO: Pull image $1/$2:$3"
    if [[ "$SX_DEBUG" == "true" ]]; then
        ${sxi_docker_images} pull "$1/$2:$3" &> /dev/null
    else
        ${sxi_docker_images} pull "$1/$2:$3"
    fi
}

# Execute a docker push of an image comming from the given registry. Must be authenticated prior to this push.
function DoImagePushImage {
    echo "INFO: Push image $1/$2:$3"
    ${sxi_docker_images} push "$1/$2:$3"
    if [ "$SX_DEBUG" == "true" ]; then
        ${sxi_docker_images} push "$1/$2:$3" &> /dev/null
    else
        ${sxi_docker_images} push "$1/$2:$3"
    fi
}

# Execute a docker build
function DoImageBuildExecute {
    local path=${1:-OS}
    local dockername=${2:-fedora}
    local tag=${4:-latest}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    echo "INFO: Build execute $dockername version $tag in $ns"
    echo "$IMAGE_TAG $IMAGE_QUAYTAG"
    exit
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "INFO: > BUILD Container image $IMAGE_TAG"
    cd "$path"  &>/dev/null || exit
    echo "INFO: Build execute $IMAGE_TAG"
    RESULT=$(${sxi_docker_images} build -t "$IMAGE_TAG" .)
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" = "true" ] ; then
            echo "$RESULT"
        fi
        echo "INFO: > BUILDED container image $IMAGE_TAG"
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not build container image $IMAGE_TAG"
        if [[ "$ISFATAL" = "true" ]]; then
            exit 10;
        else
            exit 0;
        fi
    fi
    cd - &>/dev/null || exit
}

# Test the builded image
function DoImageBuildTest {
    local path=${1:-OS}
    local dockername=${2:-fedora}
    local tag=${4:-latest}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "INFO: > TEST Container instance $TEST_NAME based on image $IMAGE_TAG"
    ${sxi_docker_images} rm -f "$TEST_NAME" &>/dev/null
    RESULT=$(${sxi_docker_images} run -d --name "$TEST_NAME" "$IMAGE_TAG")
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" = "true" ] ; then
            echo "$RESULT"
        fi
        echo "INFO: > TESTED Container instance $TEST_NAME STARTED"
        echo "$TEST_NAME" > /tmp/istested_"$quayname"
    else
        echo "$RESULT"
        echo "!!!!!!!!> Could not start container instance $TEST_NAME"
        if [[ "$ISFATAL" = "true" ]]; then
            exit 20;
        else
            exit 0;
        fi
    fi
}

# Publish the builded image
function DoImageBuildPublish {
    local path=${1:-OS}
    local dockername=${2:-fedora}
    local tag=${4:-latest}
    if [[ "$tag" = "master" || "$tag" = "main" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "INFO: > PUBLISH Container $IMAGE_TAG"
    if [ -f /tmp/istested_"$quayname" ] ; then
        DoImagePushImage docker.io "$ns"/"$dockername" $tag
        echo "INFO: Retag image $IMAGE_TAG to $IMAGE_QUAYTAG"
        ${sxi_docker_images} tag "$IMAGE_TAG" "$IMAGE_QUAYTAG"
        DoImagePushImage quay.io "$ns/$quayname" "$tag"
        echo "INFO: Retag image $IMAGE_TAG to $CI_REGISTRY/startx1/containers/$dockername:$tag"
        ${sxi_docker_images} tag "$IMAGE_TAG" "$CI_REGISTRY/startx1/containers/$dockername:$tag"
        DoImagePushImage "$CI_REGISTRY" "startx1/containers/$dockername" "$tag"
    else
        echo "INFO: > PUBLISHING Container image $IMAGE_TAG skipped because test failed"
        if [[ "$ISFATAL" = "true" ]]; then
            exit 30;
        else
            exit 0;
        fi
    fi
}

#!/bin/bash


# Display the debug checks
function DisplayCheckDebug {
    VS_PYTHON=$(python3 --version)
    MDL_PYTHON=$(mdl --version)
    SS_PYTHON=$(shellcheck --version | head -n 2 | tail -n 1)
    DDSIZE=$(du -sh .)
    if [[ $SX_DEBUG == "true" ]]; then
    cat <<EOF
    ======== DEBUG
    python version     : $VS_PYTHON
    mdl version        : $MDL_PYTHON
    shellcheck version : $SS_PYTHON
    directory size     : $DDSIZE
EOF
    else
    cat <<EOF
    ======== DEBUG
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
    echo "======== CHECK REQUIREMENTS"
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
    echo "==== Check if file $1 exist"
    if [[ -f $1 ]]; then 
      echo "$1 file is found"; 
    else 
      echo "NO $1 file found"; 
      exit 1; 
    fi
}

# Perform a directory check or exit
function DoCheckCheckRequirementsDirectoryExist {
    echo "==== Check if directory $1 exist"
    if [[ -d $1 ]]; then 
      echo "$1 directory is found"; 
    else 
      echo "NO $1 directory found"; 
      exit 1; 
    fi
}

# Perform a file check is binary or exit
function DoCheckCheckRequirementsFileExecutable {
    echo "==== Check if file $1 exist and is executable"
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
    echo "======== CHECK MARKDOWN SYNTAX"
    DoCheckMarkdown "*.md"
    DoCheckMarkdown "docs/*.md"
    DoCheckMarkdown "docs/*/*.md"
}

# Perform a markdown check agaisn't a file expression
function DoCheckMarkdown {
    echo "==== Check all markdown file coresponding to $1"
    RESULT=$("mdl --skip-default-ruleset $1")
    if [ "$SX_DEBUG" == "true" ]; then
        echo "$RESULT"
    fi
}

# Display the readthedocs genation
function DisplayCheckReadthedocs {
    echo "======== CHECK READTHEDOCS GENERATION"
    echo "INFO: Readthedocs is generating documentation that can be followed at https://readthedocs.org/projects/docker-images/"
}

# Display the shellcheck checks
function DisplayCheckShellcheck {
    echo "======== CHECK SHELL SYNTAX"
    shellcheck podman-helper.sh
    shellcheck okd-helper.sh
    shellcheck .gitlab/ci/startx-library.sh
}

# Display the build of a container image
function DisplayImageBuild {
    echo "======== BUILD IMAGE"
    DoImageBuildPrepare
}

# Display the build of a container image
function DoImageBuildPrepare {
    echo "======== PREPARE IMAGE BUILD"
    DoImageBuildPrepareDaemon
    DoImageBuildPrepareRepositoryAuth docker.io "$DOCKER_USER" "$DOCKER_PASS"
    DoImageBuildPrepareRepositoryAuth quay.io "$QUAY_USER" "$QUAY_PASS"
    DoImageBuildPrepareRepositoryAuth "$CI_REGISTRY" "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD"
}

# Prepare the docker daemon for optimal layer generation
function DoImageBuildPrepareDaemon {
    echo "INFO: Updating docker configuration (experimental)"
    # echo '{ "experimental": true, "dns" : [ "8.8.8.8" ], "storage-driver": "overlay2", "max-concurrent-downloads": 50, "max-concurrent-uploads": 50 }' | tee /etc/docker/daemon.json
    # service docker restart
}

# Execute a docker login command for the given registry with the given credentials
function DoImageBuildPrepareRepositoryAuth {
    echo "INFO: Login to $1 registry"
    if [ "$SX_DEBUG" == "true" ]; then
        docker login -u "$2" -p "$3" "$1" &> /dev/null
    else
        docker login -u "$2" -p "$3" "$1"
    fi
}

# Execute a docker pull of an image comming from the given registry. Must be authenticated prior to this pull if image is private.
function DoImagePullImage {
    echo "INFO: Pull image $1/$2:$3"
    if [[ "$SX_DEBUG" == "true" ]]; then
        docker pull "$1/$2:$3" &> /dev/null
    else
        docker pull "$1/$2:$3"
    fi
}

# Execute a docker push of an image comming from the given registry. Must be authenticated prior to this push.
function DoImagePushImage {
    echo "INFO: Push image $1/$2:$3"
    docker push "$1/$2:$3"
    if [ "$SX_DEBUG" == "true" ]; then
        docker push "$1/$2:$3" &> /dev/null
    else
        docker push "$1/$2:$3"
    fi
}

# Execute a docker build
function DoImageBuildExecute {
    local path=${1:-OS}
    local dockername=${2:-fedora}
    local tag=${4:-latest}
    if [[ "$tag" = "master" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "========> BUILD Container image $IMAGE_TAG"
    cd "$path"  &>/dev/null || exit
    RESULT=$(docker build -t "$IMAGE_TAG" .)
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" = "true" ] ; then
            echo "$RESULT"
        fi
        echo "========> BUILDED container image $IMAGE_TAG"
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
    if [[ "$tag" = "master" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "========> TEST Container instance $TEST_NAME based on image $IMAGE_TAG"
    docker rm -f "$TEST_NAME" &>/dev/null
    RESULT=$(docker run -d --name "$TEST_NAME" "$IMAGE_TAG")
    RESULTRC=$?
    if [[ "$RESULTRC" = "0" ]]; then
        if [ "$SX_DEBUG" = "true" ] ; then
            echo "$RESULT"
        fi
        echo "========> TESTED Container instance $TEST_NAME STARTED"
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
    if [[ "$tag" = "master" ]]; then
        tag="latest"
    fi
    local quayname=${3:-fedora}
    local ns=${5:-startx}
    IMAGE_TAG=docker.io/$ns/$dockername:$tag
    IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
    TEST_NAME="$ns"_"$quayname"_"$tag"
    echo "========> PUBLISH Container $IMAGE_TAG"
    if [ -f /tmp/istested_"$quayname" ] ; then
        DoImagePushImage docker.io "$ns"/"$dockername" $tag
        echo "INFO: Retag image $IMAGE_TAG to $IMAGE_QUAYTAG"
        docker tag "$IMAGE_TAG" "$IMAGE_QUAYTAG"
        DoImagePushImage quay.io "$ns/$quayname" "$tag"
    else
        echo "========> PUBLISHING Container image $IMAGE_TAG skipped because test failed"
        if [[ "$ISFATAL" = "true" ]]; then
            exit 30;
        else
            exit 0;
        fi
    fi
}

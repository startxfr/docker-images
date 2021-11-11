#!/bin/bash


# Display the debug checks
function DisplayCheckDebug {
    VS_PYTHON=$(python3 --version)
    MDL_PYTHON=$(mdl --version)
    SS_PYTHON=$(shellcheck --version)
    DDSIZE=$(du -sh .)
    if [[ $SX_DEBUG == true ]]; then
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
    if [[ $SX_DEBUG == true ]]; then
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
    if [[ -f LICENSE ]]; then 
      echo "LICENSE is found"; 
    else 
      echo "NO LICENSE file found"; 
      exit 1; 
    fi
    if [[ -f README.md ]]; then 
      echo "README.md is found"; 
    else 
      echo "NO README.md file found"; 
      exit 1; 
    fi
    if [[ -d docs ]]; then 
      echo "docs directory is found"; 
    else 
      echo "NO docs directory found"; 
      exit 1; 
    fi
    if [[ -f podman-helper.sh ]]; then 
      echo "podman-helper.sh is found"; 
      if [[ -x podman-helper.sh ]]; then 
        echo "podman-helper.sh is executable"; 
      else 
        echo "Could not execute podman-helper.sh"; 
        exit 1; 
      fi
    else 
      echo "NO podman-helper.sh is found"; 
      exit 1; 
    fi
    if [[ -f okd-helper.sh ]]; then 
      echo "okd-helper.sh is found"; 
      if [[ -x okd-helper.sh ]]; then 
        echo "okd-helper.sh is executable"; 
      else 
        echo "Could not execute okd-helper.sh"; 
        exit 1; 
      fi
    else 
      echo "NO okd-helper.sh is found"; 
      exit 1; 
    fi
}


# Display the markdown checks
function DisplayCheckMarkdown {
    mdl --skip-default-ruleset *.md
}

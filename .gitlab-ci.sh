#!/bin/bash


# Display the debug context
function DisplayContextDebug {
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





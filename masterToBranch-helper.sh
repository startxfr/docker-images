#!/bin/bash
ORIGIN_REPO_URL=https://startxfr1@gitlab.com/startx1/containers.git

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
            exit 4;
        fi
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


# merge master into a target branch
function exectuteMerge {
    if [ $2 == "" ]; then
        echo "You must give a tag name"
        echo "please run 'masterToBranch-helper.sh run  fc34' first"
        exit 5;
    fi
    git checkout $2 && git merge master && git checkout master
}


# merge master into a target branch
function exectutePush {
    type=$2
    if [ $2 == "" ]; then
        type="all"
    fi
    if [ $type == "all" ]; then
        git checkout master && git push origin master fc36 fc35 fc34 fc33 fc32 fc31 fc30 ubi8 alpine centos8 centos7 centos6
    else
        git checkout master && git push origin $2
    fi
}




# Display general usage
function menuUsage {
cat <<EOF

merge master to image tag helper

Usage:
  masterToBranch-helper.sh [command]

- General commands:
  simulate  ≤name>       simulate a merge to the target branch
  run ≤name>             execute a merge to the target branch
  push ≤name>            push one branch
  push all               push all branch
  usage                  this message

EOF
}




checkReadyForRun

# Dispatch input arguments
case $1 in
    simulate)               simulateMerge $@ ;;
    run|exec|merge)         exectuteMerge $@ ;;
    push)                   exectutePush $@ ;;
    *)                      menuUsage $@ ;;
esac


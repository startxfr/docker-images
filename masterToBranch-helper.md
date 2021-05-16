[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true)](https://github.com/startxfr/docker-images)

# STARTX masterToBranch Helper

This script will help you propagate updates from master branch to a distribution relase branch.

## Requirements

This script assume :

- You have a Centos/RHEL 8 environment running with all updates applied
- You have installed git
- You have cloned this repository content (git clone https://github.com/startxfr/docker-images)
- You are in the root directory of your cloned copy of this repository

## simulate a merge

```bash
# simulate merge from master to  fc33 branch (default)
./masterToBranch.sh  fc33

# simulate merge from master to fc33 branch with specified command
./masterToBranch.sh  fc33 simulate
```

## execute a merge

```bash
# execute a merge from master to  fc33 branch
./masterToBranch.sh  fc33 run
```

version= 0.95.29
SXGLCI_GIT_DOMAIN= gitlab.com
SXGLCI_GIT_SSH_USER= git@gitlab.com
SX_VERBOSE=true
SX_DEBUG=false
SXGLCI_OSTAG=latest
SXGLCI_OSNAME=fedora
SXGLCI_OTHERTAG=latest
SXGLCI_ENGINE=podman
SXGLCI_PATH: "OS"
export  SXGLCI_GIT_DOMAIN \
		SXGLCI_GIT_SSH_USER \
		SX_VERBOSE \
		SX_DEBUG \
		DOCKER_USER \
		DOCKER_PASS \
		QUAY_USER \
		QUAY_PASS \
		SXGLCI_OSTAG \
		SXGLCI_OSNAME \
		SXGLCI_OTHERTAG \
		SXGLCI_ENGINE \
		SXGLCI_PATH

# Generic actions (default is local)
# all action
.PHONY: all
all: build test clean
# build action
.PHONY: build
build: build-local
# test action
.PHONY: test
test: test-local
# clean action
.PHONY: clean
clean: clean-local
# mrproper action
mrproper: clean-local 

# Local actions
# all local actions
all-local: build-local test-local clean-local
# build local action
# build-local: SHELL:=/bin/bash
build-local: 
	@echo "======== BUILD LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		DoImageBuildPrepare && \
		DoImageBuildExecute ${SXGLCI_PATH} ${SXGLCI_DOCKERNAME} ${SXGLCI_QUAYNAME} ${SXGLCI_TAG} startx
		DoImageBuildExecute ${SXGLCI_PATH} ${QUAY_USER} ${SXGLCI_QUAYNAME} ${SXGLCI_TAG} startx

    # IMAGE_QUAYTAG=quay.io/$ns/$quayname:$tag
# test local action
test-local: 
	@echo "======== TEST LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		ExecCollectionTest
# clean local action
clean-local: 
	@echo "======== CLEAN LOCAL"
	@bash -c "source .gitlab/ci/startx-library.sh && ExecCollectionClean"

# Gitlab actions
# all gitlab actions
all-gitlab: build-gitlab test-gitlab publish-gitlab
# build local action
build-gitlab: 
	@echo "======== BUILD GITLAB"
	@bash -c "source .gitlab/ci/startx-library.sh && ExecCollectionBuild"
# test local action
test-gitlab: 
	@echo "======== TEST GITLAB"
	@bash -c "source .gitlab/ci/startx-library.sh && ExecCollectionTest"
# clean local action
publish-gitlab: 
	@echo "======== PUBLISH GITLAB"
	@bash -c "source .gitlab/ci/startx-library.sh && ExecCollectionPublish"
# clean local action
clean-gitlab: 
	@echo "======== CLEAN GITLAB"
	@bash -c "source .gitlab/ci/startx-library.sh && ExecCollectionClean"

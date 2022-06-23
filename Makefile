SXDI_GIT_DOMAIN=gitlab.com
SXDI_GIT_SSH_USER=git@gitlab.com
SX_VERBOSE=true
SX_DEBUG=false
SXDI_OSTAG=latest
SXDI_OSNAME=fedora
SXDI_OTHERTAG=latest
SXDI_ENGINE=podman
SXDI_PATH=OS
SXDI_REGISTRY_NS=startx
SXDI_RTMODE=return
export  SXDI_GIT_DOMAIN \
		SXDI_GIT_SSH_USER \
		SX_VERBOSE \
		SX_DEBUG \
		DOCKER_USER \
		DOCKER_PASS \
		QUAY_USER \
		QUAY_PASS \
		SXDI_OSTAG \
		SXDI_OSNAME \
		SXDI_OTHERTAG \
		SXDI_ENGINE \
		SXDI_PATH \
		SXDI_REGISTRY_NS \
		SXDI_RTMODE

# Generic actions (default is local)
# all action
.PHONY: all
all: all-local 
# build action
.PHONY: build
build: check-local build-local
# test action
.PHONY: test
test: check-local test-local
# clean action
.PHONY: clean
clean: check-local clean-local
# mrproper action
mrproper: check-local clean-local 

# Local actions
# all local actions
all-local: check-local build-local test-local clean-local
# check local action
check-local:
	@echo "======== CHECK LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		checkRequirements && \
		DisplayCheckDebug

# build local action
# build-local: SHELL:=/bin/bash
build-local: 
	@echo "======== BUILD LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		DoImageBuildPrepare && \
		DoImageBuildExecuteAll
# test local action
test-local: 
	@echo "======== TEST LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		DoImageBuildTestAll
# clean local action
clean-local: 
	@echo "======== CLEAN LOCAL"
	@source .gitlab/ci/startx-library.sh && \
		DoImageCleanTestAll && \
		DoImageCleanImageAll

# Gitlab actions
# all gitlab actions
all-gitlab: build-gitlab test-gitlab publish-gitlab
# build local action
build-gitlab: 
	@echo "======== BUILD GITLAB"
	@source .gitlab/ci/startx-library.sh && \
		DoImageBuildPrepare && \
		DoImageBuildExecute ${SXDI_PATH} docker.io startx ${SXDI_OSNAME} ${SXDI_OSTAG} && \
		DoImageBuildExecute ${SXDI_PATH} quay.io startx ${SXDI_OSNAME} ${SXDI_OSTAG}
# test local action
test-gitlab: 
	@echo "======== TEST GITLAB"
	@source .gitlab/ci/startx-library.sh && \
		ExecCollectionTest
# clean local action
publish-gitlab: 
	@echo "======== PUBLISH GITLAB"
	@source .gitlab/ci/startx-library.sh && \
		ExecCollectionPublish
# clean local action
clean-gitlab: 
	@echo "======== CLEAN GITLAB"
	@source .gitlab/ci/startx-library.sh && \
		ExecCollectionClean

.SILENT:
.DEFAULT_GOAL := help

MAKESTER__REPO_NAME := loum

include makester/makefiles/makester.mk

#
# Makester overrides.
#
# Container image build.
# Tagging convention used: <UBUNTU_CODE>-<PYTHON3-VERSION>-<MAKESTER__RELEASE_NUMBER>
UBUNTU_CODE ?= jammy
PYTHON_MAJOR_MINOR_VERSION ?= 3.11
PYTHON_RELEASE_VERSION ?= 1

PYTHON3_VERSION := $(PYTHON_MAJOR_MINOR_VERSION).$(PYTHON_RELEASE_VERSION)
MAKESTER__VERSION := $(UBUNTU_CODE)-$(PYTHON3_VERSION)
MAKESTER__RELEASE_NUMBER := 1

export UBUNTU_BASE_IMAGE ?= 20221130

MAKESTER__BUILD_COMMAND = --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=ubuntu:$(UBUNTU_CODE)-$(UBUNTU_BASE_IMAGE)\
 --build-arg PYTHON3_VERSION=$(PYTHON3_VERSION)\
 -t $(MAKESTER__IMAGE_TAG_ALIAS) .

# Makester container image run command.
CMD :=
MAKESTER__CONTAINER_NAME := python3-ubuntu
MAKESTER__RUN_COMMAND := $(MAKESTER__DOCKER) run --rm -ti\
 --name $(MAKESTER__CONTAINER_NAME)\
 $(MAKESTER__SERVICE_NAME):$(HASH) $(CMD)

#
# Local Makefile targets.
#
# Initialise the development environment.
init: py-venv-clear py-venv-init py-install-makester

image-pull-into-docker:
	$(info ### Pulling local registry image $(MAKESTER__SERVICE_NAME):$(HASH) into docker)
	$(MAKESTER__DOCKER) pull $(MAKESTER__SERVICE_NAME):$(HASH)

image-tag-in-docker: image-pull-into-docker
	$(info ### Tagging local registry image $(MAKESTER__SERVICE_NAME):$(HASH) for docker)
	$(MAKESTER__DOCKER) tag $(MAKESTER__SERVICE_NAME):$(HASH) $(MAKESTER__STATIC_SERVICE_NAME):$(HASH)

image-transfer: image-tag-in-docker
	$(info ### Deleting pulled local registry image $(MAKESTER__SERVICE_NAME):$(HASH))
	$(MAKESTER__DOCKER) rmi $(MAKESTER__SERVICE_NAME):$(HASH)

multi-arch-build: image-registry-start image-buildx-builder
	$(info ### Starting multi-arch builds ...)
	$(MAKE) MAKESTER__DOCKER_PLATFORM=linux/arm64,linux/amd64 image-buildx
	$(MAKE) image-transfer
	$(MAKE) image-registry-stop

image-tag-major: MAKESTER__IMAGE_TARGET_TAG = $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
image-tag-major: image-tag

image tag-major-rm: MAKESTER__IMAGE_TARGET_TAG = $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
image-tag-major-rm: image-rm

# Container image command targets.
python-version:
	$(MAKE) container-run CMD=--version

help: makester-help
	@echo "(Makefile)\n\
  init                 Build the local development environment\n\
  multi-arch-build     Convenience target for multi-arch container image builds\n\
  python-version       Container run Python3 version\n"

.PHONY: help

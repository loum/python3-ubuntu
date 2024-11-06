.SILENT:
.DEFAULT_GOAL := help
#
# Makester overrides.
#
MAKESTER__STANDALONE := true
MAKESTER__INCLUDES := py docker
MAKESTER__REPO_NAME := loum

include $(HOME)/.makester/makefiles/makester.mk

# Container image build.
# Tagging convention used: <UBUNTU_CODE>-<PYTHON3-VERSION>-<MAKESTER__RELEASE_NUMBER>
ifndef UBUNTU_CODE
  UBUNTU_CODE ?= noble
endif
PYTHON_MAJOR_MINOR_VERSION ?= 3.12
PYTHON_RELEASE_VERSION ?= 6

PYTHON3_VERSION := $(PYTHON_MAJOR_MINOR_VERSION).$(PYTHON_RELEASE_VERSION)
MAKESTER__VERSION := $(UBUNTU_CODE)-$(PYTHON3_VERSION)
MAKESTER__RELEASE_NUMBER := 1

ifndef UBUNTU_BASE_IMAGE_VERSION
  UBUNTU_BASE_IMAGE_VERSION := 20241011
endif
export UBUNTU_BASE_IMAGE := ubuntu:$(UBUNTU_CODE)-$(UBUNTU_BASE_IMAGE_VERSION)

IMAGE_UID ?= 49899
IMAGE_USER ?= user
IMAGE_GROUP ?= user

MAKESTER__BUILD_COMMAND = --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$(UBUNTU_BASE_IMAGE)\
 --build-arg PYTHON3_VERSION=$(PYTHON3_VERSION)\
 --build-arg UID=$(IMAGE_UID)\
 --build-arg USER=$(IMAGE_USER)\
 --build-arg GROUP=$(IMAGE_GROUP)\
 --tag $(MAKESTER__IMAGE_TAG_ALIAS) .

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

image-bulk-build:
	$(info ### Container image bulk build ($(UBUNTU_CODE)) ...)
	UBUNTU_CODE=$(UBUNTU_CODE) scripts/bulkbuild.sh

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

image-tag-major: MAKESTER__IMAGE_TARGET_TAG := $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
image-tag-major: image-tag

image-tag-major-rm: MAKESTER__IMAGE_TARGET_TAG := $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
image-tag-major-rm: image-rm

# Container image command targets.
python-version:
	$(MAKE) container-run CMD=--version

help: makester-help
	@echo "(Makefile)\n\
  init                 Build the local development environment\n\
  image-bulk-build     Build all multi-platform container images\n\
  image-tag-major      Tag image $(MAKESTER__SERVICE_NAME) \"$(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)\"\n\
  image-tag-major-rm   Undo \"image-tag-major\"\n\
  multi-arch-build     Convenience target for multi-arch container image builds\n\
  python-version       Container run Python3 version\n"

.PHONY: help

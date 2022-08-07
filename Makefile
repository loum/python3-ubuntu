.SILENT:
.DEFAULT_GOAL := help

MAKESTER__REPO_NAME := loum

# Tagging convention used: <UBUNTU_CODE>-<PYTHON3-VERSION>-<MAKESTER__RELEASE_NUMBER>
UBUNTU_CODE ?= jammy
PYTHON_MAJOR_MINOR_VERSION ?= 3.10
PYTHON_RELEASE_VERSION ?= 5
PYTHON3_VERSION ?= $(PYTHON_MAJOR_MINOR_VERSION).$(PYTHON_RELEASE_VERSION)
MAKESTER__VERSION ?= $(UBUNTU_CODE)-$(PYTHON3_VERSION)
MAKESTER__RELEASE_NUMBER = 1

include makester/makefiles/makester.mk
include makester/makefiles/docker.mk
include makester/makefiles/python-venv.mk

UBUNTU_BASE_IMAGE := ubuntu:$(UBUNTU_CODE)-20220801

MAKESTER__BUILD_COMMAND = $(DOCKER) build --rm\
 --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$(UBUNTU_BASE_IMAGE)\
 --build-arg PYTHON3_VERSION=$(PYTHON3_VERSION)\
 -t $(MAKESTER__IMAGE_TAG_ALIAS) .

MAKESTER__CONTAINER_NAME := python3-ubuntu
MAKESTER__RUN_COMMAND := $(DOCKER) run --rm -ti\
 --name $(MAKESTER__CONTAINER_NAME)\
 $(MAKESTER__SERVICE_NAME):$(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION) $(CMD)

MAKESTER__IMAGE_TARGET_TAG = $(HASH)

tag-major: MAKESTER__IMAGE_TARGET_TAG = $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
tag-major: tag

tag-rm-major: MAKESTER__IMAGE_TARGET_TAG = $(UBUNTU_CODE)-$(PYTHON_MAJOR_MINOR_VERSION)
tag-rm-major: rmi

init: clear-env makester-requirements

python-version:
	$(MAKE) run CMD=--version

help: makester-help docker-help python-venv-help
	@echo "(Makefile)\n\
  login                Login to running container $(MAKESTER__CONTAINER_NAME) as user \"root\"\n\
  python-version       Python3 version\"\n"

.PHONY: help

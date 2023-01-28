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
PYTHON_RELEASE_VERSION ?= 0

PYTHON3_VERSION := $(PYTHON_MAJOR_MINOR_VERSION).$(PYTHON_RELEASE_VERSION)
MAKESTER__VERSION := $(UBUNTU_CODE)-$(PYTHON3_VERSION)
MAKESTER__RELEASE_NUMBER := 1

MAKESTER__BUILD_COMMAND = --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=ubuntu:$(UBUNTU_CODE)-20221130\
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

# Container image command targets.
python-version:
	$(MAKE) container-run CMD=--version

help: makester-help
	@echo "(Makefile)\n\
  init                 Build the local development environment\n\
  python-version       Container run Python3 version\n"

.PHONY: help

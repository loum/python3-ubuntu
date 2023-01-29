# Python3 on Ubuntu
- [Overview](#overview)
- [Quick Links](#quick-links)
- [Prequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [(macOS Users only) Upgrading GNU Make](#macos-users-only-upgrading-gnu-make)
  - [Creating the Local Environment](#creating-the-local-environment)
    - [Local Environment Maintenance](#local-environment-maintenance)
- [Help](#Help)
- [Docker Image Development and Management](#docker-image-development-and-management)
  - [Building the Docker](#building-the-docker)
  - [Searching Images](#searching-images)
  - [Image Tagging](#image-tagging)
  - [Building the Image with a different Python 3 version](#building-the-image-with-a-different-python-3-version)
- [Interact with Python3](#interact-with-python3)

## Overview
This repository manages the customised Docker image build of Python3 on Ubuntu. You can target any Python 3 verions against any Ubuntu release. Just follow the `makester` settings below.

Bypassing the [Docker Hub Official Image Python](https://hub.docker.com/_/python>) image build is much more work, but gives us more flexibility to address CVEs.

The image build process is based on [GitHub Python project's Docker build](https://github.com/docker-library/python/blob/e0e01b8482ea14352c710134329cdd93ece88317/3.8/buster/slim/Dockerfile) with a switch to Ubuntu base. Not sure why there isn't a Ubuntu variant available in the [Official Python images](https://hub.docker.com/_/python)?

## Quick Links
- [Ubuntu](https://ubuntu.com/)
- [Python 3](https://www.python.org/)

## Prerequisties
- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- Python 3 Interpreter. [We recommend installing pyenv](https://github.com/pyenv/pyenv)
- [Docker](https://www.docker.com/)

## Getting Started
[Makester](https://loum.github.io/makester/) is used as the Integrated Developer Platform.

### (macOS Users only) Upgrading GNU Make
Follow [these notes](https://loum.github.io/makester/macos/#upgrading-gnu-make-macos) to get [GNU make](https://www.gnu.org/software/make/manual/make.html).

### Creating the Local Environment
Get the code and change into the top level `git` project directory:
```
git clone https://github.com/loum/python3-ubuntu.git && cd python3-ubuntu
```

> **_NOTE:_** Run all commands from the top-level directory of the `git` repository.

For first-time setup, get the [Makester project](https://github.com/loum/makester.git):
```
git submodule update --init
```

Initialise the environment:
```
make init
```

#### Local Environment Maintenance
Keep [Makester project](https://github.com/loum/makester.git) up-to-date with:
```
git submodule update --remote --merge
```

## Help
There should be a `make` target to be able to get most things done. Check the help for more information:
```
make help
```

## Docker Image Development and Management

### Building the Image
> **_NOTE:_** Ubuntu base image is [jammy 22.04](https://hub.docker.com/_/ubuntu)

Build the image with:
```
make image-buildx
```
### Searching Images
To list the available Docker images::
```
make image-search
```
### Image Tagging
By default, `makester` will tag the new Docker image with the current branch hash. This provides a degree of uniqueness but is not very intuitive. That's where the `tag-version` `Makefile` target can help. To apply tag as per project tagging convention `<ubuntu-code>-<python3-version>-<image-release-number>`:
```
make image-tag-version
```
To tag the image as `latest`
```
make image-tag-latest
```
To tag the image main line (without the `<image-release-number>` that ensures the latest Ubuntu release:
```
make image-tag-main
```

### Building the Image with a different Python 3 version
During the image build, a fresh compile of the Python binaries is performed. In theory, any Python release under https://www.python.org/ftp/python/ can be used. You will need to supply the `PYTHON_MAJOR_MINOR_VERSION` and `PYTHON_RELEASE_VERSION` to the image build target. For example, to build an image with Python 3.10.4:
```
PYTHON_MAJOR_MINOR_VERSION=3.10 PYTHON_RELEASE_VERSION=4 make image-buildx
```

To validate the image runs as expected:
```
make container-run
```

On success this will drop you into the Python interpreter.

## Interact with Python3
To get the Python3 version:
```
make python-version
```

---
[top](#python3-on-ubuntu)

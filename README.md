# Python3 on Ubuntu

- [Overview](#overview)
- [Quick Links](#quick-links)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [(macOS users only) upgrading GNU make](#macos-users-only-upgrading-gnu-make)
  - [Creating the local environment](#creating-the-local-environment)
  - [Local environment maintenance](#local-environment-maintenance)
- [Help](#help)
- [Docker Image Development and Management](#docker-image-development-and-management)
  - [Building the container image](#building-the-container-image)
  - [Searching images](#searching-images)
  - [Image tagging](#image-tagging)
  - [Building the image with a different Python 3 version](#building-the-image-with-a-different-python-3-version)
- [Interact with Python3](#interact-with-python3)

## Overview

This repository manages the customised Docker image build of Python3 on Ubuntu. You can target any Python 3 verions against any Ubuntu release. Just follow the `makester` settings below.

Bypassing the [Docker Hub Official Image Python](https://hub.docker.com/_/python) image build is much more work, but gives us more flexibility to address CVEs.

The image build process is based on [GitHub Python project's Docker build](https://github.com/docker-library/python/blob/e0e01b8482ea14352c710134329cdd93ece88317/3.8/buster/slim/Dockerfile) with a switch to Ubuntu base. Not sure why there isn't a Ubuntu variant available in the [Official Python images](https://hub.docker.com/_/python)?

## Quick Links

- [Ubuntu](https://ubuntu.com/)
- [Python 3](https://www.python.org/)

## Prerequisites

- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- Python 3 Interpreter. [We recommend installing pyenv](https://github.com/pyenv/pyenv)
- [Docker](https://www.docker.com/)

## Getting Started

[Makester](https://loum.github.io/makester/) is used as the Integrated Developer Platform.

### (macOS users only) upgrading GNU make

Follow [these notes](https://loum.github.io/makester/macos/#upgrading-gnu-make-macos) to get [GNU make](https://www.gnu.org/software/make/manual/make.html).

### Creating the local environment

Get the code and change into the top level `git` project directory:

```
git clone https://github.com/loum/python3-ubuntu.git && cd python3-ubuntu
```

> \[!NOTE\]
>
> Run all commands from the top-level directory of the `git` repository.

For first-time setup, get the [Makester project](https://github.com/loum/makester.git):

```
git submodule update --init
```

Initialise the environment:

```
make init
```

#### Local environment maintenance

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

### Building the container image

> \[!NOTE\]
>
> Ubuntu base image is [jammy 22.04](https://hub.docker.com/_/ubuntu)

Build the image with:

```
make image-buildx
```

By default, the container image will build with the `user:group` combinatation `user:user`. The
`user` `uid` is `49899`. It is possible to override these values during the container build
process by providing values for the `Makefile` variables `IMAGE_UID`, `IMAGE_USER` and
`IMAGE_GROUP`. This is demonstrated in the following `make` plan:

```
make -n IMAGE_UID=2000 IMAGE_USER=dodge IMAGE_GROUP=dodgier image-buildx
```

### Searching images

To list the available Docker images::

```
make image-search
```

### Image tagging

By default, `makester` will tag the new Docker image with the current branch hash. This provides a degree of uniqueness but is not very intuitive. That is where the `tag-version` `Makefile` target can help. To apply tag as per project tagging convention `<ubuntu-code>-<python3-version>-<image-release-number>`:

```
make image-tag-version
```

Example output: `loum/python3-ubuntu:jammy-3.11.1-1`

To tag the image as `latest`

```
make image-tag-latest
```

Example output: `loum/python3-ubuntu:latest`

To tag the image main line (without the `<image-release-number>` that ensures the latest Ubuntu release:

```
make image-tag-major
```

Example output: `loum/python3-jammy-3.11`

### Building the image with a different Python 3 version

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

______________________________________________________________________

[top](#python3-on-ubuntu)

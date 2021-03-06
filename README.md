# Python3 on Ubuntu
- [Overview](#Overview)
- [Quick Links](#Quick-Links)
- [Prequisites](#Prerequisites)
  - [Upgrading GNU Make (macOS)](#Upgrading-GNU-Make-(macOS))
- [Getting Started](#Getting-Started)
  - [Building the Local Environment](#Building-the-Local-Environment)
    - [Local Environment Maintenance](#Local-Environment-Maintenance)
- [Help](#Help)
- [Docker Image Development and Management](#Docker-Image-Development-and-Management)
  - [Building the Docker Image](#Building-the-Docker-Image)
  - [Searching Images](#Searching-Images)
  - [Image Tagging](#Image-Tagging)
  - [Building the Image with a different Python 3 version](#Building-the-Image-with-a-different-Python-3-version)
- [Interact with Python3](#Interact-with-Python3)
- [FAQs](#FAQs)

## Overview
This repository manages the customised Docker image build of Python3 on Ubuntu.  You can target any Python 3 verions against any Ubuntu release -- just follow the `makester` settings below.

Bypassing the [Docker Hub Official Image Python](https://hub.docker.com/_/python>) image build is much more work, but gives us more flexibility to address CVEs.

The image build process is based on [GitHub Python project's Docker build](https://github.com/docker-library/python/blob/e0e01b8482ea14352c710134329cdd93ece88317/3.8/buster/slim/Dockerfile) with a switch to Ubuntu base.  Not sure why there isn't a Ubuntu variant available in the [Official Python images](https://hub.docker.com/_/python)?

## Quick Links
- [Ubuntu](https://ubuntu.com/)
- [Python 3](https://www.python.org/)

## Prerequisties
- [Docker](https://docs.docker.com/install/)
- [GNU make](<https://www.gnu.org/software/make/manual/make.html>)

### Upgrading GNU Make (macOS)
Although the macOS machines provide a working GNU `make` it is too old to support the capabilities within the DevOps utilities
package, [makester](https://github.com/loum/makester).  Instead, it is recommended to upgrade to the GNU make version provided
by Homebrew.  Detailed instructions can be found at https://formulae.brew.sh/formula/make.  In short, to upgrade GNU make run:
```
brew install make
```
The `make` utility installed by Homebrew can be accessed by `gmake`.  The https://formulae.brew.sh/formula/make notes suggest how you can update your local `PATH` to use `gmake` as `make`.  Alternatively, alias `make`:
```
alias make=gmake
```
## Getting Started
### Building the Local Environment
Get the code and change into the top level `git` project directory:
```
git clone https://github.com/loum/python3-ubuntu.git && cd python3-ubuntu
```
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
There should be a `make` target to be able to get most things done.  Check the help for more information:
```
make help
```
## Docker Image Development and Management
### Building the Image
> **_NOTE:_** Ubuntu base image is [jammy 22.04](https://hub.docker.com/_/ubuntu)

Build the image with:
```
make build-image
```
### Searching Images
To list the available Docker images::
```
make search-image
```
### Image Tagging
By default, `makester` will tag the new Docker image with the current branch hash.  This provides a degree of uniqueness but is not very intuitive.  That's where the `tag-version` `Makefile` target can help.  To apply tag as per project tagging convention `<ubuntu-code>-<python3-version>-<image-release-number>`:
```
make tag-version
```
To tag the image as `latest`
```
make tag-latest
```
To tag the image main line (without the `<image-release-number>` that ensures the latest Ubuntu focal release:
```
make tag-main
```
### Building the Image with a different Python 3 version
During the image build, a fresh compile of the Python binaries is performed. In theory, any Python release under https://www.python.org/ftp/python/ can be used. You will need to supply the `PYTHON_MAJOR_MINOR_VERSION` and `PYTHON_RELEASE_VERSION` to the image build target. For example, to build an image with Python 3.10.4:
```
PYTHON_MAJOR_MINOR_VERSION=3.10 PYTHON_RELEASE_VERSION=4 make build-image
```
To validate the image runs as expected:
```
make run
```
On success this will drop you into the Python interpreter.

## Interact with Python3
To get the Python3 version:
```
make python-version
```
To start the Python3 interpreter:
```
make run
```
## FAQs
**_Q. Why is the default make on macOS so old?_**
Apple seems to have an issue with licensing around GNU products: more specifically to the terms of the GPLv3 license agreement. It is unlikely that Apple will provide current versions of utilities that are bound by the GPLv3 licensing constraints.

---
[top](#Python3-on-Ubuntu)

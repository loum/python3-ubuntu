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
- [FAQs](#FAQs)

## Overview
This repository manages the customised Docker image build of Python3 on Ubuntu.  You can target any Python 3 verions against any Ubuntu release -- just follow the `makester` settings below.

Bypassing the [Docker Hub Official Image Python](https://hub.docker.com/_/python>) image build is much more work, but gives us more flexibility to address CVEs.

The image build process is based on [GitHub Python project's Docker build](https://github.com/docker-library/python/blob/e0e01b8482ea14352c710134329cdd93ece88317/3.8/buster/slim/Dockerfile) with a switch to Ubuntu base.  Not sure why there isn't a Ubuntu variant available in the [Official Python images](https://hub.docker.com/_/python)?

## Quick Links
- [Ubuntu](https://ubuntu.com/)
- [Python](https://www.python.org/)

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
> **_NOTE:_** Ubuntu base image is [focal 20.04](https://github.com/tianon/docker-brew-ubuntu-core/blob/fc9c4ef6e3d4891577936f0b103331e79e1e8281/focal/Dockerfile)

Build the image with:
```
make build-image
```
### Searching Images
To list the available Docker images::
```
make search-image
```
## FAQs
**_Q. Why is the default make on macOS so old?_**
Apple seems to have an issue with licensing around GNU products: more specifically to the terms of the GPLv3 license agreement. It is unlikely that Apple will provide current versions of utilities that are bound by the GPLv3 licensing constraints.

---
[top](#Python3-on-Ubuntu)

#!/bin/sh

_UBUNTU_CODE="${UBUNTU_CODE:-noble}"
echo "$_UBUNTU_CODE"

# Python 3.8 (end of life, last release was 3.8.20).
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.8.19\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.8.19 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.8.20\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.8\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.8.20 .

# Python 3.9.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.9.19\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.9.19 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.9.20\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.9\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.9.20 .

# Python 3.10.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.10.14\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.10.14 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.10.15\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.10\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.10.15 .

# Python 3.11.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.11.9\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.11.9 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.11.10\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.11\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.11.10 .

# Python 3.12.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.12.6\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.12.6 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.12.7\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.12\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.12.7 .

# Python 3.13 and latest.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE="$UBUNTU_BASE_IMAGE"\
 --build-arg PYTHON3_VERSION=3.13.0\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.13\
 -t loum/python3-ubuntu:"$_UBUNTU_CODE"-3.13.0\
 -t loum/python3-ubuntu:latest .

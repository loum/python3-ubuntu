#!/bin/sh

# Python 3.8.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.16\
 -t loum/python3-ubuntu:jammy-3.8.16 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.17\
 -t loum/python3-ubuntu:jammy-3.8\
 -t loum/python3-ubuntu:jammy-3.8.17 .

## Python 3.9.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.16\
 -t loum/python3-ubuntu:jammy-3.9.16 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.17\
 -t loum/python3-ubuntu:jammy-3.9\
 -t loum/python3-ubuntu:jammy-3.9.17 .

# Python 3.10.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.11\
 -t loum/python3-ubuntu:jammy-3.10.11 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.12\
 -t loum/python3-ubuntu:jammy-3.10\
 -t loum/python3-ubuntu:jammy-3.10.12 .

# Python 3.11 and latest.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.3\
 -t loum/python3-ubuntu:jammy-3.11.3 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.4\
 -t loum/python3-ubuntu:jammy-3.11\
 -t loum/python3-ubuntu:jammy-3.11.4\
 -t loum/python3-ubuntu:latest .

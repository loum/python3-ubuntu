#!/bin/sh

# Python 3.8.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.17\
 -t loum/python3-ubuntu:jammy-3.8.17 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.18\
 -t loum/python3-ubuntu:jammy-3.8\
 -t loum/python3-ubuntu:jammy-3.8.18 .

# Python 3.9.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.17\
 -t loum/python3-ubuntu:jammy-3.9.17 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.18\
 -t loum/python3-ubuntu:jammy-3.9\
 -t loum/python3-ubuntu:jammy-3.9.18 .

# Python 3.10.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.12\
 -t loum/python3-ubuntu:jammy-3.10.12 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.13\
 -t loum/python3-ubuntu:jammy-3.10\
 -t loum/python3-ubuntu:jammy-3.10.13 .

# Python 3.11.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.5\
 -t loum/python3-ubuntu:jammy-3.11.5 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.6\
 -t loum/python3-ubuntu:jammy-3.11\
 -t loum/python3-ubuntu:jammy-3.11.6\
 -t loum/python3-ubuntu:latest .

# Python 3.12 and latest.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.12.0\
 -t loum/python3-ubuntu:jammy-3.12\
 -t loum/python3-ubuntu:jammy-3.12.0\
 -t loum/python3-ubuntu:latest .

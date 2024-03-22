#!/bin/sh

# Python 3.8.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.18\
 -t loum/python3-ubuntu:jammy-3.8.18 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.8.19\
 -t loum/python3-ubuntu:jammy-3.8\
 -t loum/python3-ubuntu:jammy-3.8.19 .

# Python 3.9.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.18\
 -t loum/python3-ubuntu:jammy-3.9.18 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.9.19\
 -t loum/python3-ubuntu:jammy-3.9\
 -t loum/python3-ubuntu:jammy-3.9.19 .

# Python 3.10.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.13\
 -t loum/python3-ubuntu:jammy-3.10.13 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.10.14\
 -t loum/python3-ubuntu:jammy-3.10\
 -t loum/python3-ubuntu:jammy-3.10.14 .

# Python 3.11.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.7\
 -t loum/python3-ubuntu:jammy-3.11.7 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.11.8\
 -t loum/python3-ubuntu:jammy-3.11\
 -t loum/python3-ubuntu:jammy-3.11.8\
 -t loum/python3-ubuntu:latest .

# Python 3.12 and latest.
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.12.1\
 -t loum/python3-ubuntu:jammy-3.12.1 .

docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$UBUNTU_BASE_IMAGE\
 --build-arg PYTHON3_VERSION=3.12.2\
 -t loum/python3-ubuntu:jammy-3.12\
 -t loum/python3-ubuntu:jammy-3.12.2\
 -t loum/python3-ubuntu:latest .

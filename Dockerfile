ARG UBUNTU_BASE_IMAGE

FROM ubuntu:$UBUNTU_BASE_IMAGE

ARG PYTHON3_VERSION
ARG PYTHON3_PIP
RUN apt-get update && apt-get install -y --no-install-recommends\
 python3.8=$PYTHON3_VERSION\
 python3-pip=$PYTHON3_PIP\
 python-is-python3 &&\
 rm -rf /var/lib/apt/lists/*

RUN python -m pip install --user --no-cache-dir --upgrade pip

ENTRYPOINT [ "python3" ]
CMD []

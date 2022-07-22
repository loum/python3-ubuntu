ARG UBUNTU_BASE_IMAGE
ARG PYTHON3_VERSION=3.10.4

FROM ubuntu:$UBUNTU_BASE_IMAGE AS builder

RUN apt-get update && apt-get install -y --no-install-recommends\
 wget\
 xz-utils\
 build-essential\
 zlib1g-dev\
 libncurses5-dev\
 libgdbm-dev\
 libnss3-dev\
 libssl-dev\
 libsqlite3-dev\
 libreadline-dev\
 libffi-dev\
 curl\
 libbz2-dev\
 pkg-config\
 ca-certificates

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Compile and install the target Python version
WORKDIR /opt
ARG PYTHON3_VERSION
RUN wget -qO-\
 https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tar.xz |\
 tar -xJf -
WORKDIR Python-$PYTHON3_VERSION
RUN ./configure\
 --prefix=/opt/python/$PYTHON3_VERSION\
 --enable-optimizations\
 --enable-shared\
 LDFLAGS=-Wl,-rpath=/opt/python/$PYTHON3_VERSION/lib,--disable-new-dtags
RUN make -j 6
RUN make install

### downloader layer end

ARG UBUNTU_BASE_IMAGE

FROM ubuntu:$UBUNTU_BASE_IMAGE

ARG PYTHON3_PIP
RUN apt-get update && apt-get install -y --no-install-recommends\
 make\
 python3-pip=$PYTHON3_PIP &&\
 rm -rf /var/lib/apt/lists/*

ARG PYTHON3_VERSION
WORKDIR /opt/python/$PYTHON3_VERSION
COPY --from=builder /opt/python/$PYTHON3_VERSION .
RUN update-alternatives --install /usr/bin/python python /opt/python/$PYTHON3_VERSION/bin/python3 1

ENTRYPOINT [ "python" ]
CMD []

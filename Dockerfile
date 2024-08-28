# syntax=docker/dockerfile:1.4

ARG UBUNTU_BASE_IMAGE
ARG PYTHON3_VERSION

FROM $UBUNTU_BASE_IMAGE AS builder

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
 ca-certificates &&\
 apt-get autoremove -yqq --purge &&\
 rm -rf /var/lib/apt/lists/* &&\
 rm -rf /var/log/*

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

### builder layer end

ARG UBUNTU_BASE_IMAGE

FROM $UBUNTU_BASE_IMAGE AS main

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections &&\
 apt-get update && apt-get install -y --no-install-recommends\
 adduser\
 gcc\
 make\
 python3-dev &&\
 apt-get autoremove -yqq --purge &&\
 rm -rf /var/lib/apt/lists/* &&\
 rm -rf /var/log/*

ARG UID=49899
ARG USER=user
ARG GROUP=user

RUN addgroup $GROUP && useradd -m --uid $UID --gid $GROUP --shell /bin/bash $USER

ARG PYTHON3_VERSION
WORKDIR /opt/python/$PYTHON3_VERSION
COPY --from=builder /opt/python/$PYTHON3_VERSION .
RUN update-alternatives --install /usr/local/bin/python python /opt/python/$PYTHON3_VERSION/bin/python3 1 &&\
 update-alternatives --install /usr/local/bin/python3 python3 /opt/python/$PYTHON3_VERSION/bin/python3 1 &&\
 update-alternatives --install /usr/local/bin/pip pip /opt/python/$PYTHON3_VERSION/bin/pip3 1 &&\
 python -m pip install --user --no-cache-dir --upgrade pip
 
USER $USER
WORKDIR /home/$USER

ENTRYPOINT [ "/usr/local/bin/python" ]
CMD []

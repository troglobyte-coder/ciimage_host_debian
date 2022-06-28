#
# Troglobyte AppHub:
# author: Michael Gene Brockus
# mail: <mailto: michaelbrockus@gmail.com>
#
FROM debian:bullseye AS dummy

# setting basic image info
ENV DEBIAN_FRONTEND noninteractive
ENV LANG 'C.UTF-8'
ENV CI 1

# setting compiler env vars
ENV CC ccache gcc
ENV CXX ccache g++

FROM dummy AS getter

RUN apt-get update --fix-missing && apt-get upgrade -y \
    && apt-get -y install \
       apt-utils \
       python3 \
       python3-pip \
       gcc \
       g++\
       git \
       ccache \
       cppcheck \
       libncurses5-dev \
       libncursesw5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 -q install --upgrade pip \
    && python3 -m pip -q install \
       meson==0.62.2 \
       scan-build==2.0.20 \
       ninja==1.10.2.3 \
       cmake==3.22.5

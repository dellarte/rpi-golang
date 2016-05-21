
# Pull base image
FROM resin/rpi-raspbian:latest
FROM hypriot/rpi-golang:1.4.2
MAINTAINER Adam Gavin <gavinadam80@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    gcc \
    libc6-dev \
    make \
    git \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Compile Go from source
ENV GOROOT_BOOTSTRAP /goroot
ENV GOLANG_VERSION 1.6.2
#ADD ./etc/services /etc/services
RUN \
    mkdir -p /goroot1.6.2 && \
    git clone https://go.googlesource.com/go /goroot1.6.2 && \
    cd /goroot1.6.2 && \
    git checkout go$GOLANG_VERSION && \
    cd /goroot1.6.2/src && \
    GOARM=7 ./make.bash

# Set environment variables
ENV GOROOT /goroot1.6.2
ENV GOPATH /gopath1.6.2
ENV GOARM 7
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Define working directory
WORKDIR /gopath1.6.2

# Define default command
CMD ["bash"]

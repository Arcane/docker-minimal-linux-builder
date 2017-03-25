FROM        ubuntu:trusty

ENV         IMG_VERSION 03-Apr-2016

# Install dependencies for minimal linux live and qemu, git...
# see http://minimal.linux-bg.org/
RUN         DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
            wget build-essential bc syslinux genisoimage busybox-static \
            libncurses5-dev git tree

RUN         git clone https://github.com/ivandavidov/minimal/ && \
            cd minimal && \
            git checkout $IMG_VERSION && \
            mkdir -p /minimal/output
VOLUME		/minimal/output

#ADD         ./run /minimal/src/
#ADD         ./fix-dns /minimal/src/
ADD         ./startup.sh /minimal/src
WORKDIR     /minimal/src
CMD         ./startup.sh

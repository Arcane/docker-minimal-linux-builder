FROM        ubuntu:trusty

#ENV         IMG_VERSION 03-Apr-2016
ENV         IMG_VERSION 07-Feb-2015

# Install dependencies for minimal linux live and qemu, git...
# see http://minimal.linux-bg.org/
RUN         DEBIAN_FRONTEND=noninteractive && \
			apt-get update && apt-get install -y \
            wget build-essential bc syslinux genisoimage busybox-static \
            libncurses5-dev git tree

RUN         git clone https://github.com/ivandavidov/minimal/ && \
            cd minimal && \
            git checkout $IMG_VERSION && \
            mkdir -p /minimal/output
ADD         ./*.sh /minimal/src/

# That's for ImageVersion of Feb
RUN			sed -i \
				"s/^\(.*5_generate_rootfs.sh\)/sh 5_pre_generate_rootfs.sh\n\1\nsh 5_post_generate_rootfs.sh/g" \
				/minimal/src/build_minimal_linux_live.sh
RUN			cat /minimal/src/build_minimal_linux_live.sh

VOLUME		/minimal/output
WORKDIR     /minimal/src
CMD         ./startup.sh

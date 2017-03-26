FROM        ubuntu:trusty

#TODO: Upgrade to this version:
#ENV         IMG_VERSION 20-Jan-2017
ENV         IMG_VERSION 07-Feb-2015

# Install dependencies for minimal linux live and qemu, git...
# see http://minimal.linux-bg.org/
RUN         DEBIAN_FRONTEND=noninteractive && \
			apt-get update && apt-get install -y \
            wget build-essential bc syslinux genisoimage busybox-static \
            libncurses5-dev git tree realpath pkg-config

RUN         git clone https://github.com/ivandavidov/minimal/ && \
            cd minimal && \
            git checkout $IMG_VERSION && \
            mkdir -p /minimal/output

VOLUME		/minimal/output
WORKDIR     /minimal/src

# That's for ImageVersion of Feb
RUN			sed -i \
				"s/^\(.*5_generate_rootfs.sh\)/sh 5_pre_generate_rootfs.sh\n\1\nsh 5_post_generate_rootfs.sh/g" \
				build_minimal_linux_live.sh

# Split the file for get and actual build.
RUN         csplit -f "temp" build_minimal_linux_live.sh "/sh 5_generate/" && \
			mv temp00 prepare_minimal_linux_live.sh && \
			mv temp01 build_minimal_linux_live.sh && \
			chmod +x ./*_minimal_linux_live.sh

# Append post script now - to cache result of prepare.
COPY        ./5_pre_generate_rootfs.sh /minimal/src/
RUN         ./prepare_minimal_linux_live.sh

# Finally, Append my scripts over it.
COPY        ./5_post_generate_rootfs.sh ./startup.sh /minimal/src/
CMD         ./startup.sh

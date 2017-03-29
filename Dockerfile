FROM        ubuntu:xenial

#TODO: Upgrade to this version:
ENV         IMG_VERSION 20-Jan-2017

# Install dependencies for minimal linux live and qemu, git...
# see http://minimal.linux-bg.org/
RUN         DEBIAN_FRONTEND=noninteractive && \
			apt-get update && apt-get install -y \
            wget build-essential bc syslinux-utils genisoimage busybox-static \
            libncurses5-dev git tree realpath pkg-config time gawk file cpio

RUN         git clone https://github.com/ivandavidov/minimal/ && \
            cd minimal && \
            git checkout $IMG_VERSION && \
            mkdir -p /minimal/output

VOLUME		/minimal/output
WORKDIR     /minimal/src

# Fixing scripts
RUN			sed -i \
				"s/^\(.*09_generate_rootfs.sh\)/time sh 09_pre_generate_rootfs.sh\n\1\ntime sh 09_post_generate_rootfs.sh\ntime sh 10_pre_pack_rootfs.sh/g" \
				build_minimal_linux_live.sh && \
			sed -i \
				"s/^\(.*02_build_kernel.sh\)/time sh 02_pre_build_kernel.sh\n\1/g" \
				build_minimal_linux_live.sh && \
			sed -i \
				"s/\(COPY_SOURCE_ROOTFS=\).*/\1false/g" \
				.config && \
            csplit -f "temp" build_minimal_linux_live.sh "/sh 10_pre_pack/" && \
			mv temp00 prepare_minimal_linux_live.sh && \
			mv temp01 build_minimal_linux_live.sh && \
			chmod +x ./*_minimal_linux_live.sh

# Append post script now - to cache result of prepare.
COPY        rootfs_merge /minimal/src/rootfs_merge
COPY        kernel_patches /minimal/src/kernel_patches
COPY        ./02_pre_build_kernel.sh ./09_pre_generate_rootfs.sh ./09_post_generate_rootfs.sh ./startup.sh /minimal/src/
RUN         ./prepare_minimal_linux_live.sh

# Finally, Append my scripts over it.
COPY        ./10_pre_pack_rootfs.sh /minimal/src/
CMD         ./startup.sh

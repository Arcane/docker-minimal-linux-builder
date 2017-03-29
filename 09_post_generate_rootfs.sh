#!/bin/sh

SYSROOT=`realpath work/rootfs`

build_python() {
	cd work/python

	./configure --prefix=${SYSROOT} LDFLAGS="--sysroot=${SYSROOT}" CFLAGS="--sysroot=${SYSROOT}"
	make
	make install

	cd ../..
}

# build_ncurses() {
# 	cd work/ncurses
# 	./configure --prefix=${SYSROOT}
# 	make
# 	make install
#
# 	cd ../..
# }

fix_glibc() {
	# TODO: Copy only needed libraries.
	cp -Rf work/glibc/glibc_prepared/* ${SYSROOT}
}

fix_rootfs() {
	cp -Rfp rootfs_merge/* ${SYSROOT}
}

# 1. Fix GLIBC
fix_glibc

# 2. Fix rootfs scripts
fix_rootfs

# 3. Build & install ncurses
# build_ncurses

# 3. Build & Install Python
build_python

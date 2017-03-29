#!/bin/sh

build_python() {
	cd work/python
	mkdir -p ../rootfs
	./configure --prefix=$(realpath ../rootfs)
	make
	# TODO: return test
	# make test
	make install
	cd ..
}

fix_glibc() {
	# Copy GLIBC Related files.
	cd work

	# TODO: Copy only needed libraries.
	cp -Rf glibc/glibc_prepared/* rootfs/

	cd ..
}

fix_rootfs() {
	pwd
	cp -Rfp rootfs_merge/* work/rootfs/
}

# 1. Fix GLIBC
fix_glibc

# 2. Fix rootfs scripts
fix_rootfs

# 3. Build & Install Python
build_python

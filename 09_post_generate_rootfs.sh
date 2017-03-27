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

# 1. Fix GLIBC
fix_glibc

# 2. Build & Install Python
build_python

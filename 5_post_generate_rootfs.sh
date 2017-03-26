#!/bin/sh

build_python() {
	cd work/python
	mkdir -p ../rootfs
	./configure --prefix=$(realpath ../rootfs)
	make
	make test
	make install
	cd ..
}

# 1. Build & Install Python
build_python

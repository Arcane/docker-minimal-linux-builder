#!/bin/sh

# Easier to test here, so debug here and replace in 5_post_rootfs
# TODO: Replace with MicroPython once working.
# install_micropython() {
# 	cd work/python
# 	PREFIX=$(realpath ../../rootfs) make install
# 	cd ..
# }
#
# STATIC_MICROPYTHON_SOURCE_URL=https://github.com/micropython/micropython/archive/v1.8.7.tar.gz
#
# get_micropython() {
# 	DOWNLOAD_URL=$STATIC_MICROPYTHON_SOURCE_URL
#
# 	# Grab everything after the last '/' character
# 	ARCHIVE_FILE=${DOWNLOAD_URL##*/}
# 	EXTRACTED_DIR=micropython-1.8.7
# 	#EXTRACTED_DIR=${EXTRACTED_DIR%.*}
#
# 	cd source || exit 1
#
# 	# Downloading static python binary
# 	# -c option allows the download to resume
# 	wget -c $DOWNLOAD_URL
# 	rm -rf $EXTRACTED_DIR
# 	tar -zxf $ARCHIVE_FILE
#
# 	# Delete folder with previously extracted static python
# 	rm -rf ../work/python
#
# 	# Copy static python to folder 'python'
# 	mv $EXTRACTED_DIR ../work/python
#
# 	cd ..
# }
#
# build_micropython() {
# 	cd work/python/unix
# 	#./configure --prefix=$(realpath ../rootfs)
# 	mkdir -p ../../rootfs
# 	PREFIX=$(realpath ../../rootfs) make
# 	PREFIX=$(realpath ../../rootfs) make test
# 	cd ../..
# }

fix_rootfs() {
	cp -Rfp rootfs_merge/* work/rootfs/
}

echo "Pre Pack - Fixing RootFS"
fix_rootfs

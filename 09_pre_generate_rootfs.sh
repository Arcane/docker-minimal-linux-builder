#!/bin/sh

STATIC_PYTHON_SOURCE_URL=https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz

get_python() {
	DOWNLOAD_URL=$STATIC_PYTHON_SOURCE_URL

	# Grab everything after the last '/' character
	ARCHIVE_FILE=${DOWNLOAD_URL##*/}
	EXTRACTED_DIR=${ARCHIVE_FILE%.*}

	cd source || exit 1

	# Downloading static python binary
	# -c option allows the download to resume
	wget -c $DOWNLOAD_URL
	rm -rf $EXTRACTED_DIR
	tar -zxf $ARCHIVE_FILE

	# Delete folder with previously extracted static python
	rm -rf ../work/python

	# Copy static python to folder 'python'
	mv $EXTRACTED_DIR ../work/python

	cd ..
}

# 1. Get Python
get_python

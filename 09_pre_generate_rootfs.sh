#!/bin/sh

STATIC_PYTHON_SOURCE_URL=https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
STATIC_NCURSES_SOURCE_URL=https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz

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

get_ncurses() {
	DOWNLOAD_URL=$STATIC_NCURSES_SOURCE_URL

	# Grab everything after the last '/' character
	ARCHIVE_FILE=${DOWNLOAD_URL##*/}
	# Strip .gz and then .tar
	EXTRACTED_DIR=${ARCHIVE_FILE%.*}
	EXTRACTED_DIR=${EXTRACTED_DIR%.*}

	cd source || exit 1

	# Downloading static python binary
	# -c option allows the download to resume
	wget -c $DOWNLOAD_URL
	rm -rf $EXTRACTED_DIR
	tar -zxf $ARCHIVE_FILE

	# Delete folder with previously extracted static python
	rm -rf ../work/ncurses

	# Copy static python to folder 'python'
	mv $EXTRACTED_DIR ../work/ncurses

	# Patch a build file
	sed -i "65s/.*/preprocessor=\"\$1 -P -DNCURSES_INTERNALS -I..\/include\"/g" ../work/ncurses/ncurses/base/MKlib_gen.sh

	cd ..
}

# 1. Get ncurses
get_ncurses

# 2. Get Python
get_python

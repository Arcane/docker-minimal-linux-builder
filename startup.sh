#!/bin/bash
./build_minimal_linux_live.sh
mv minimal_linux_live.iso ../output/
isohybrid ../output/minimal_linux_live.iso

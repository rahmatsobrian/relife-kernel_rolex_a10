#!/bin/bash
# Copyright cc 2025 RahmatSobrian

# Setup Color
red='\033[0;31m'
green='\033[0;32m'
white='\033[0m'
yellow='\033[0;33m'
cyan='\033[0;36m'

WORK_DIR=$(pwd)
KERN_IMG="${WORK_DIR}/out/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${WORK_DIR}/out/arch/arm64/boot/Image.gz"

function build_kernel() {
    clear

    echo -e "\n"
    echo -e "$yellow [ building kernel... ] \n$white"
    echo -e "\n"

    rm -rf out

    make -j$(nproc --all) O=out ARCH=arm64 rolex_defconfig
    make -j$(nproc --all) ARCH=arm64 O=out \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                          CROSS_COMPILE_COMPAT=arm-linux-gnueabi-
                          
    if [ -e "$KERN_IMG" ] || [ -e "$KERN_IMG2" ]; then
        echo -e "\n"
        echo -e "$green [ compile kernel sukses! ] \n$white"
        echo -e "\n"
    else
        echo -e "\n"
        echo -e "$red [ compile kernel gagal! ] \n$white"
        echo -e "\n"
    fi
}

build_kernel
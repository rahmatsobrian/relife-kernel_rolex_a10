#!/bin/bash
# Compile script for ReLife Kernel
# Copyright (C) 2025 Rahmat Sobrian.
# Use Ubuntu 24.10 on Termux
# Removed Zipping Kernel
# Removed custom clang, use system clang

clear
SECONDS=0 # builtin bash timer
DEFCONFIG="rolex_defconfig"
kernel="out/arch/arm64/boot/Image.gz"

export CC=clang
export PATH="/usr/lib/llvm-19/bin:$PATH"
export KBUILD_BUILD_USER=RahmatSobrian
export KBUILD_BUILD_HOST=android-build

echo -e "\nCleaning...\n"
	rm -rf out

echo -e "\nStarting compilation...\n"
mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

make -j$(nproc --all) O=out ARCH=arm64 LLVM=1 LLVM_IAS=1 Image.gz

if [ -f "$kernel" ]; then
	echo -e "\nKernel compiled successfully!"
	echo -e "Image, DTB, DTBO: $kernel"
	echo -e "Completed in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s)"
else
	echo -e "\nCompilation failed!"
	exit 1
fi
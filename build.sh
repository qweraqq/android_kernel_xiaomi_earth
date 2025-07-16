#!/bin/bash
export CLANG_TRIPLE=aarch64-linux-gnu
CLANG=~/clang/clang-r536225/bin
PATH=$CLANG:$PATH
export PATH


# Vars
export HEADER_ARCH=$ARCH
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build

DATE_START=$(date +"%s")
echo "-------------------"
echo "Making Kernel:"
echo "-------------------"
echo

rm -rf out

make -j$(nproc --all) O=out ARCH=arm64 LLVM=1 O=out earth_defconfig

make -j$(nproc --all) O=out ARCH=arm64 LLVM=1 LLVM_IAS=1 O=out


echo
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

# kernel="out/arch/arm64/boot/Image"
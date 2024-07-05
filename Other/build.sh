#!/bin/bash

path=/media/vu/hdd/document/LS1043-NXP/bootloader
rcw_path=${path}/rcw/ls1043ardb/RR_FQPP_1455/rcw_1600_sdboot.bin
uboot_bin=${path}/u-boot/u-boot.bin

cd ${path}/rcw/ls1043ardb && make

cd ${path}/u-boot
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make distclean
make ls1043ardb_tfa_defconfig
make

cd ${path}/atf
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make PLAT=ls1043ardb bl2 SPD=opteed BOOT_MODE=sd pbl RCW=${rcw_path}

make PLAT=ls1043ardb fip BL33=${uboot_bin}

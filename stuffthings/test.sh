#!/bin/bash
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh

printf "${LIGHT_YELLOW}Jumping into ${BOLD}./linux${NORMAL}\n"
cd ./linux

printf "${LIGHT_YELLOW}Wait 5-seconds before starting open ${BOLD}menu-config${NORMAL}\n"
printf "${LIGHT_YELLOW}NOTE:${NORMAL} You can config in the ${BOLD}menu-config${NORMAL} to make the kernel for yourself.\n"
sleep 5s
KERNEL=kernel8
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

printf "${LIGHT_YELLOW}Wait 5-seconds before starting ${BOLD}build kernel${NORMAL}\n"
sleep 5s
make -j${CORES} ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs

# printf "${LIGHT_YELLOW}Wait 5-seconds before starting run ${BOLD}modules_install${NORMAL}\n"
# sudo make -j6 modules_install

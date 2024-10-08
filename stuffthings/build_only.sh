#!/bin/bash
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh
cd ./linux
printf "${LIGHT_YELLOW}Wait 5-seconds before starting ${BOLD}build kernel${NORMAL}\n"
sleep 5s
CORES=4;
make -j${CORES}  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs

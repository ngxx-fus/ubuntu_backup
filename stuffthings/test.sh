#!/bin/bash
source ./resources/Cores.sh
source ./resources/Branch.sh
source ./resources/Text_Effects.sh
source ./resources/Support_Functions.sh

printf "${LIGHT_YELLOW}\nTarget informations: ${NORMAL}"
printf "${GRAY}\nCPU:${NORMAL}    Broadcom BCM2711"
printf "${GRAY}\nSDRAM:${NORMAL}  4GB LPDDR4-2400"
printf "${GRAY}\nKernel:${NORMAL} rpi-6.6.y"
#!/bin/bash -e

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
EXTLINUXPATH=${LOCALPATH}/build/extlinux
BOARD=$1

version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }

finish() {
	echo -e "\e[31m MAKE KERNEL IMAGE FAILED.\e[0m"
	exit -1
}
trap finish ERR

if [ $# != 1 ]; then
	BOARD=rk3288-evb
fi

[ ! -d ${OUT} ] && mkdir ${OUT}
[ ! -d ${OUT}/kernel ] && mkdir ${OUT}/kernel

source $LOCALPATH/build/board_configs.sh $BOARD

if [ $? -ne 0 ]; then
	exit
fi

echo -e "\e[36m Building kernel for ${BOARD} board! \e[0m"
echo -e "\e[36m Using ${DEFCONFIG} \e[0m"

cd ${LOCALPATH}/kernel
make ${DEFCONFIG}
cd ${LOCALPATH}

echo -e "\e[36m Kernel build step 1 success! \e[0m"

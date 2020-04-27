#!/bin/bash

export QEMU=$(which qemu-system-arm)
export RPI_KERNEL=./qemu/kernel-qemu-4.19.50-buster
export PTB_FILE=./qemu/versatile-pb-buster.dtb

sudo diskutil unmountDisk /dev/disk2
sudo $QEMU -kernel ${RPI_KERNEL} \
    -cpu arm1176 -M versatilepb \
    -dtb ${PTB_FILE} -no-reboot \
    -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
    -drive "file=/dev/disk2,index=0,media=disk,format=raw" \
    -net nic -net user,hostfwd=tcp::22-:22

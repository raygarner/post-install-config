#!/bin/sh
#run as root

pacman -S vi sudo

useradd ray -m
passwd ray
usermod -aG wheel
visudo


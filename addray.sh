#!/bin/sh
#run as root

useradd ray -m
passwd ray
usermod -aG wheel
visudo


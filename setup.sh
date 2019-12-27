#!/bin/sh

#install packages
pacman -S zathura zathura-pdf-mupdf cmus make gvim gnu-free-fonts xorg firefox redshift youtube-dl feh mpv scrot xbindkeys htop sudo vi pavucontrol pulseaudio compton acpi git xorg-init xorg-xsetroot xorg-server dmenu libx11 freetype2 pkg-config transmission-cli base-devel kolourpaint screenfetch

#set keyboard layout
localectl --no-convert set-x11-keymap gb

#add user
useradd ray
passwd ray
usermod -aG wheel ray

#switch to new user
su ray

#cd to home dir
cd /home/ray

#create dirs
mkdir pics pics/screenshots pics/papes pics/people vids vids/films vids/shows vids/music programming music docs builds

#set up git
git config --global user.email "ray@perfectcast.co.uk"
git config --global user.name "Ray Garner"

#download wallpaper
git clone https://github.com/raygarner/wallpaper.git /home/ray/pics/papes

#download dotfiles
git clone https://github.com/raygarner/dotfiles.git .

#download and build dwm
git clone https://github.com/raygarner/rays_dwm.git
cd rays_dwm
make
sudo make install
cd ..

#download and build st
git clone https://github.com/raygarner/rays_st.git
cd rays_st
make
sudo make install
cd ..

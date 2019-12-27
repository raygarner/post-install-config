#!/bin/sh

#install packages
echo "Installing packages..."
pacman -S zathura zathura-pdf-mupdf cmus make gvim gnu-free-fonts xorg firefox redshift youtube-dl feh mpv scrot xbindkeys htop sudo vi pavucontrol pulseaudio compton acpi git xorg-init xorg-xsetroot xorg-server dmenu libx11 freetype2 pkg-config transmission-cli base-devel kolourpaint neofetch xclip

#set keyboard layout
echo "Setting keyboard layout to gb..."
localectl --no-convert set-x11-keymap gb

#add user
echo "Adding user..."
useradd ray
passwd ray
usermod -aG wheel ray

#switch to new user
echo "Switching to new user..."
su ray

#cd to home dir
echo "Moving to new user home dir..."
cd /home/ray

#create dirs
echo "Creating dirs in new user home..."
mkdir pics pics/screenshots pics/papes pics/people vids vids/films vids/shows vids/music programming music docs builds

#set up git
echo "Adding git account details..."
git config --global user.email "ray@perfectcast.co.uk"
git config --global user.name "Ray Garner"

#download wallpaper
echo "Downloading wallpaper..."
git clone https://github.com/raygarner/wallpaper.git /home/ray/pics/papes

#download dotfiles
echo "Downloading dotfiles..."
git clone https://github.com/raygarner/dotfiles.git .

#download and build dwm
echo "Downloading dwm..."
cd builds
git clone https://github.com/raygarner/rays_dwm.git
echo "Building dwm..."
cd rays_dwm
make
sudo make install
cd /home/ray/builds

#download and build st
echo "Downloading st..."
git clone https://github.com/raygarner/rays_st.git
echo "Building st..."
cd rays_st
make
sudo make install
cd /home/ray

echo "End of script."

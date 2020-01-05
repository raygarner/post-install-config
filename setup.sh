#bin/sh

#requirements: 
#user created with sudo privs and script be in their home
#internet connection
#graphics drivers

#pactstrap note:
#pacstrap /mnt base linux linux-firmware vim netctl dialog wpa_supplicant man-db man-pages texinfo


#install packages
echo "Installing packages..."
sudo pacman -S zathura zathura-pdf-mupdf make gvim gnu-free-fonts xorg xorg-xinit firefox redshift youtube-dl feh mpv scrot xbindkeys htop sudo vi pulseaudio compton acpi git xorg-xsetroot xorg-server dmenu libx11 freetype2 pkg-config transmission-cli base-devel neofetch xclip openssh unzip thunderbird perl-rename pulsemixer gdb ghc musescore gimp unnrar pro-audio texlive-most texlive-lang


#set keyboard layout
echo "Setting keyboard layout to gb..."
sudo localectl --no-convert set-x11-keymap gb

#cd to home dir
echo "Moving to /home/ray"
cd /home/ray

#create dirs
echo "Creating dirs in new user home..."
mkdir pics pics/screenshots pics/papes pics/people vids vids/films vids/shows vids/music scripts music docs builds Downloads

#set up git
echo "Adding git account details..."
git config --global user.email "ray@perfectcast.co.uk"
git config --global user.name "Ray Garner"
echo "Generating ssh key..."
ssh-keygen -t rsa -b 4096 -C "ray@perfectcast.co.uk"
eval "$(ssh-agent -s)"
echo "Adding ssh key to agent..."
cd /home/ray/.ssh
ssh-add id_rsa
echo "Generating copy key script..."
echo "#!/bin/sh" > copy.sh
echo "xclip -sel clip < id_rsa.pub" >> copy.sh
chmod +x copy.sh
cd /home/ray

#download wallpaper
echo "Downloading wallpaper..."
git clone https://github.com/raygarner/wallpaper.git /home/ray/pics/papes/ 

#download dotfiles
echo "Downloading dotfiles..."
git clone https://github.com/raygarner/dotfiles.git dotfiles

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
cd /home/ray/builds

#download and build slock
echo "Downloading slock..."
git clone https://github.com/raygarner/rays_slock.git
echo "Building slock..."
cd rays_slock
make
sudo make install
cd /home/ray/builds

#download and build farbfeld
echo "Downloading farbeld..."
git clone https://git.suckless.org/farbfeld
echo "Building farbfeld..."
cd farbfeld
make
sudo make install
cd /home/ray/builds

#download and build sent
echo "Downloading sent..."
git clone https://github.com/raygarner/rays_sent.git 
echo "Building sent..."
cd rays_sent
make
sudo make install
cd /home/ray


echo "End of script."
echo "Move dotfiles to home if you want them to take effect."
echo "You should now reboot."

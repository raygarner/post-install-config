#!bin/sh

#requirements:
#user created with sudo privs and script be in their home
#internet connection
#GRAPHICS DRIVERS

#pactstrap note:
#pacstrap /mnt base linux linux-firmware vim netctl dialog wpa_supplicant man-db man-pages texinfo


#install packages
echo "Installing packages..."
sudo pacman -S zathura zathura-pdf-mupdf make gvim gnu-free-fonts xorg xorg-xinit redshift youtube-dl mpv scrot xbindkeys htop sudo vi pulseaudio compton acpi git xorg-xsetroot xorg-server dmenu libx11 freetype2 pkg-config transmission-cli base-devel neofetch xclip openssh unzip thunderbird perl-rename pulsemixer gdb ghc ghc-static cabal-install stack haskell-haddock-library alex happy musescore gimp unnrar pro-audio texlive-most texlive-lang discord octave pandoc dosfstools nano alsa-utils bluez bluez-utils pulseaudio-bluetooth pulseaudio-alsa pass zip cups gutenprint sxiv xorg-xrandr eclipse numlockx calcurse


#set keyboard layout
echo "Setting keyboard layout to gb..."
sudo localectl --no-convert set-x11-keymap gb

#cd to home dir
echo "Moving to /home/ray"
cd /home/ray

#create dirs
echo "Creating dirs in new user home..."
mkdir pics pics/screenshots pics/papes pics/people vids vids/films vids/shows vids/music vids/screencasts music Documents builds Downloads .config/nvim

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

#set up pass
gpg --full-generate-key
KEY="$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | sed 's/rsa2048\///g')"
pass init "$KEY"

#download wallpaper
echo "Downloading wallpaper..."
git clone https://github.com/raygarner/wallpaper.git /home/ray/pics/papes/

#download dotfiles
echo "Downloading dotfiles..."
git clone https://github.com/raygarner/dotfiles.git dotfiles

#link dotfiles to home
echo "Linking dotfiles and scripts..."
ln .bashrc /home/ray/.bashrc
ln .bash_profile /home/ray/.bash_profile
ln .vimrc /home/ray/.vimrc
ln .xbindkeysrc /home/ray/.xbindkeysrc
ln .xinitrc /home/ray/.xinitrc
#ln record.sh /home/ray/vids/screencasts/record.sh
#ln dl_playlist.sh /home/ray/music/dl_playlist.sh
#ln split_album.sh /home/ray/music/split_album.sh
cd /home/ray

#making scripts executable
#echo "Making scripts executable..."
#chmod +x /home/ray/music/split_album.sh /home/ray/music/dl_playlist.sh /home/ray/vids/screencasts/record.sh

#download scripts
echo "Downloading scripts..."
git clone https://github.com/raygarner/scripts.git
chmod +x scripts/*

#add scripts dir to path
echo "Adding scripts dir to path..."
export PATH=$PATH:/home/ray/scripts

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
cd /home/ray/builds

#download and build yay
echo "Downloading yay..."
git clone https://aur.archlinux.org/yay.git
echo "Building yay..."
cd yay
makepkg -si
cd /home/ray/builds

#download and build scid
#echo "Downloading scid..."
#git clone https://aur.archlinux.org/scid.git
#echo "Building scid..."
#cd scid
#makepkg -si
#cd /home/ray/builds
echo "Installing scid..."
yay -S scid

#download and builds stockfish
#echo "Downloading stockfish..."
#git clone https://aur.archlinux.org/stockfish.git
#echo "Building stockfish..."
#cd stockfish
#makepkg -si
#cd /home/ray
echo "Installing stockfish..."
yay -S stockfish

#download and build brave
#echo "Downloading brave..."
#git clone https://aur.archlinux.org/brave-bin.git
#echo "Building brave..."
#cd brave-bin
#makepkg -si
#cd /home/ray/builds
echo "Installing brave..."
yay -S brave-bin

#download vim colour scheme
echo "Downloading vim colour scheme..."
yay -S gruvbox-material-git

#install mons
echo "Installing mons..."
yay -S mons

#install xwallpaper
echo "Installing xwallpaper..."
yay -S xwallpaper

#download and build citrix
echo "Downloading icaclient..."
git clone https://aur.archlinux.org/icaclient.git
echo "Building icaclient..."
cd icaclient
makepkg -si
cd /home/ray/builds
echo "Adding SSL support to icaclient..."
sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts/
echo "Creating /bin shortcut for icaclient..."
cd /bin
sudo echo "#!/bin/sh" >> icaclient
sudo echo "/opt/Citrix/ICAClient/selfservice" >> icaclient
sudo chmod +x icaclient
cd /home/ray/builds

#download and build vmware-horizon
echo "Downloading vmware-keymaps..."
git clone https://aur.archlinux.org/vmware-keymaps.git
echo "Building vmware-keymaps..."
cd vmware-keymaps
makepkg -si
cd /home/ray/builds
echo "Downloading vmware-horizon-client..."
git clone https://aur.archlinux.org/vmware-horizon-client.git
echo "Building vmware-horizon-client..."
cd vmware-horizon-client
makepkg -si
cd /home/ray


#start and enable dhcpcd
echo "Starting dhcpcd module..."
sudo systemctl enable dhcpcd.service
echo "Enabling dhcpcd module..."
sudo systemctl start dhcpcd.service

#start and enable bluetooth service
echo "Enabling bluetooth.service..."
sudo systemctl enable bluetooth.service
echo "Starting bluetooth.service..."
sudo systemctl start bluetooth.service

#start and enable cups
echo "Enabling cups service..."
sudo systemctl enable org.cups.cupsd.service
echo "Starting cups service..."
sudo systemctl start org.cups.cupsd.service


#bluetooth conf stuff
echo "Configuring pulseaudio for bluetooth compatability..."
sudo echo "" >> /etc/pulse/system.pa
echo "load-module module-bluetooth-policy" >> /etc/pulse/system.pa
echo "load-module module-bluetooth-discover" >> /etc/pulse/system.pa

#set jdk as env for java
#sudo archlinux-java set java-11-openjdk

#add real name for ray
sudo chfn -f "Ray Garner" ray

echo "End of script."
echo "You should now reboot."

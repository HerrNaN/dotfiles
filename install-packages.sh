#!/usr/bin/env sh

# =====================================
# This script is written for keeping track of which packages I use on
# my system and is expecting you to run an Arch-based distro
# =====================================

# We only want the needed commands to be run with priviliges
if [ $USER = "root" ]; then
    echo "Don't run this script as root! When permission are needed you'll be prompted"
    exit 1
fi

if [ -z $(which pacman) ]; then
    echo "Error: pacman not found"
    echo "exiting..."
    exit 1
fi

# =====================================
# Symlink the package lists and config
# =====================================

echo "> Linking files"

if [ -e /etc/pkglist.txt ]; then
    echo "> Linking files > Backing up /etc/pkglist.txt"
    sudo mv /etc/pkglist.txt /etc/pkglist.txt.backup
fi
echo "> Linking files > Linking /etc/pkglist.txt"
sudo ln -s $(pwd)/pkglist.txt /etc/pkglist.txt

if [ -e /etc/foreignpkglist.txt ]; then
    echo "> Linking files > Backing up /etc/foreignpkglist.txt"
    sudo mv /etc/foreignpkglist.txt /etc/foreignpkglist.txt.backup
fi
echo "> Linking files > Linking /etc/foreignpkglist.txt"
sudo ln -s $(pwd)/foreignpkglist.txt /etc/foreignpkglist.txt

if [ -e /etc/pacman.conf ]; then
    echo "> Linking files > Backing up /etc/pacman.conf"
    sudo mv /etc/pacman.conf /etc/pacman.conf.backup
fi
echo "> Linking files > Linking /etc/pacman.conf"
sudo ln -s $(pwd)/pacman.conf /etc/pacman.conf


# =====================================
# Install the listed packages
# =====================================

echo "> Setting up base system"

echo "> Updating system before installing new packages"
sudo pacman -Syu

echo "> Installing packages"
if [ -e pkglist.txt ]; then
    sudo pacman -S --needed - < /etc/pkglist.txt
else
    echo "no packages to install"
fi

echo "> Installing AUR packages"
if [ -e foreignpkglist.txt ]; then
    if [ -z $(which yay) ]; then
        echo "Error: yay not found"
        echo "exiting..."
        exit 1
    fi

    echo "> Installing AUR packages"
    yay -S --needed - < /etc/foreignpkglist.txt
else
    echo "no AUR packages to install"
fi

echo "> Installation Complete!"

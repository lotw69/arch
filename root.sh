#!/bin/bash

################################################################################
### Arch Linux - Additional CLI Software                                     ###
################################################################################

### Fix the Pacman Keyring                                                   ###
function PACMAN_KEYS() {
  clear
  dialog --infobox "Fixing The Pacman (Repos) Keys." 3 35
  sleep 2
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
  sudo reflector --country US --latest 10 --sort rate --verbose --save /etc/pacman.d/mirrorlist
  sudo pacman -Sy
}

### CLI Programs                                                             ###
function CLI_PROGS() {
    clear
    dialog --infobox "Installing some CLI programs." 3 32
    sleep 2
    sudo pacman -S --noconfirm --needed base-devel nano networkmanager man-db man-pages git btrfs-progs systemd-swap xfsprogs reiserfsprogs jfsutils nilfs-utils terminus-font ntp dialog neofetch git wget rsync htop openssh archlinux-wallpaper glances python-defusedxml python-packaging bashtop packagekit reflector bat mc lynx bwm-ng lsd gtop bpytop duf ncdu
}

### Set Number Of CPUs In MAKEFLAGS                                          ###
function MAKEFLAGS_CPU() {
  clear
  dialog --infobox "Fixing The Makeflags For The Compiler." 3 42
  sleep 3
  numberofcores=$(grep -c ^processor /proc/cpuinfo)
  case $numberofcores in

      16)
          echo "You have " $numberofcores" cores."
          echo "Changing the makeflags for "$numberofcores" cores."
          sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j16"/g' /etc/makepkg.conf
          echo "Changing the compression settings for "$numberofcores" cores."
          sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g' /etc/makepkg.conf
          ;;
      8)
          echo "You have " $numberofcores" cores."
          echo "Changing the makeflags for "$numberofcores" cores."
          sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/g' /etc/makepkg.conf
          echo "Changing the compression settings for "$numberofcores" cores."
          sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 8 -z -)/g' /etc/makepkg.conf
          ;;
      6)
          echo "You have " $numberofcores" cores."
          echo "Changing the makeflags for "$numberofcores" cores."
          sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/g' /etc/makepkg.conf
          echo "Changing the compression settings for "$numberofcores" cores."
          sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 6 -z -)/g' /etc/makepkg.conf
          ;;
      4)
          echo "You have " $numberofcores" cores."
          echo "Changing the makeflags for "$numberofcores" cores."
          sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j4"/g' /etc/makepkg.conf
          echo "Changing the compression settings for "$numberofcores" cores."
          sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 4 -z -)/g' /etc/makepkg.conf
          ;;
      2)
          echo "You have " $numberofcores" cores."
          echo "Changing the makeflags for "$numberofcores" cores."
          sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j2"/g' /etc/makepkg.conf
          echo "Changing the compression settings for "$numberofcores" cores."
          sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 2 -z -)/g' /etc/makepkg.conf
          ;;
      *)
          echo "We do not know how many cores you have."
          echo "Do it manually."
          ;;

  esac
}


### Main Program                                                             ###
sudo pacman -S --noconfirm --needed dialog
PACMAN_KEYS
MAKEFLAGS_CPU
CLI_PROGS

#!/bin/bash

#
# INSTALLATION
#

function installpkg {
	if [[ ! $(pacman -Qe | grep $1) ]]; then
		if [[ $2 == '' ]]; then
			sudo pacman -S $1
		else
			yay -S $1
		fi
	else
		echo "Skipping $1"
	fi
}

function installjail {
	if [[ ! $(pacman -Qe | grep $1) ]]; then
		installpkg devtools

		cd /tmp
		git clone https://aur.archlinux.org/$1.git
		cd $1
		extra-x86_64-build
		# TODO: make this automatic.
		echo 'Please execute «sudo pacman -U [tab]»'
		bash
		cd /tmp
		rm -ri $1
	else
		echo "Skipping $1"
	fi
}

installpkg bspwm				# WM
installpkg sxhkd				# Keyboard
installpkg picom				# Compositor
installpkg nitrogen			# Wallpaper
installjail polybar			# Top bar
installpkg alacritty			# Terminal emulator
installpkg lxappearance		# Customize GTK themes, icons and cursors
installpkg xorg-xsetroot		# Load cursor at bspwm's boot
installpkg rofi				# Program launcher
installpkg numlockx			# Numeric lock at startup
installpkg i3lock-fancy AUR	# Screen lock
installpkg papirus-icon-theme	# Icon theme
installpkg cpcache-git AUR		# Pacman Cache
installpkg ttf-joypixels		# Emoji font
installpkg gnome-clocks		# Alarms
installpkg incron				# Notice when a file changes

if [[ ! $(pacman -Qe | grep polybar) ]]; then
	echo 'Manually install polybar with devtools so no build dependencies get in the way.'
	echo 'TODO: make this automatic.'
fi

#
# DAEMONS
#
sudo systemctl enable cpcache
sudo systemctl enable incrond

#
# SHORT SCRIPTS
#
# TODO

#
# CONFIG
#

# bspwm
mkdir -p ~/.config/bspwm 2> /dev/null
ln -sf $PWD/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc

# sxhkdrc
mkdir ~/.config/sxhkd 2> /dev/null
ln -sf $PWD/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

# alacritty
mkdir ~/.config/alacritty 2> /dev/null
ln -sf $PWD/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# polybar
mkdir ~/.config/polybar 2> /dev/null
ln -sf $PWD/polybar/config $HOME/.config/polybar/config

# rofi
mkdir ~/.config/rofi 2> /dev/null
ln -sf $PWD/rofi/style.rasi $HOME/.config/rofi/style.rasi

# TODO: incron config

echo 'Done! :)'

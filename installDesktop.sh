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
	fi
}

installpkg bspwm		# WM
installpkg sxhkd		# Keyboard
installpkg picom		# Compositor
installpkg nitrogen		# Wallpaper
installpkg alacritty		# Terminal emulator
installpkg lxappearance		# Customize GTK themes, icons and cursors
installpkg xorg-xsetroot	# Load cursor at bspwm's boot
installpkg rofi			# Program launcher
installpkg numlockx		# Numeric lock at startup
installpkg i3lock-fancy AUR	# Screen lock
installpkg papirus-icon-theme	# Icon theme
installpkg ttf-joypixels	# Emoji font

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

echo 'Done! :)'

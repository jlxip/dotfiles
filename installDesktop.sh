#!/bin/bash

#
# INSTALLATION
#

function installjail {
	echo "Installing $1 with build jail"
	installpkg devtools

	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	if [[ $? -ne 0 ]]; then
		echo 'Package does not exist.'
		exit -1
	fi

	cd $1
	extra-x86_64-build
	echo -e '\n\nBuilt. Installing. Will require sudo.'
	sudo pacman -U *.zst
	cd /tmp
	rm -rf $1
}

function installpkg {
	if [[ ! $(pacman -Qe | grep $1) ]]; then
		if [[ $2 == '' ]]; then
			echo "Installing $1"
			sudo pacman -S $1
		elif [[ $2 == 'AUR' ]]; then
			echo "Installing $1 from AUR"
			yay -S $1
		elif [[ $2 == 'AUR-jail' ]]; then
			installjail $1
		else
			echo "What is that? $2"
		fi
	fi
}

function enableservice {
	systemctl is-active --quiet $1
	if [ $? -ne 0 ]; then
		echo "Starting and enabling service $1. Will require sudo."
		sudo systemctl start $1
		sudo systemctl enable $1
	fi
}

# $1 → source
# $2 → destination
SCRIPTPATH=$(dirname $0)
function linkconfig {
	if [ ! -h $2 ]; then
		echo "Linking $2..."

		echo $@ | grep '\-\-no\-mkdir' &> /dev/null
		if [ $? -ne 0 ]; then
			mkdir -p $(basename $2)
		fi

		echo $@ | grep '\-\-sudo' &> /dev/null
		if [ $? -eq 0 ]; then
			sudo ln -sf "$SCRIPTPATH/$1" "$2"
		else
			ln -sf "$SCRIPTPATH/$1" "$2"
		fi
	fi
}

if [[ $1 == 'jail' ]]; then
	installjail $2
	exit 0
fi

installpkg bspwm				# WM
installpkg sxhkd				# Keyboard
installpkg picom				# Compositor
installpkg nitrogen			# Wallpaper
installpkg polybar AUR-jail	# Top bar
installpkg alacritty			# Terminal emulator
installpkg lxappearance		# Customize GTK themes, icons and cursors
installpkg xorg-xsetroot		# Load cursor at bspwm's boot
installpkg rofi				# Program launcher
installpkg numlockx			# Numeric lock at startup
installpkg i3lock-fancy AUR	# Screen lock
installpkg papirus-icon-theme	# Icon theme
installpkg flexo-git AUR		# Pacman Cache
installpkg ttf-joypixels		# Emoji font
installpkg gnome-clocks		# Alarms
installpkg incron				# Notice when a file changes
installpkg wmname				# For fixing Java applications (launched by bspwm config)
installpkg syncthing			# Synchronize devices
#installpkg plymouth-theme-green-blocks-git AUR

#
# SHORT SCRIPTS
#
linkconfig 'scripts' "$HOME/scripts"

#
# CONFIG
#

linkconfig 'bspwm/bspwmrc' "$HOME/.config/bspwm/bspwmrc"
linkconfig 'sxhkd/sxhkdrc' "$HOME/.config/sxhkd/sxhkdrc"
linkconfig 'alacritty/alacritty.yml' "$HOME/.config/alacritty/alacritty.yml"
linkconfig 'polybar/config' "$HOME/.config/polybar/config"
linkconfig 'rofi/style.rasi' "$HOME/.config/rofi/style.rasi"
linkconfig 'flexo/flexo.toml' '/etc/flexo/flexo.toml' --no-mkdir --sudo
# TODO: incron config

#
# DAEMONS
#
enableservice flexo
enableservice incrond

echo ':)'

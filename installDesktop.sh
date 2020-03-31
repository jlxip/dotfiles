#!/bin/bash

#
# INSTALLATION
#

if [[ ! $(pacman -Qe | grep bspwm) ]]; then sudo pacman -S bspwm; fi
if [[ ! $(pacman -Qe | grep sxhkd) ]]; then sudo pacman -S sxhkd; fi
if [[ ! $(pacman -Qe | grep picom) ]]; then sudo pacman -S picom; fi
if [[ ! $(pacman -Qe | grep nitrogen) ]]; then sudo pacman -S nitrogen; fi
if [[ ! $(pacman -Qe | grep alacritty) ]]; then sudo pacman -S alacritty; fi
if [[ ! $(pacman -Qe | grep lxappearance) ]]; then sudo pacman -S lxappearance; fi
if [[ ! $(pacman -Qe | grep xorg-xsetroot) ]]; then sudo pacman -S xorg-xsetroot; fi
if [[ ! $(pacman -Qe | grep rofi) ]]; then sudo pacman -S rofi; fi
if [[ ! $(pacman -Qe | grep numlockx) ]]; then sudo pacman -S numlockx; fi
if [[ ! $(pacman -Qe | grep i3lock-fancy) ]]; then yay -S i3lock-fancy; fi
if [[ ! $(pacman -Qe | grep papirus-icon-theme) ]]; then sudo pacman -S papirus-icon-theme; fi

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

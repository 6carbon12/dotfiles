#!/bin/bash

user="kiran"
pacman -Qqen > /home/$user/.dotfiles/pkglist-native.txt
pacman -Qqem | grep -vE '^yay(-debug)?$' > /home/$user/.dotfiles/pkglist-foreign.txt

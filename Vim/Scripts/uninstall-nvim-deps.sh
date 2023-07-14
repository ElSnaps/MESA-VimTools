#!/bin/bash

# Remove neovim
sudo apt purge neovim -y
sudo rm /bin/nvim

# Remove nodejs
sudo apt-get purge nodejs -y &&\
sudo rm -r /etc/apt/sources.list.d/nodesource.list

# Remove ripgrep
sudo apt purge ripgrep -y

# Remove neovim config
sudo rm -rf ~/.config/nvim

# Remove conquer of completion
sudo rm -rf ~/.config/coc


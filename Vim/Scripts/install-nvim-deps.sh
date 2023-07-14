#!/bin/bash

# Update package list
sudo apt-get update

# Install curl.
sudo apt install curl -y

# Install neovim (check if package manager supports min version)
wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
cp nvim-linux64/bin/nvim /bin/
rm -rf nvim-linux64*

# Install neovim plug.
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install nodejs dependency for coc.
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs

# Install rip-grep dependency for telescope.
sudo apt install ripgrep -y

# Install neovim config
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim

# Install Plugins
nvim +PlugInstall +qall

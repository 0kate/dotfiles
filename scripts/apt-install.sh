#!/usr/bin/env bash

set -eu

# register repositories and update cache

## fish
sudo apt-add-repository ppa:fish-shell/release-3

## cloudflare warp
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

## brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

# fcitx5
sudo apt install -y fcitx5 fcitx5-mozc

# wezterm
curl -LO https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/wezterm-20230408-112425-69ae8472.Ubuntu20.04.deb
sudo apt install -y ./wezterm-20230408-112425-69ae8472.Ubuntu20.04.deb

# nerd-fonts
git clone https://github.com/ryanoasis/nerd-fonts --depth 1 --branch master /tmp/nerd-fonts
cd /tmp/nerd-fonts && ./install.sh Hack

# fish & fisher
sudo apt install fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.1
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest && asdf global golang latest
asdf plugin-add direnv
asdf direnv setup --shell fish --version latest

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable

# sxhkd
sudo apt install -y sxhkd

# tdrop
sudo apt install -y gawk
git clone https://github.com/noctuid/tdrop.git /tmp/tdrop
cd /tmp/tdrop && sudo make install

# cloudflare warp
sudo apt -y install cloudflare-warp
warp-cli register

# brave browser
sudo apt install brave-browser

# gnome-shell-extension-kimpanel
git clone https://github.com/wengxt/gnome-shell-extension-kimpanel /tmp/gnome-shell-extension-kimpanel
cd /tmp/gnome-shell-extension-kimpanel && ./install.sh

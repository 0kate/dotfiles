#!/usr/bin/env bash

set -eu

# clone neovim repository
git clone https://github.com/neovim/neovim --depth 1 --branch master

# prepare dependencies
sudo apt install clang ninja-build gettext cmake unzip curl
cargo install tree-sitter-cli
go install github.com/jesseduffield/lazygit@latest
asdf reshim golang

# build and install
make CMAKE_BUILD_TYPE=Release && sudo make install

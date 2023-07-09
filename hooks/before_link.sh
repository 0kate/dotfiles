#!/usr/bin/env bash

set -eu

echo 'Prepare dependencies...'
source ../scripts/apt-install.sh
source ../scripts/build-neovim.sh
echo 'Done.'

echo 'Start linking my dotfiles...'

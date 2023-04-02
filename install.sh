#!/usr/bin/env bash

DOTFILES_DIR=$PWD
TARGET_DIR=$HOME

DEFAULT_DOTFILES_IGNORE=".git|.dotfilesignore|install.sh"
DOTFILES_IGNORE="${DEFAULT_DOTFILES_IGNORE}|$(cat .dotfilesignore | tr '\n' '|')"

set -eux

dotfiles() {
    ls -A $DOTFILES_DIR | grep -v -E $DEFAULT_DOTFILES_IGNORE | xargs -I {} sh -c 'find {} -type f'
}

linkdotfiles() {
    __str=$(cat -)

    for dotfile in $__str; do
        local src_path=$DOTFILES_DIR/$dotfile
        local dst_path=$TARGET_DIR/$dotfile

        if [ ! -f $dst_path ]; then
            mkdir -p $(dirname $dst_path) && ln -s $src_path $dst_path
        fi
    done
}

echo 'Start linking my dotfiles...'
dotfiles | linkdotfiles
echo 'Finish!'

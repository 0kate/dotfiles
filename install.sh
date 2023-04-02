#!/usr/bin/env bash

DOTFILES_DIR=$PWD
TARGET_DIR=$HOME
HOOKS_DIR=$DOTFILES_DIR/hooks

DEFAULT_DOTFILES_IGNORE=".git|.dotfilesignore|hooks|install.sh"
DOTFILES_IGNORE="${DEFAULT_DOTFILES_IGNORE}|$(cat .dotfilesignore | tr '\n' '|')"

set -eu

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

if [ -f $HOOKS_DIR/before_link.sh ]; then source $HOOKS_DIR/before_link.sh; fi
dotfiles | linkdotfiles
if [ -f $HOOKS_DIR/after_link.sh ]; then source $HOOKS_DIR/after_link.sh; fi

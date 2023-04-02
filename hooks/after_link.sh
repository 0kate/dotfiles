#!/usr/bin/env bash

set -eu

# enable Emacs daemon systemd unit
systemctl enable --user emacs

# restore guake preferences from linked file
guake --restore-preferences=$HOME/.config/guake/guake.conf

echo 'Finish!'

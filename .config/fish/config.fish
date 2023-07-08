# local executable
set PATH $HOME/.local/bin $PATH

# asdf
source $HOME/.asdf/asdf.fish

# rustup & cargo
# source $HOME/.cargo/env
set PATH $HOME/.cargo/bin $PATH

# GPG
set GPG_TTY $(tty)

# direnv
eval (direnv hook fish)

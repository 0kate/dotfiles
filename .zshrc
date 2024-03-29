# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/keito-osaki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# local executable
export PATH=$PATH:$HOME/.local/bin

# asdf
source $HOME/.asdf/asdf.sh

# rustup & cargo
# source $HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

# direnv
eval "$(direnv hook zsh)"

# sheldon
eval "$(sheldon source)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# sheldon plugins
source $HOME/.local/share/sheldon/repos/github.com/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.local/share/sheldon/repos/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# completions
fpath=($HOME/.zsh/comletion $fpath)

# aws-cli
complete -C '/usr/local/bin/aws_completer' aws

# exa
alias ls='exa --icons'

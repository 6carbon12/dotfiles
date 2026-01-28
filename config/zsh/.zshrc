if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.local/share/zsh/.zshis
HISTSIZE=65536 # 2^16
SAVEHIST=1048576 # 2^20
setopt autocd
setopt extendedglob
setopt append_history
setopt sharehistory
setopt noflowcontrol
unsetopt beep
bindkey -v

# Completion
autoload -Uz compinit
compinit -d "$HOME/.zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

###########
# PLUGINS #
###########

source ~/.local/share/zsh/plugins/p10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

###########
# ALIASES #
###########

# Better apps but muscle memory
alias ls="eza"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Quality of life / most used
alias ...="cd ../.."
alias ....="cd ../../../"
alias v="nvim"

# git
alias gs="git status --short"
alias ga="git add ."
alias gc="git commit"
alias gd="git diff"

#########################
# ENVIRONMENT VARIABLES #
#########################

# Use neovim as manpager in place of less
export MANPAGER='nvim +Man!'

# .local bin
export PATH="$HOME/.local/bin:$PATH"

# TERM to make undercurl work on tmux
export TERM="tmux-256color"

# Cutome HOMEs
export npm_config_cache="~/.local/share/npm"
export GNUPGHOME="~/.local/share/gnupg"

# Set editor
export EDITOR=nvim
export VISUAL=nvim

# ssh agent socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

################
# APP SPECIFIC #
################

# ZOXIDE
eval "$(zoxide init zsh)"
alias cd="z"

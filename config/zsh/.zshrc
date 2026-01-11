if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/.zshis
HISTSIZE=65536 # 2^16
SAVEHIST=1048576 # 2^20
export MANPAGER='nvim +Man!'
export RANGER_LOAD_DEFAULT_RC=false
setopt autocd extendedglob
unsetopt beep
setopt append_history
setopt sharehistory
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/kiran/.zshrc'

autoload -Uz compinit
compinit -d "$HOME/.zsh/zcompdump"
# End of lines added by compinstall

source ~/.local/share/zsh/plugins/p10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
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

################
# APP SPECIFIC #
################

# ZOXIDE
eval "$(zoxide init zsh)"
alias cd="z"

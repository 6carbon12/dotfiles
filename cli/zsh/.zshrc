# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zshis
HISTSIZE=65536 # 2^16
SAVEHIST=1048576 # 2^20
export MANPAGER='nvim +Man!'
export RANGER_LOAD_DEFAULT_RC=false
setopt autocd extendedglob
unsetopt beep
setopt append_history
setopt sharehistory
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kiran/.zshrc'

autoload -Uz compinit
compinit -d "$HOME/.zsh/zcompdump"
# End of lines added by compinstall

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

export TERM=xterm-256color

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

###########
# ALIASES #
###########

# Better apps but muscle memory
alias grep="grep --color=auto"
alias ls="eza"
alias cat="bat"

# Quality of life / most used
alias ...="cd ../.."
alias ....="cd ../../../"

#########################
# ENVIRONMENT VARIABLES #
#########################

export PATH="$HOME/bin:$PATH"

################
# APP SPECIFIC #
################

# ZOXIDE
eval "$(zoxide init zsh)"
alias cd="z"

# shellcheck shell=bash

# To run the install program again type:
#   autoload -Uz zsh-newuser-install
#   zsh-newuser-install -f
# Lines configured by zsh-newuser-install
# shellcheck disable=SC2034
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

bindkey -e
# End of lines configured by zsh-newuser-install

# Enable Zsh completion system
autoload -Uz compinit
compinit

setopt append_history          # append to history file
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
unsetopt hist_beep             # don't beep when attempting to access a missing history entry


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && (eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)")
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sd='shutdown now'

alias gst='git status'
alias gl='git log --oneline --graph'
alias ga='git add .'
alias gp='git push'
alias gd='git diff'

alias nv='nvim .'
alias cs='csharprepl'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias zv="nvim ~/.zshrc"
alias zs="source ~/.zshrc"


# Go setup
export GOPATH="$HOME/go"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

typeset -U path PATH  # remove duplicates
path+=(
  /opt/nvim-linux-x86_64/bin
  /home/simon/.local/bin
  /usr/local/go/bin
  "$GOHOME/bin"
)

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" 
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# Config for Oh My Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/themes/tiramisu.omp.toml)"

eval "$(zoxide init zsh)"
alias cd=z
alias cdi=zi
alias cdh='zoxide query -l -s | less'


export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm "$@"
}


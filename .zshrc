# To run the install program again type:
#   autoload -Uz zsh-newuser-install
#   zsh-newuser-install -f
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -e
# End of lines configured by zsh-newuser-install

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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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

alias gst='git status'
alias gl='git log --oneline --graph'
alias ga='git add .'
alias gp='git push'

alias nv='nvim .'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias zv="nvim ~/.zshrc"
alias zs="source ~/.zshrc"

## TODO This following section did not transfer from bash. 
## shopt is not known to zsh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/sdv/.dotnet"
export PATH="$PATH:/home/sdv/.local/bin"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" 
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Config for Oh My Posh
#eval "$(oh-my-posh init zsh)"
#eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/multiverse-neon.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/themes/tiramisu.omp.toml)"

eval "$(zoxide init zsh)"
alias cd=z
alias cdi=zi
alias cdh='zoxide query -l -s | less'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

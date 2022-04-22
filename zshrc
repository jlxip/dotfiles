export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_host custom_root custom_tor custom_venv dir dir_writable)

POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=015

if [ "$(uname)" = 'Linux' ]; then
    HOSTNAME="$(cat /etc/hostname)"
else
    HOSTNAME="$(hostname)"
fi

if [ "$HOSTNAME" = 'Alpha' ]; then
    POWERLEVEL9K_CUSTOM_HOST='echo α'
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=069
elif [ "$HOSTNAME" = 'stronghold' ]; then
    POWERLEVEL9K_CUSTOM_HOST='echo '
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=1
elif [ "$(hostname)" = 'Beta' ]; then
    # Deprecated
    POWERLEVEL9K_CUSTOM_HOST='echo β'
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=069
elif [ "$HOSTNAME" = 'Gamma' ]; then
    POWERLEVEL9K_CUSTOM_HOST='echo γ'
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=069
else
    # Where am I?
    POWERLEVEL9K_CUSTOM_HOST='echo "?"'
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=1
fi

if [ "$(whoami)" = 'root' ]; then
   POWERLEVEL9K_CUSTOM_ROOT='echo "#"'
   POWERLEVEL9K_CUSTOM_ROOT_BACKGROUND=1
   POWERLEVEL9K_CUSTOM_ROOT_FOREGROUND=015
fi

if [ ! -z "$TORMODE" ]; then
   aux="$(curl https://check.torproject.org/ 2>/dev/null | grep Congratulations | wc -l)"
   if [ ! "$aux" -eq 0 ]; then
       POWERLEVEL9K_CUSTOM_TOR='echo '
       POWERLEVEL9K_CUSTOM_TOR_BACKGROUND=0
       POWERLEVEL9K_CUSTOM_TOR_FOREGROUND=082
   else
       echo 'Dayum'
   fi
fi

if [ ! -z "$VENV" ]; then
    POWERLEVEL9K_CUSTOM_VENV='echo '
    POWERLEVEL9K_CUSTOM_VENV_BACKGROUND=070
    POWERLEVEL9K_CUSTOM_VENV_FOREGROUND=015
fi

POWERLEVEL9K_DIR_HOME_BACKGROUND=75
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=75
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=75
POWERLEVEL9K_DIR_ETC_BACKGROUND=75

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export LC_CTYPE=es_ES.UTF-8
export TERM=xterm-256color

# PATH
export PATH="$HOME/opt/cross/bin:$PATH"
export PATH="$PATH:/opt/go/bin"
export PATH="$PATH:/home/jlxip/.local/bin"
export PATH="$PATH:/home/jlxip/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/scripts"

# Default edito is nano
export EDITOR="nano"

# Fix some Java apps with bspwm (or maybe picom, don't know)
export _JAVA_AWT_WM_NONREPARENTING=1

# Aliases
alias vps="ssh -D8081 sysadmin@stronghold"
alias ffvps="firefox --no-remote &>/dev/null &; disown; exit"
alias m="make run -j8"
alias pm="pulsemixer"
alias jlxip="~/git/dotfiles/installDesktop.sh"
alias t="trash"
alias rm="trash"
alias RM="/usr/bin/rm"
alias e='emacs --no-x-resources -nw'
alias py='python3'
alias juan='john'
alias dssh='/home/jlxip/scripts/sshdocker.sh'
alias raurr='ping -O 192.168.0.1'
alias gotor='TORMODE=1 torsocks --shell'
# This is disgusting
alias mkvenv='mkdir venv && python3 -m venv venv'
alias govenv='VENV=true bash -c "source venv/bin/activate && zsh"'
alias ayo='sudo /home/jlxip/scripts/ayo.sh'
alias kubectl='kubecolor'

# jotaOS
#export JOTAOS_STDLIB_HEADERS=/home/jlxip/git/jotaOS/jotaOS/projects/stdlib
#export jotaOS_stdlib_headers_path=/home/jlxip/git/jotaOS/jotaOS/projects/stdlib/pubheaders

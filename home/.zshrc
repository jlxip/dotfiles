export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
#POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_host custom_root custom_venv dir)

POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=015

if [ "$(uname)" = 'Linux' ]; then
    HOSTNAME="$(cat /etc/hostname)"
else
    HOSTNAME="$(hostname)"
fi

POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=069
case "$HOSTNAME" in
	Alpha)
		POWERLEVEL9K_CUSTOM_HOST='echo a'
	;;
	Beta)
		POWERLEVEL9K_CUSTOM_HOST='echo β'
	;;
	Gamma)
		POWERLEVEL9K_CUSTOM_HOST='echo γ'
	;;
	omega)
		POWERLEVEL9K_CUSTOM_HOST='echo ω'
	;;
	stronghold)
		POWERLEVEL9K_CUSTOM_HOST='echo '
	;;
	rawtext.club)
		POWERLEVEL9K_CUSTOM_HOST='echo 殺'
	;;
	iMac-de-Jose.local)
		POWERLEVEL9K_CUSTOM_HOST='echo λ'
	;;
	*)
		POWERLEVEL9K_CUSTOM_HOST='echo "?${HOSTNAME}?"'
	;;
esac

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

#POWERLEVEL9K_DIR_HOME_BACKGROUND=75
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=75
#POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=75
#POWERLEVEL9K_DIR_ETC_BACKGROUND=75

plugins=(
  git
)

export DISABLE_AUTO_UPDATE=true
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
alias vps="ssh -D8081 -p 23 sysadmin@stronghold"
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
alias mkvenv='mkdir .venv && python3 -m venv .venv'
alias govenv='VENV=true bash -c "source .venv/bin/activate && zsh"'
alias ayo='sudo /home/jlxip/scripts/ayo.sh'
alias updatedocker='sudo docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower -R'
alias fm='make -j9'
alias "youtube-dl"='yt-dlp'
alias callgrind='valgrind --tool=callgrind'
alias todo='find . -type f -exec grep -Hn TODO {} \;'
alias gobuild='docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app golang:latest go build -v'
alias cb='cargo build'
alias cbr='cargo build --release'
alias cr='cargo run'
alias crr='cargo run --release'

# Le Sysadmin
export PATH="$HOME/git/lesysadmin:$PATH"

# This has no business being here, but I never want to miss it again
git config --global commit.gpgsign true



# This must be at the end of the file
# Custom zshrc for this system?
if [ -f "$HOME/zshrc2.sh" ]; then
        source "$HOME/zshrc2.sh"
fi

export HOMEBREW_NO_ENV_HINTS=1

function fawk {
	find . | gawk "$1"
}
function fawksh {
	find . | gawk "$1" | bash -c
}

if [ "$(uname -s)" = "Darwin" ]; then
	alias nproc="sysctl -n hw.physicalcpu"
fi



export WHERE1=~/1/lang/bootstrap
alias 1t="( cd $WHERE1 && DEBUG=1 make && time ./1 test.1 )"
alias 1v="( cd $WHERE1 && DEBUG=1 make && valgrind ./1 test.1 )"
_1r() {
    set -e
    cd $WHERE1
    DEBUG=1 make
    ./1 test.1
    gcc -ansi -Wall -Wextra -Werror -pedantic \
        test.1.c -o gen
    echo
    echo "----------------------------------------"
    ./gen
}
alias 1="( _1r )"

alias vpn="cd /home/jlxip/pub/manual-connections && ./connect.sh"

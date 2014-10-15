#!/usr/bin/bash
#------------------------------------------------------------------#
# File:     alias.sh   Aliases                                     #
# Version:                                                         #
# Author:   Abdó Roig-Maranges <abdo.roig@gmail.com>               #
#------------------------------------------------------------------#


#------------------------------
# Coloring stuff
#------------------------------
alias ls='ls --human-readable --color=auto -F'
alias ll='ls++ --potsf'
alias lt='tree -C'

alias df='pydf'
alias dul='cdu -dLh -i'
alias du='cdu -dh -i'
alias top='htop'

alias diff='diff -u -d'
alias grep='grep --color=auto'

alias gls="abdo_git_ls"


# alias ping='$HOME/Software/conf/color-wrappers/ping'
# alias unisonb='$HOME/Software/conf/color-wrappers/unison -batch'



#------------------------------
# Wine aliases
#------------------------------
alias winec='wineconsole --backend=curses'

alias kindle='wine "$HOME/.wine/drive_c/Program Files (x86)/Amazon/Kindle/Kindle.exe"'
alias digitaleditions='wine "$HOME/.wine/drive_c/Program Files (x86)/Adobe/Adobe Digital Editions/digitaleditions.exe"'


#------------------------------
# Utility aliases
#------------------------------

alias trash='gvfs-trash'
alias vp='vimpager'
alias vc='vimcat'
alias rsy='rsync -avz --progress --delete'
alias ediff='emacs -diff'
alias egit='emacs -git'
alias mr='mr --stats -t'

alias mailq='msmtp-queue'

alias ahi='ictl hi.target'
alias abye='ictl bye.target'

alias pac='sudo pacman'
alias pat='pactree -c'
alias cow='cower'

alias feh='feh --magick-timeout 2 --scale-down --fontpath /usr/share/fonts/TTF/ --font DejaVuSans/10'
alias ipy='ipython'
alias ipy2='ipython2'

alias wee='weechat-curses'

gateway() { host `ip route list 0/0 | awk '{print $3}'` | awk '{print $5}'; }

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


#------------------------------
# Auxiliar functions
#------------------------------

xrandr_screens() { xrandr -q | grep " connected" | sed 's/^\([A-Za-z0-9\-]*\).*/\1/'; }

# remove trailing newline.
trimtrail() {
    cat "$1" | awk '{a = $0; while (getline > 0) {print a; a = $0}} END {printf("%s", a)}' -
}



#------------------------------
# Systemd aliases
#------------------------------

alias jtail="jctl -f -n5"
alias jctl="jctl"
alias ectl="jctl --priority=0..3"

alias nctl="networkctl --no-pager"
alias mctl="sudo machinectl"
alias lctl="sudo loginctl"
alias sctl="sudo systemctl --system"
alias uctl="systemctl --user"

alias actl="systemd-analyze"
alias nspawn="sudo systemd-nspawn"
alias sdrun="systemd-run --user"

alias cgls="sdls cgroups"
alias unls="sdls units"
alias cgtop="systemd-cgtop"

alias cmctl="connmanctl"

alias udctl="udisksctl"
alias mount-data="udisksctl mount -b /dev/disk/by-label/galois:data"
alias umount-data="udisksctl unmount -b /dev/disk/by-label/galois:data"

actl_svg() {
    cmd="$1"; shift
    if [ "$cmd" = "dot" ]; then systemd-analyze dot "$@" | dot -Tsvg
    else                        systemd-analyze "$cmd" "$@"
    fi
}

alias lock='systemctl --user lock.target'

# firewall
fws() { sudo iptables -L firewall; echo ""; sudo iptables -n -L sshguard; }
fwban() { sudo iptables -A sshguard -s "$1" -j DROP; }


#------------------------------
# development
#------------------------------

case $(hostname -s) in
    grothendieck)
        threads=10
        ;;
    galois|hodge)
        threads=3
        ;;
    *)
        threads=1
        ;;
esac

mk() { MAKE="make -j$threads" make "$@" 2>&1 | colormake; return ${PIPESTATUS[0]}; }

alias make="TERM=xterm make"

alias gan="git annex"


#------------------------------
# sudo
#------------------------------

# If the argument has an alias, expand it, if it has a function, 
# run it on a root shell and if no arguments given, go to a root shell.
sudo () {
    sudo=/usr/bin/sudo
    
    if [[ -n "$1" ]]; then
        if [[ -n "${=aliases[$1]}" ]]; then
            $sudo ${=aliases[$1]} $argv[2,-1]
        elif [[ -n "${=functions[$1]}" ]]; then
            # TODO: need to escape $argv
            $sudo zsh -ic "$argv"
        else
            $sudo $argv
        fi
    else
        $sudo zsh
    fi
}

# alias sudo='sudo '        # Enables expanding aliases for next command. not functions though :(


#------------------------------
# Program shortcuts
#------------------------------

vi()  { eval "$EDITOR \"\$@\""; }
op()  { xdg-open "$@" &> /dev/null &!; }


# The following commands are aware of the type of terminal they are on. For
# example ed launches GTK emacs on any terminal except tty's or remote logins

# emacs
ee() {
    case "$TERM" in
        screen*|linux) eval "$EMACSCLIENT -t \"\$@\"" ;;
        *)             eval "$EMACSCLIENT -c \"\$@\" > /dev/null &!" ;;
    esac
}

# kill emacs
kle() {
    case "$TERM" in
        screen*|linux) eval "$EMACSCLIENT -eval \"(client-save-kill-emacs)\" &> /dev/null"  ;;
        *)             eval "$EMACSCLIENT --display=:0 --eval \"(client-save-kill-emacs)\" &> /dev/null \"\$@\" &!" ;;
    esac
}

# open tmux session
tx() {
    if [ "$TMUX" ]; then   tmux new-window
    else                   tmux_session default
    fi
}

# detach from tmux
dt() {
    if [ "$TMUX" ]; then   tmux detach-client
    fi
}

# if inside tmux close window and detach, otherwise just exit
cl() {
    if [ "$TMUX" ]; then   tmux unlink-window -k\; detach-client
    else                   exit 0
    fi
}

# new terminal
tm()  {
    case "$TERM" in
        screen*|linux) tx ;;
        *)             eval "$TERMCMD -d \"\$PWD\" \"\$@\" &!" ;;
    esac
}

# ranger session
rg()  {
    case "$TERM" in
        screen*|linux) eval "ranger \"\$@\"" ;;
        *)             eval "$TERMCMD -d \"\$PWD\" -e ranger \"\$@\" &!" ;;
    esac
}

# open file manager
fm()  {
    case "$TERM" in
        screen*|linux) eval "ranger \"\$@\"" ;;
        *)             eval "$FILEMANAGER \"\$@\" &> /dev/null &!" ;;
    esac
}



# These commands open awesome dropdown clients
rgd() { echo "ddclient.ranger:newtab('$PWD')"   | awesome-client; }
tmd() { echo "ddclient.terminal:newtab('$PWD')" | awesome-client; }


#------------------------------
# Starting and killing X
#------------------------------

# stx() { startx awesome -- vt$(fgconsole 2>/dev/null); }
stx() {
    
    # set the vt number from current vt
    systemctl --user set-environment "XDG_VTNR=$XDG_VTNR"

    # start the desktop according to the device
    chassis=$(hostnamectl status | awk '/Chassis/{print $2}')
    case $chassis in
        tablet)  systemctl --user start tablet.target ;;
        laptop)  systemctl --user start laptop.target ;;
        desktop) systemctl --user start desktop.target ;;
        *)       systemctl --user start desktop.target ;;
    esac

    # wait until X server finishes and reset the tty
    wait $(pgrep xorg)
    sleep 1
    reset
    set_tty_colors
}

klx() { 
    systemctl --user start console.target;
}


#------------------------------
# Rebooting and halting
#------------------------------

alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias suspend="sudo systemctl suspend"


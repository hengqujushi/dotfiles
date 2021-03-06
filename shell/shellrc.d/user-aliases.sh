#------------------------------
# Machine aliases
#------------------------------

alias vms='vmctl start'
alias vmt='vmctl start-tty'
alias vmv='vmctl start-vnc'
alias vmh='vmctl start-ssh'
alias vmk='vmctl stop'
alias vmm='vmctl mount'
alias vmu='vmctl umount'

alias nspawn='systemd-nspawn -b -n -D'


#------------------------------
# System
#------------------------------

alias cgls="sdls cgroups"
alias unls="sdls units"

# other system tools
alias cmctl="connmanctl"
alias udctl="udisksctl"

# trash alias and disable rm
alias trash='gvfs-trash'
alias rm='printf >&2 "\e[31mError\e[0m: rm disabled for interactive use.\nUse trash instead.\n"; false'


#------------------------------
# Auxiliar functions
#------------------------------

xrandr_screens() { xrandr -q | grep " connected" | sed 's/^\([A-Za-z0-9\-]*\).*/\1/'; }

# remove trailing newline.
trimtrail() {
    cat "$1" | awk '{a = $0; while (getline > 0) {print a; a = $0}} END {printf("%s", a)}' -
}



#------------------------------
# Wine aliases
#------------------------------
alias winec='wineconsole --backend=curses'

alias kindle='wine "$HOME/.wine/drive_c/Program Files (x86)/Amazon/Kindle/Kindle.exe"'
alias digitaleditions='wine "$HOME/.wine/drive_c/Program Files (x86)/Adobe/Adobe Digital Editions/digitaleditions.exe"'


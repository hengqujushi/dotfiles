#------------------------------
# Program shortcuts
#------------------------------

# NOTE1: &! detaches and disowns process. The shell no longer keeps track of it.

# NOTE2: rifle always expects arguments

# NOTE3: rifle either completely detaches or runs a terminal program in-place.

# NOTE4: The following commands are aware of the type of terminal they are on. For
# example fm launches GTK file manager on any terminal except tty's or remote logins


# file openers
op() {
    xdg-open "$@" &> /dev/null &!
}

rf()  {
    rifle "$@"
}

# terminal editor
vi()  {
    eval "local CMD=($EDITOR)"
    ${CMD[@]} "$@";
}

# emacs
ee()  {
    eval "local CMD=($EMACS)"
    if [ "$1" ]; then sdrun ${CMD[@]} "$@"
    else              sdrun ${CMD[@]} "$PWD"
    fi
}

# emacs project
ep() {
    eval "local CMD=($EMACS)"
    if [ "$1" ]; then sdrun ${CMD[@]} -e "(ab2/find-file-in-project \"$1\")"
    else              sdrun ${CMD[@]} -e "(ab2/find-file-in-project \"$PWD\")"
    fi
}

# open magit
mg() {
    eval "local CMD=($EMACS)"
    if [ "$1" ]; then sdrun ${CMD[@]} -e "(abdo-vcs-main \"$1\")"
    else              sdrun ${CMD[@]} -e "(abdo-vcs-main \"$PWD\")"
    fi
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
    eval "local CMD=($TERMCMD)"
    if [ "$1" ]; then sdrun ${CMD[@]} -d "$1"
    else              sdrun ${CMD[@]} -d "$PWD"
    fi
}

# ranger session
rg()  {
    eval "local CMD=($TERMCMD)"
    if [ "$1" ]; then sdrun ${CMD[@]} -e ranger -d "$1"
    else              sdrun ${CMD[@]} -e ranger -d "$PWD"
    fi
}

# vifm as an awesome dropdown
fm() {
    echo "ddshow('app:vifm-dropdown', true)" | awesome-client
    if [ "$1" ]; then local dir=$(realpath "$1")
    else              local dir=$(realpath "$PWD")
    fi
    # TODO: remove this once vifm is socket-activated
    sleep 0.5
    vifm --remote -c "cd '$dir'"
}


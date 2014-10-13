#!/bin/zsh
#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file for interactive shells      #
# Version:                                                         #
# Author:   Abdó Roig-Maranges <abdo.roig@gmail.com>               #
#------------------------------------------------------------------#


# Arch prompt, just in case
PROMPT='[%n@%m %1~] $ '



# ----------------------------
# In case of tramp login
# ----------------------------

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$ '
    return
fi


# ----------------------------
# Tty stuff
# ----------------------------

# Disable ^S ^Q to stop start the output
stty stop undef
stty start undef


# ----------------------------
# Modifying fpath
# ----------------------------
fpath=($HOME/.zsh/completions $fpath)



# ----------------------------
# Loading generic stuff
# ----------------------------

# Stop here if unknown terminal
case $TERM in
    rxvt*|screen*|xterm*|linux*|eterm-color) ;;    
    *) return                                ;;
esac

autoload -U add-zsh-hook



# ----------------------------
# Set environment
# ----------------------------

# source environment variables
[[ -f $HOME/.zshenv ]] && . $HOME/.zshenv

# source aliases
[[ -f $HOME/.aliases ]] && . $HOME/.aliases

# source files in ~/.zsh
_ZSH_DIR="$HOME/.zsh"
if [ -d $_ZSH_DIR ]; then
    # NOTE: We put the find at the end because otherwise the while is
    # run in a sub-shell...
    while read src; do
        # we admit symlinks, but only source them if thay are not broken
        src_path=$(readlink -f $src)
        [ -f "$src_path" ] && source "$src_path"
    done < <(find "$_ZSH_DIR/" -maxdepth 1 -regex '^.*\.zsh$' | sort)
fi



# ----------------------------
# Hooks
# ----------------------------

# catch the return value before setting any prompt.
save_return_value() { ANS=$?; };
add-zsh-hook precmd save_return_value        

add-zsh-hook chpwd update_current_vcs_vars     # update vcs info
add-zsh-hook precmd refresh_current_vcs_vars

add-zsh-hook precmd set-window-title           # set window title
# add-zsh-hook preexec set-window-title



# ----------------------------
# Prompt
# ----------------------------

setopt prompt_subst
PROMPT='$(abdo_prompt_main)'
PROMPT2='$(abdo_prompt_cont)'



# ----------------------------
# Startup actions
# ----------------------------

# welcome message for tmux sessions
abdo_prompt_messagehello                  

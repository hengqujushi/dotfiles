#------------------------------------------------------------------#
# File:     prompt.sh   Prompt                                     #
# Version:                                                         #
# Author:   Abdó Roig-Maranges <abdo.roig@gmail.com>               #
#------------------------------------------------------------------#

function detect_current_vcs() {
    local isgit="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    if [[ -n "$isgit" ]]; then
	__CURRENT_VCS_PROGRAM="git"
	return
    fi

    local ishg="$(hg status &> /dev/null; echo "$?")"
    if [[ "$ishg" == "0" ]]; then
	__CURRENT_VCS_PROGRAM="hg"
	return
    fi

    __CURRENT_VCS_PROGRAM="none"
}


function refresh_current_vcs_vars() {
    unset __CURRENT_VCS_REV
    unset __CURRENT_VCS_BRANCH
    unset __CURRENT_VCS_STATUS
    unset __CURRENT_VCS_TIMELINE

    # If empty means we have never detected
    if [[ "$__CURRENT_VCS_PROGRAM" == "" ]]; then detect_current_vcs; fi

    case $__CURRENT_VCS_PROGRAM in
	git) source $ZSHRCD/vcs/git.sh ;;
         hg) source $ZSHRCD/vcs/hg.sh  ;;
    esac
}

# Detects vcs and sets all variables
function update_current_vcs_vars() {
    unset __CURRENT_VCS_PROGRAM
    detect_current_vcs
    refresh_current_vcs_vars
}

add-zsh-hook chpwd update_current_vcs_vars
add-zsh-hook precmd refresh_current_vcs_vars

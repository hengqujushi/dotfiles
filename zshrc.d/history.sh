#------------------------------------------------------------------#
# File:     history.sh   History stuff                             #
# Version:                                                         #
# Author:   Abdó Roig-Maranges <abdo.roig@gmail.com>               #
#------------------------------------------------------------------#

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

setopt incappendhistory 
setopt sharehistory
setopt extendedhistory
---------------------------------------------------------------
-- File:    apps.lua             Apps to use                 --
-- Version:                                                  --
-- Author:  Abdó Roig<abdo.roig@gmail.com>                   --
---------------------------------------------------------------

local os = os

local apps = {}

-- Apps from the environment
apps.terminal            = os.getenv("TERMCMD")
apps.editor              = os.getenv("EMACS")
apps.browser             = os.getenv("BROWSER")

-- Other apps
apps.docbrowser          = "midori --private"
apps.filemanager         = "nautilus"
apps.pdfviewer           = "zathura"
apps.music               = "quodlibet"
apps.chat                = "pidgin"

-- Emacs stuff
apps.orgmode             = "emacs -org"
apps.mail                = "emacs -mail"
apps.news                = "emacs -news"
apps.notes               = "emacs -notes"
apps.irc                 = "emacs -irc"

return apps

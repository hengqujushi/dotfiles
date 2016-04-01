apps = require("apps")

return {
  -- top dropdown
   ["termite-dropdown"]      = "termite-dropdown.service",
   ["thunar-dropdown"]       = "thunar-dropdown.service",
   ["ranger-dropdown"]       = "ranger-dropdown.service",
   ["journal-dropdown"]      = "journal-dropdown.service",

   -- systemd units
   dwb                       = "dwb@.service",
   chromium                  = "chromium@.service",
   firefox                   = "firefox@.service",
   thunar                    = "thunar@.service",
   termite                   = "termite@.service",
   ranger                    = "ranger@.service",
   emacsclient               = "emacsclient@.service",
   cantata                   = "cantata.service",
   gmpc                      = "gmpc.service",

   org                       = "org.service",
   calibre                   = "calibre.service",
   mu4e                      = "mu4e.service",
   chat                      = "chat.service",
   notes                     = "notes.service",
   xournal                   = "xournal.service",
   goldendict                = "goldendict.service",

   deluge                    = "deluge.service",
   amule                     = "amule.service",

   extempore                 = "extempore.service",
   sclang                    = "sclang.service",

   pidgin                    = "pidgin",
   skype                     = "skype",
   guvcview                  = "guvcview",

   pavucontrol               = "pavucontrol.service",
   qjackctl                  = "qjackctl.service",
   patchage                  = "patchage.service",
   qsynth                    = "qsynth",

   gnomedisks                = "gnome-disks",
   unison                    = "unison-gtk2",
   virtualbox                = "virtualbox",

   matlab                    = "matlab",
   sage                      = "tm:sage",
   octave                    = "tm:octave",
   maple                     = "xmaple",
   stellarium                = "stellarium",
   boinc                     = "boincm",

   ipython                   = "tm:ipython",
   ipython2                  = "tm:ipython2",
   lua                       = "tm:lua",
   ghci                      = "tm:ghci",

   libreoffice               = "libreoffice",
   gcstar                    = "gcstar",

   gimp                      = "gimp",
   inkscape                  = "inkscape",
   blender                   = "blender",
   luxrender                 = "luxrender",
   scribus                   = "scribus",
   qcad                      = "qcad",
   sigil                     = "sigil",
   pdfeditor                 = "pdfeditor",
   k3dsurf                   = "k3dsurf",
   kpovmodeler               = "kpovmodeler",
   openoffice                = "soffice",
   gucharmap                 = "gucharmap",

   ardour                    = "ardour3",
   rosegarden                = "rosegarden.service",
   denemo                    = "denemo",
   musescore                 = "musescore.service",

   avidemux                  = "avidemux2_gtk",
   subtitleeditor            = "subtitleeditor",
   puddletag                 = "puddletag",
   brasero                   = "brasero",

   qtcreator                 = "qtcreator",

   -- system state
   quit                      = "wmquit.target",
   lock                      = "lock.target",
   suspend                   = "suspend.target",
   poweroff                  = "poweroff.target",
   reboot                    = "reboot.target",

   priv                      = "mount-priv.service",

   hi                        = "sync-hi.service",
   bye                       = "sync-bye.service",
   byez                      = "sync-byez.service",
   byez                      = "sync-byeh.service",
   fakesync                  = "sync-fake.service",
}

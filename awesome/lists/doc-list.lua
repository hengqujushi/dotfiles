require("apps")

local qref_dir = "/home/abdo/work/qref"

return {
   -- local html docs
   cmake                 = "file:///usr/share/doc/cmake/cmake.html",
   cpack                 = "file:///usr/share/doc/cmake/cpack.html",
   ctest                 = "file:///usr/share/doc/cmake/ctest.html",

   python2               = "file:///usr/share/doc/python2/html/index.html",
   python3               = "file:///usr/share/doc/python/html/index.html",
   sage                  = "file:///home/abdo/sage/src/doc/output/html/en/index.html",
   scipy                 = "file:///usr/share/doc/python-scipy/html",
   lua                   = "file:///usr/share/doc/lua/contents.html",

   gcc                   = "file:///usr/share/doc/gcc/index.html",
   ["libstdc++"]         = "file:///usr/share/doc/libstdc++/index.html",
   qtcore                = "file:///usr/share/doc/qt/qtcore/qtcore-index.html",
   qtopengl              = "file:///usr/share/doc/qt/qtopengl/qtopengl-index.html",
   qtlinguist            = "file:///usr/share/doc/qt/qtlinguist/qtlinguist-index.html",
   qtquick               = "file:///usr/share/doc/qt/qtquick/qtquick-index.html",
   qtsensors             = "file:///usr/share/doc/qt/qtsensors/qtsensors-index.html",
   qtmultimedia          = "file:///usr/share/doc/qt/qtmultimedia/qtmultimedia-index.html",
   gtk3                  = "file:///usr/share/gtk-doc/html/gtk3/index.html",

   haskell               = "file:///usr/share/doc/ghc/html/libraries/index.html",
   zsh                   = "file:///usr/share/doc/zsh/zsh.html",
   awesome               = "file:///usr/share/doc/awesome/doc/index.html",

   org                   = "file:///usr/share/doc/org-mode/org.html",
   elisp                 = "file:///usr/share/doc/elisp/index.html",
   emacs                 = "file:///usr/share/doc/emacs/index.html",
   mu4e                  = "file:///usr/share/doc/mu4e/index.html",

   xapian                = "file:///usr/share/doc/xapian-core/index.html",

   -- online docs
   archwiki              = "https://wiki.archlinux.org/index.php/Main_Page",
   zshwiki               = "http://zshwiki.org/home/start",
   bashwiki              = "http://wiki.bash-hackers.org/doku.php",

   -- TODO: replace PDF docs with html ones
   -- ["latex-qref"]        = apps.pdfviewer  .. string.format(" %s/latex.pdf", qref_dir),
   -- ["vim-qref"]          = apps.pdfviewer  .. string.format(" %s/vim.pdf", qref_dir),
   -- ["emacs-qref"]        = apps.pdfviewer  .. string.format(" %s/emacs.pdf", qref_dir),

}
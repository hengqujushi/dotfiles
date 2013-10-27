(provide 'abdo-devel)


;; General things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; insert a vim-style modeline
(defun abdo-insert-modeline ()
  (interactive)
  (save-excursion
    (goto-char (point-max))
    (insert "\n# vim: expandtab:shiftwidth=4:tabstop=4:softtabstop=4:textwidth=80")))


;; Minor Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun trailing-whitespace-mode-delete-whitespaces ()
  (when (and (boundp 'trailing-whitespace-mode) trailing-whitespace-mode)
    (delete-trailing-whitespace)))

(define-minor-mode trailing-whitespace-mode
  "Toggle Trailing Whitespace mode.
   Interactively with no argument, this command toggles the mode.
   A positive prefix argument enables the mode, any other prefix
   argument disables it.  From Lisp, argument omitted or nil enables
   the mode, `toggle' toggles the state.

   When Trailing Whitespace mode is enabled, emacs removes all trailing
   whitespaces on save."

  ;; The initial value.
  :init-value nil

  ;; The indicator for the mode line.
  :lighter " TW"

  ;; The minor mode bindings.
  :keymap '()

  :group 'trailing-whitespaces

  ;; the body
  (add-hook 'before-save-hook 'trailing-whitespace-mode-delete-whitespaces nil t))


;; Compile buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; When compilation ends print a message and close
;; the compilation window if sucessful !

(defun abdo-compilation-finished (buffer msg)
  (if (string-match "^finished" msg)
    (progn
      (bury-buffer "*compilation*")
      (winner-undo)
      (message "Successful :)"))
    (message "Failed :("))
)

(defun abdo-compile-buffer-things()
  ;; When compilation  finishes
  (add-to-list 'compilation-finish-functions 'abdo-compilation-finished)

  ;; Scroll compilation until first error
  (setq compilation-scroll-output 'first-error)
)


;; Prog mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun abdo-prog-mode-things()
  (setq-default indent-tabs-mode nil)            ;; No tabs on indent
  (setq tab-width 4)

  ;; Development tools
  (semantic-mode 1)
  (require 'semantic/sb)
;  (ede-minor-mode 1)
)

;; Hook
(add-hook 'prog-mode-hook 'abdo-prog-mode-things)


;; Sage-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sage-command "sage")

;; enable inline output
(add-hook 'sage-startup-after-prompt-hook 'sage-view)


;; You can use commands like
;; (add-hook 'sage-startup-after-prompt-hook 'sage-view-disable-inline-output)
;; (add-hook 'sage-startup-after-prompt-hook 'sage-view-disable-inline-plots)
;; to enable some combination of features


;; Python-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I'm using built-in python.el (Fabián Ezequiel Gallina's version)

(defun abdo-python-mode-things()
  (setq python-shell-interpreter "ipython")

  ;; Delete trailing whitespaces before save
  (trailing-whitespace-mode)

;  (flyspell-prog-mode)                    ;; Enable flyspell on C/C++ comments
;  (abdo-change-dictionary "english")      ;; I always program in english

  (setq python-indent-offset 4)            ;; indentation
  (abdo-compile-buffer-things)
)

;; Hooks
(add-hook 'python-mode-hook 'abdo-python-mode-things)


;; Lua mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun abdo-lua-mode-things()
  (setq lua-indent-level 4)              ;; indentation

  ;; Delete trailing whitespaces before save
  (trailing-whitespace-mode)
)

;; Hooks
(add-hook 'lua-mode-hook 'abdo-lua-mode-things)


;; emacs lisp mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun abdo-emacs-lisp-mode-things()
  (abdo-compile-buffer-things)

  ;; Delete trailing whitespaces before save
  (trailing-whitespace-mode)
)

;; Hooks
(add-hook 'emacs-lisp-mode-hook 'abdo-emacs-lisp-mode-things)



;; Haskell mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;(add-hook 'haskell-mode-hook 'abdo-haskell-mode-things)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)



;; C++ mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun abdo-c-mode-things()
  (flyspell-prog-mode)                    ;; Enable flyspell on C/C++ comments
  (abdo-change-dictionary "english")      ;; I always program in english

  ;; indentation
  (setq c-basic-offset 4)

  ;; Delete trailing whitespaces before save
  (trailing-whitespace-mode)

  ;; Setup compile buffer stuff
  (abdo-compile-buffer-things)
)


;; Hooks
(add-hook 'c++-mode-hook 'abdo-c-mode-things)
(add-hook 'c-mode-hook 'abdo-c-mode-things)


;; gdb
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gdb-many-windows t)
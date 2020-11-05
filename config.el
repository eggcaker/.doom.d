;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "eggcaker"
      user-mail-address "eggcaker@gmail.com")


;; Modules
(load! "+defaults")
(load! "+bindings")
(load! "+ui")
(load! "+git")
(load! "+mail")
(load! "+org")
(load! "+anki")
(load! "+chat")
(load! "+tex")
(load! "+python")





  (with-eval-after-load 'lsp-mode
    (define-key lsp-mode-map (kbd "TAB") #'company-indent-or-complete-common))

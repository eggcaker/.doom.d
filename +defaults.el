;;; ~/.doom.d/+defaults.el -*- lexical-binding: t; -*-


(setq org-tags-column -116)
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setq
 x-select-enable-primary t
 select-enable-primary  t
 )

(setq rmh-elfeed-org-files (list "~/.org-notes/elfeed.org"))
(setq org-roam-directory "~/MyNotes")
(setq
 which-key-idle-delay 0.1
 which-key-idle-secondary-delay 0.2)

(setq-default abbrev-mode t)

(setq 
  abbrev-file-name "~/.doom.d/abbrev_defs.el")



(add-to-list 'exec-path "/usr/local/bin")


(setq-default server-name "emacs_server_27_2")


(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8);;=utf-16-le)
;; (set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;;(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


(setq-default projectile-track-known-projects-automatically nil)

(setq-default python-shell-interpreter "~/anaconda3/bin/python")


(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width. 100))


(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/.go/bin")))
(setq exec-path (append exec-path (list (expand-file-name "~/.go/bin"))))

(setq whitespace-global-modes '(not go-mode))

(setq-default tab-width 2)

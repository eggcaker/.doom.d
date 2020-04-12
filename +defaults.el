;;; ~/.doom.d/+defaults.el -*- lexical-binding: t; -*-


(setq org-tags-column -116)
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setq
 x-select-enable-primary t
 select-enable-primary  t
 )

(setq rmh-elfeed-org-files (list "~/.org-notes/elfeed.org"))

(setq
 which-key-idle-delay 0.1
 which-key-idle-secondary-delay 0.2)

(setq-default abbrev-mode t)

(setq 
  abbrev-file-name "~/.doom.d/abbrev_defs.el")

;;; k8s.el -*- lexical-binding: t; -*-

(use-package kubel
  :ensure t
  :config
  (set-popup-rule!
    "^\\*kubel" :ignore t)
  :commands (kubernetes-overview))

;; If you want to pull in the Evil compatibility package.
(use-package kubel-evil
  :ensure t
  :after kubel)

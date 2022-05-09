;;; k8s.el -*- lexical-binding: t; -*-


(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))



;; If you want to pull in the Evil compatibility package.
(use-package kubernetes-evil
  :ensure t)


(use-package k8s-mode
  :ensure t
  :hook (k8s-mode . yas-minor-mode))

(fset 'k8s 'kubernetes-overview)
(set-popup-rule! "^\\*kubernetes" :slot -1  :side 'right :size  120 :modeline nil :select t)

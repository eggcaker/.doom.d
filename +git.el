;;; ~/.doom.d/+git.el -*- lexical-binding: t; -*-

(setq magit-todos-depth 2)
(setq magit-repository-directories '(
        ("~/.doom.d/" . 0)
        ("~/.org-notes/" . 0)
        ("~/src/personal/emacs.cc/" .0 )
        ))

(set-popup-rule! "^\\*Magit Repositories" :size 35 :side 'bottom :select nil :ttl 0)

(after! magit
  (set-popup-rule! "^\\*Magit" :slot -1  :side 'right :size  80 :modeline nil :select t)
  (set-popup-rule! "^\\*Magit Repositories\\*" :side 'bottom :size 50 :modeline nil :select nil)
  (set-popup-rule! "^\\*magit.*popup\\*" :slot 0 :side 'right  :modeline nil :select  t)
  (set-popup-rule! "^\\*magit-revision:.*" :slot  0 :side  'right :window-height 0.6 :modeline  nil :select  t)
  (set-popup-rule! "^\\*magit-diff:.*" :slot  0 :side 'right :window-height  0.6 :modeline nil :select nil)
  (add-hook! 'magit-popup-mode-hook #'doom-hide-modeline-mode))

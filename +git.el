;;; ~/.doom.d/+git.el -*- lexical-binding: t; -*-

(setq magit-todos-depth 2)
(setq magit-repository-directories '(
                                     ("D:\\Work\\Xiaobing" . 0)
                                     ("D:\\Work\\AICreation\\BusinessSolution-FE-AST" . 0)
                                     ))

(set-popup-rule! "^\\*Magit Repositories" :size 35 :side 'bottom :select nil :ttl 0)

(after! magit
  (set-popup-rule! "^\\*Magit" :slot -1  :side 'right :size  80 :modeline nil :select t)
  (set-popup-rule! "^\\*Magit Repositories\\*" :side 'bottom :size 50 :modeline nil :select nil)
  (set-popup-rule! "^\\*magit.*popup\\*" :slot 0 :side 'right  :modeline nil :select  t)
  (set-popup-rule! "^\\*magit-gitflow.*popup\\*" :slot 0 :side 'bottom :size 0.25 :modeline nil :select  t)
  (set-popup-rule! "^\\*magit-revision:.*" :slot  0 :side  'right :window-height 0.6 :modeline  nil :select  t)
  (set-popup-rule! "^\\*magit-diff:.*" :slot  0 :side 'right :window-height  0.6 :modeline nil :select nil))

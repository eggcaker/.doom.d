;;; +gtd.el -*- lexical-binding: t; -*-

(use-package org-super-agenda
  :after org-agenda
  :init
  (add-hook! 'after-init-hook 'org-super-agenda-mode)
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-include-deadlines t
   org-agenda-include-diary nil
   org-agenda-block-separator nil
   org-agenda-compact-blocks t
   org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
        '(("." "My Agenda"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-start-day "1d")
                        (org-super-agenda-groups
                         '((:name "Today List"
                                  :time-grid t
                                  :date today
                                  :todo "INPROCESS"
                                  :scheduled today
                                  :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '(
                            (:name "Tasks to Refile"
                                   :category "Inbox"
                                   :order 1)
                            (:name "Next to do"
                                   :priority>= "B"
                                   :order 2)
                            (:name "Due Soon"
                                   :deadline future
                                   :order 8)
                            (:name "Overdue"
                                   :deadline past
                                   :order 20)
                            (:name "Xiaobing"
                                   :category "Xiaobing"
                                   :tag "Xiaobing"
                                   :order 10)
                            (:name "Emacs"
                                   :category "Emacs"
                                   :tag "Emacs"
                                   :order 13)
                            (:name "Japanese Learning"
                                   :category "Japanese"
                                   :tag "Japanese"
                                   :order 14)
                            (:name "Waiting"
                                   :todo "WAIT"
                                   :order 18)
                            (:name "trivial"
                                   :priority<= "C"
                                   :todo ("SOMEDAY")
                                   :order 90)
                            (:discard (:tag ("Chore" "Routine" "Daily")))))))))))


  :config
  (org-super-agenda-mode)
  )




(with-eval-after-load 'ox-latex
 ;; http://orgmode.org/worg/org-faq.html#using-xelatex-for-pdf-export
 ;; latexmk runs pdflatex/xelatex (whatever is specified) multiple times
 ;; automatically to resolve the cross-references.
 (setq org-latex-pdf-process '("latexmk -xelatex -quiet -shell-escape -f %f"))
 (add-to-list 'org-latex-classes
               '("elegantpaper"
                 "\\documentclass[lang=cn]{elegantpaper}
                 [NO-DEFAULT-PACKAGES]
                 [PACKAGES]
                 [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-listings 'minted)
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (add-to-list 'org-latex-packages-alist '("margin=1cm" "geometry" nil))
  )

;;; ~/.doom.d/+defaults.el -*- lexical-binding: t; -*-


(setq-default which-key-idle-delay 0.1)
(setq-default which-key-idle-secondary-delay 0.2)
(setq org-tags-column -116)
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setq
 x-select-enable-primary t
 select-enable-primary  t
 )

(setq rmh-elfeed-org-files (list "~/.org-notes/elfeed.org"))

(add-hook! LaTeX-mode
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  )

(setq-default TeX-command-default "XeLaTeX"
        TeX-save-query nil
        TeX-show-compilation t)
(setq-default latex-run-command "xelatex")

(setq-default TeX-engine 'xetex)

(setq org-latex-classes
      '("report"
        "\\documentclass{report}"
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

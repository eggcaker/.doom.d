;;; ~/.doom.d/+defaults.el -*- lexical-binding: t; -*-


(setq org-tags-column -116)
(setq doom-scratch-initial-major-mode 'emacs-lisp-mode)
(setq
 x-select-enable-primary t
 select-enable-primary  t
 )

(setq rmh-elfeed-org-files (list "~/.org-notes/elfeed.org"))

(add-hook! LaTeX-mode
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
  )

(setq-default
 which-key-idle-delay 0.1
 which-key-idle-secondary-delay 0.2
 TeX-command-default "XeLaTeX"
 TeX-save-query nil
 TeX-show-compilation t
 latex-run-command "xelatex"
 pdf-latex-command "xelatex"
 TeX-engine 'xetex)

(setq org-latex-classes
      '("report"
        "\\documentclass{report}"
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

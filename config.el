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
;;(load! "+tex")


(after! latex
  ;; turn of auto-fill-mode (better way?)
  (add-hook 'latex-mode-hook 'turn-off-auto-fill)
  ;; works better with minted environments
  (setq TeX-parse-self t)
  (add-to-list 'LaTeX-verbatim-environments "minted")
  (add-to-list 'LaTeX-verbatim-environments "Verbatim")
  ;; xetex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' --shell-escape %t" TeX-run-TeX nil t))

  ;; Lifted from spacemacs
  (map!
   (:map (TeX-mode-map LaTeX-mode-map)
     (:localleader
       :desc "TeX-command-master"         :n "," #'TeX-command-master          ;; C-c C-c
       :desc "TeX-command-run-all"        :n "a" #'TeX-command-run-all         ;; C-c C-a
       :desc "TeX-view"                   :n "v" #'TeX-view                    ;; C-c C-v
       :desc "TeX-clean"                  :n "d" #'TeX-clean
       :desc "Text Preview"               :n "p" #'latex-preview-pane-update
       :desc "TeX-kill-job"               :n "k" #'TeX-kill-job                ;; C-c C-k
       :desc "TeX-recenter-output-buffer" :n "l" #'TeX-recenter-output-buffer  ;; C-c C-l
       :desc "TeX-insert-macro"           :n "m" #'TeX-insert-macro            ;; C-c C-m
       :desc "LaTeX-fill-paragraph"       :n "fp" #'LaTeX-fill-paragraph       ;; C-c C-q C-p
       :desc "LaTeX-fill-region"          :n "fr" #'LaTeX-fill-region          ;; C-c C-q C-r
       ;; :desc "TeX-comment-or-uncomment-paragraph"  :n "%" #'TeX-comment-or-uncomment-paragraph   ;; C-c %
       ;; :desc "TeX-comment-or-uncomment-region"     :n ";" #'TeX-comment-or-uncomment-region      ;; C-c ; or C-c :
       ))))


(setq org-latex-classes
      '("report"
        "\\documentclass{report}"
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

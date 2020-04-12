;;; ~/.doom.d/+tex.el -*- lexical-binding: t; -*-


(setq +latex-viewers '(skim))

(setq-default
 TeX-command-default "XeLaTeX"
 TeX-save-query nil
 TeX-show-compilation t
 latex-run-command "xelatex"
 pdf-latex-command "xelatex"
 TeX-engine 'xetex
 Tex-PDF-mode t)
(after! doc-view
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
)

(use-package! latex-pretty-symbols
  :after latex
  )

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

(after! bibtex
  ;; bibliography
  ;; (setq reftex-default-bibliography "~/Zotero/bib.bib")
  ;; Optionally specifying a location for the corresponding PDFs
  ;; (setq bibtex-completion-library-path (list "/your/bib/pdfs"))
  ;; dialect, bibtex vs biblatex
  (setq bibtex-dialect 'BibTeX))

(after! LaTeX-mode
  (set-company-backend!
    'latex-mode
    'company-auctex
    'company-reftex
    'company-capf
    'company-lsp
    'company-files
    'company-dabbrev
    'company-keywords
    'company-yasnippet))

(setq org-latex-classes
      '("report"
        "\\documentclass{report}"
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

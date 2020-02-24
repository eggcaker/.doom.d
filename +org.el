;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-

(after! org
  (setq org-directory "~/.org-files/")
  (setq org-crypt-tag-matcher "secret")
  (setq org-tags-exclude-from-inheritance (quote ("secret")))
  (setq org-crypt-key "CF0B552FF")
  (setq org-todo-keywords
        '((sequence
           "☞ TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; An ongoing project that cannot be completed in one step
           "⚔ INPROCESS(s)"  ; A task that is in progress
           "⚑ WAITING(w)"  ; Something is holding up this task; or it is paused
           "|"
           "☟ NEXT(n)"
           "✰ Important(i)"
           "✔ DONE(d)"  ; Task successfully completed
           "✘ CANCELED(c@)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "✍ NOTE(N)"
           "FIXME(f)"
           "☕ BREAK(b)"
           "❤ Love(l)"
           "REVIEW(r)"
           )) ; Task ras completed
        )

  )


;; latex for chinese
(after! latex
  (add-to-list 'org-latex-classes '("article" "\\documentclass[a4paper,11pt]{article}

        [NO-DEFAULT-PACKAGES]
          \\usepackage[utf8]{inputenc}
          \\usepackage[T1]{fontenc}
          \\usepackage{fixltx2e}
          \\usepackage{graphicx}
          \\usepackage{longtable}
          \\usepackage{float}
          \\usepackage{wrapfig}
          \\usepackage{rotating}
          \\usepackage[normalem]{ulem}
          \\usepackage{amsmath}
          \\usepackage{textcomp}
          \\usepackage{marvosym}
          \\usepackage{wasysym}
          \\usepackage{amssymb}
          \\usepackage{booktabs}
          \\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
          \\tolerance=1000
          \\usepackage{listings}
          \\usepackage{xcolor}
          \\usepackage{fontspec}
          \\usepackage{xeCJK}
          \\setCJKmainfont{Weibei SC}
          \\setmainfont{Fantasque Sans Mono}
          \\lstset{
          %行号
          numbers=left,
          %背景框
          framexleftmargin=10mm,
          frame=none,
          %背景色
          %backgroundcolor=\\color[rgb]{1,1,0.76},
          backgroundcolor=\\color[RGB]{245,245,244},
          %样式
          keywordstyle=\\bf\\color{blue},
          identifierstyle=\\bf,
          numberstyle=\\color[RGB]{0,192,192},
          commentstyle=\\it\\color[RGB]{0,96,96},
          stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
          %显示空格
          showstringspaces=false
          }
          "
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; {{ export org-mode in Chinese into PDF
  ;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
  ;; and you need install texlive-xetex on different platforms
  ;; To install texlive-xetex:
  ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
  ;; }}
  ;;(setq org-latex-default-class "ctexart")
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-src-fontify-natively t)
  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "rm -fr %b.out %b.log %b.tex auto"))
  )


;; org deft
(use-package! notdeft
  :config
  (setq notdeft-extension "org")
  ;;(setq notdeft-secondary-extensions '("md" "org" "scrbl"))
  (setq notdeft-directories '("~/src/personal/emacs.cc/blog/myself"
                              "~/src/personal/emacs.cc/blog/life-thing"
                              "~/src/personal/emacs.cc/blog/life-thing"
                              "~/src/personal/emacs.cc/blog/traveling"
                              "~/src/personal/emacs.cc/blog/agenda"
                              "~/src/personal/emacs.cc/books"
                              "~/.org-notes/learning-list"
                              "~/.org-notes/GTD"
                              ))
  (setq notdeft-xapian-program "/usr/local/bin/notdeft-xapian")

  :bind (:map notdeft-mode-map
          ("C-q" . notdeft-quit)
          ("C-r" . notdeft-refresh)
          ))


(use-package! org-contacts
  :ensure nil
  :after org
  :custom (org-contacts-files '("~/.org-notes/GTD/contacts.org")))


(use-package! org-books
  :after org
  :custom (org-books-file "~/src/personal/emacs.cc/books/index.org"))

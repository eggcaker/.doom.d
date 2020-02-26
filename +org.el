;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-
(defconst my-org-completed-date-regexp
  (concat "\\("
          "CLOSED: \\[%Y-%m-%d"
          "\\|"
          "- State \"\\(DONE\\|CANCELLED\\)\" * from .* \\[%Y-%m-%d"
          "\\|"
          "- State .* ->  *\"\\(DONE\\|CANCELLED\\)\" * \\[%Y-%m-%d"
          "\\)")
  "Matches any completion time stamp.")

(after! org
  (set-popup-rule! "^\\*Org Agenda" :ignore t)
  (setq org-refile-targets
        '((nil :maxlevel . 5)
          (org-agenda-files :maxlevel . 5)))
  (setq org-tags-match-list-sublevels nil)
  (setq org-log-done  'time)
  (setq org-agenda-window-setup 'only-window)
  (setq org-clock-into-drawer t)
  (setq org-log-into-drawer t)
  (setq org-agenda-start-day "-1d")
  (setq org-agenda-span 2)
  (setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))
  (setq org-archive-location (concat "%s_archive_" (format-time-string "%Y" (current-time)) "::"))
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state "INPROCESS")
  (setq org-src-fontify-natively t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-src-window-setup 'current-window)
  (setq org-agenda-time-leading-zero t)
  (setq org-download-timestamp "%Y%m%d_%H%M%S")
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (setq org-bullets-bullet-list '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱" ))
  (setq org-directory "~/.org-notes/GTD")
  (setq org-crypt-tag-matcher "secret")
  (setq org-tags-exclude-from-inheritance (quote ("secret")))
  (setq org-crypt-key "CF0B552FF")

(setq org-agenda-custom-commands
      '(("l" "My Agenda"
         ((agenda "" ((org-agenda-span 2)
                      (org-agenda-start-day "-1d")
                      (org-super-agenda-groups
                       '((:name "Today List"
                                :time-grid t
                                :date today
                                :todo "INPROCESS\\|NEXT"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :priority>= "B"
                                 :order 2)
                          (:name "Due Today"
                                 :deadline today
                                 :order 3)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 20)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag ("BOOK" "READ")
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 18)
                          (:name "trivial"
                                 :priority<= "C"
                                 :todo ("SOMEDAY")
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))
        ("." "Today"
         (
          ;; List of all TODO entries with deadline before today.
          (tags-todo "DEADLINE<=\"<+0d>\"|SCHEDULED<=\"<+0d>\""
                     ((org-agenda-overriding-header "OVERDUE")
                      ;;(org-agenda-skip-function
                      ;; '(org-agenda-skip-entry-if 'notdeadline))
                      (org-agenda-sorting-strategy '(priority-down))))

          (tags-todo "TODO={WAITING}"
                     ((org-agenda-overriding-header "Waiting For")
                      ;;(org-agenda-skip-function
                      ;; '(org-agenda-skip-entry-if 'notdeadline))
                      (org-agenda-sorting-strategy '(priority-down))))

          (agenda ""
                  ((org-agenda-entry-types '(:scheduled))
                   (org-agenda-overriding-header "SCHEDULED")
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-sorting-strategy
                    '(priority-down time-up))
                   (org-agenda-span 'day)
                   (org-agenda-start-on-weekday nil)
                   (org-agenda-time-grid nil)))
          ;; List of all TODO entries completed today.
          (todo "TODO|DONE|CANCELLED" ; Includes repeated tasks (back in TODO).
                ((org-agenda-overriding-header "COMPLETED TODAY")
                 (org-agenda-skip-function
                  '(org-agenda-skip-entry-if
                    'notregexp
                    (format-time-string my-org-completed-date-regexp)))
                 (org-agenda-sorting-strategy '(priority-down)))))
         ((org-agenda-format-date "")
          (org-agenda-start-with-clockreport-mode nil)))

        ("b" . "BOOK")

        ("bb" "Search tags in todo, note, and archives"
         search "+{:book\\|books:}")

        ("bd" "BOOK TODO List"
         search "+{^\\*+\\s-+\\(INPROCESS\\|TODO\\|WAITING\\)\\s-} +{:book\\|books:}")

        ("d" "ALL DONE OF TASKS"
         search "+{^\\*+\\s-+\\(DONE\\|CANCELED\\)\\s-}")

        ("i" "ALL INPROCESS OF TASKS"
         search "+{^\\*+\\s-+\\(INPROCESS\\)\\s-}")
        ))

  (defun my-org-confirm-babel-evaluate (lang _body)
    "Return t if LANG is in whitelist."
    (not (or (string= lang "ditaa")
             (string= lang "dot")
             (string= lang "R")
             (string= lang "julia")
             (string= lang "C++")
             (string= lang "C")
             (string= lang "ein-R")
             (string= lang "python")
             (string= lang "ein-julia")
             (string= lang "ein-python")
             (string= lang "plantuml"))))

  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "STRT(s)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "|" "SOMEDAY(o)" "CANCELLED(c@/!)"))))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "#D32F2F" :weight bold)
                ("STRT" :foreground "#C8E6C9" :weight bold)
                ("NEXT" :foreground "#1E88E5" :weight bold)
                ("DONE" :foreground "#43A047" :weight bold)
                ("WAITING" :foreground "#de935f" :weight bold)
                ("SOMEDAY" :foreground "#78909C" :weight bold)
                ("CANCELLED" :foreground "#BDBDBD" :weight bold))))
  ;; trigger task states
  (setq org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t))
                ("WAITING" ("WAITING" . t))
                (done ("WAITING"))
                ("TODO" ("WAITING") ("CANCELLED"))
                ("NEXT" ("WAITING") ("CANCELLED"))
                ("DONE" ("WAITING") ("CANCELLED")))))
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
(setenv "XAPIAN_CJK_NGRAM" "1")
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

(use-package! org-super-agenda
  :after org
  :config
  (add-hook! 'after-init-hook 'org-super-agenda-mode)
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-include-deadlines t
   org-agenda-include-diary nil
   org-agenda-block-separator nil
   org-agenda-compact-blocks t
   org-agenda-start-with-log-mode t))

(use-package! org-starter
  :after org
  :config
  (org-starter-def "~/.org-notes"
    :files
    ("GTD/gtd.org"                      :agenda t :key "g" :refile (:maxlevel . 5))
    ("GTD/notes.org"                    :agenda t :key "n" :refile (:maxlevel . 5 ))
    ("GTD/myself.org"                   :agenda t :key "m" :refile (:maxlevel . 5 ))
    ("GTD/Habit.org"                    :agenda t :key "h" :refile (:maxlevel . 5 ))
    )
  (org-starter-def "~/src/personal/emacs.cc"
    :files
    ("blog/traveling/index.org" :key "t" :refile (:maxlevel . 5 ))
    ("blog/myself/life.org"         :key "l" :refile (:maxlevel . 5 ))
    ("blog/myself/plan.org"         :key "p" :refile (:maxlevel . 5 ))
    ("books/index.org"             :agenda t :key "b" :refile (:maxlevel . 5 ))
    )

  (defhydra eggcaker/hydra-org-starter nil
    "
  Org-starter-files
  ^^^^------------------------------------------------
 _g_: gtd.org     _l_: life.org    _b_: My books
 _n_: note        _t_: traveling   _h_: Habit.org
 _m_: myself      _p_: Plan.org

  "
    ("g" org-starter-find-file:gtd)
    ("n" org-starter-find-file:notes)
    ("m" org-starter-find-file:myself)
    ("t" org-starter-find-file:traveling)
    ("l" org-starter-find-file:life)
    ("h" org-starter-find-file:Habit)
    ("p" org-starter-find-file:plan)
    ("b" org-starter-find-file:index)
    ("q" quit-window "quit" :color blue))


  )

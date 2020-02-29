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

(setq org-my-anki-file "~/.org-notes/anki/anki.org")

(after! org
  (set-popup-rule! "^\\*Org Agenda" :ignore t)

  (setq org-refile-targets
        '((nil :maxlevel . 5)
          (org-agenda-files :maxlevel . 5)))
  (setq org-agenda-inhibit-startup t)   ;; ~50x speedup
  (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
  (setq org-agenda-window-setup 'current-window)
  (setq org-ctrl-k-protect-subtree t)                                   ;; Protect my subtrees!
  (setq org-blank-before-new-entry
        '((heading . nil) (plain-list-item . nil)))                       ;; Insert empty line before new headlines, but not before list item
  (setq org-footnote-auto-adjust t)                                     ;; Automatically renumber footnotes
  (setq org-goto-auto-isearch nil)
  (setq org-refile-allow-creating-parent-nodes t)
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

  (setq org-capture-templates
        '(("t" "Todo item " entry
           (file+headline "~/.org-notes/GTD/inbox.org" "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("a" "Anki basic"
                entry
                (file+headline org-my-anki-file "Dispatch Shelf")
                "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** Back\n%x\n")
          ("A" "Anki cloze"
           entry
           (file+headline org-my-anki-file "Dispatch Shelf")
           "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x\n** Extra\n")
          ("n" "Notes" entry
           (file+headline "~/.org-notes/GTD/notes.org" "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("c" "Contacts" entry (file "~/.org-notes/GTD/contacts.org")
           "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:PHONE:
:WECHAT:
:BIRTHDAY:
:NOTE:
:END:")))

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
                            (:name "Due Today"
                                   :deadline today
                                   :order 3)
                            (:name "Due Soon"
                                   :deadline future
                                   :order 8)
                            (:name "Overdue"
                                   :deadline past
                                   :order 20)
                            (:name "Have fun With Emacs"
                                   :category "Emacs"
                                   :tag "Emacs"
                                   :order 13)
                            (:name "Japanese Learning"
                                   :category "Japanese"
                                   :tag "Japanese"
                                   :order 14)
                            (:name "Research"
                                   :category "Research"
                                   :tag "Research"
                                   :order 15)
                            (:name "NixOS to Research"
                                   :category "NixOS"
                                   :tag "NixOS"
                                   :order 16)
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
             (string= lang "emacs-lisp")
             (string= lang "C")
             (string= lang "ein-R")
             (string= lang "python")
             (string= lang "ein-julia")
             (string= lang "ein-python")
             (string= lang "plantuml"))))

  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "INPROCESS(i)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "|" "SOMEDAY(o)" "CANCELLED(c@/!)"))))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "#D32F2F" :weight bold)
                ("INPROCESS" :foreground "#C8E6C9" :weight bold)
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
  (setq notdeft-directories '(
                              "~/src/personal/emacs.cc/content-org"
                              "~/.org-notes/learning-list"
                              "~/.org-notes/GTD"
                              ))
  (setq notdeft-xapian-program "/usr/local/bin/notdeft-xapian")

 (when (featurep! :editor evil)
    ;; Neither wl-folder-mode or wl-summary-mode are correctly defined as major
    ;; modes, so `evil-set-initial-state' won't work here.
    (add-hook! '(notdeft-mode-hook)
               #'evil-emacs-state))

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

(use-package!  org-super-agenda
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
  :config
  (org-super-agenda-mode)
  ;;  (require 'org-habit))

(use-package! org-starter
  :after org
  :config
  (org-starter-def "~/.org-notes"
    :files
    ("GTD/gtd.org"             :agenda t :key "g" :refile (:maxlevel . 5 ))
    ("GTD/inbox.org"           :agenda t :key "i" :refile (:maxlevel . 5 ))
    ("GTD/notes.org"           :agenda t :key "n" :refile (:maxlevel . 5 ))
    ("GTD/contacts.org"        :agenda t :key "c" :refile (:maxlevel . 5 ))
    ("GTD/myself.org"          :agenda t :key "m" :refile (:maxlevel . 5 ))
    ("GTD/Habit.org"           :agenda t :key "h" :refile (:maxlevel . 5 ))
    )
  (org-starter-def "~/src/personal/emacs.cc"
    :files
    ("content-org/blog.org"    :agenda t :key "b" :refile (:maxlevel . 5 ))
    ("content-org/pages.org"   :agenda t :key "p" :refile (:maxlevel . 5 )))

  (defhydra eggcaker/hydra-org-starter nil
    "
  Org-starter-files
  ^^^^------------------------------------------------
 _b_: blogs       _c_: contacts    _g_: gtd.org
 _n_: note        _h_: Habit.org   _i_: inbox
 _m_: myself      _p_: pages.org

  "
    ("b" org-starter-find-file:blog)
    ("c" org-starter-find-file:contacts)
    ("g" org-starter-find-file:gtd)
    ("h" org-starter-find-file:Habit)
    ("i" org-starter-find-file:inbox)
    ("m" org-starter-find-file:myself)
    ("n" org-starter-find-file:notes)
    ("p" org-starter-find-file:pages)
    ("q" quit-window "quit" :color blue))
  )


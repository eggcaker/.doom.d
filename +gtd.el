;;; +gtd.el -*- lexical-binding: t; -*-

;; (use-package org-trello
;;   :after org
;;   :init
;;   (add-hook! 'after-init-hook 'org-trello-mode)
;;   )


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
                                  ;;:todo '("INPROCESS" "TODO")
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
                            (:name "Overdue"
                                   :deadline past
                                   :order 3)
                            (:name "Due Soon"
                                   :deadline today
                                   :order 4)
                            (:name "Cx-Related"
                                   :category "CX"
                                   :tag "Xiaobing"
                                   :order 5)
                            (:name "Backend"
                                   :and (:todo "TODO" :category "Backend")
                                   :order 6)
                            (:name "DevOps"
                                   :and (:todo "TODO" :category "DevOps")
                                   :habit nil
                                   :order 7)
                            (:name "Android"
                                   :and (:todo "TODO" :category "Android")
                                   :order 8)
                             (:name "Life"
                                   :category "Life"
                                   :order 9)
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
                            (:discard (:anything t ))

                            ))))))))


  :config
  (org-super-agenda-mode)
  )


(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(after! org
    (setq org-ellipsis " ▾")
    (define-key org-mode-map (kbd "C-c C-r") verb-command-map)
    (defun cc/org-font-setup ()
      ;; Replace list hyphen with dot
      (font-lock-add-keywords 'org-mode
                              '(("^ *\\([-]\\) "
                                 (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


      (map! :leader
            :desc "Archive all DONE tasks" "o D" #'my-archive-all-done)

      ;; Set faces for heading levels
      (dolist (face '((org-level-1 . 1.2)
                      (org-level-2 . 1.1)
                      (org-level-3 . 1.05)
                      (org-level-4 . 1.0)
                      (org-level-5 . 1.1)
                      (org-level-6 . 1.1)
                      (org-level-7 . 1.1)
                      (org-level-8 . 1.1)))
        (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

      ;; Ensure that anything that should be fixed-pitch in Org files appears that way
      (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
      (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
      (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
      (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
      (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
      (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
      (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
      (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
      (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))


    (setq org-capture-templates
          '(
            ("t" "Simple todo item " entry
             (file+headline +org-capture-todo-file "Inbox")
             "* TODO %?\n%i\n%a" :prepend t)))


    ;; TODO for now should fix the font zoom in not working for zen mode
    ;; (cc/org-font-setup)
  )



(defun my-archive-all-done ()
  "Archive all DONE tasks in the current org-mode buffer."
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))


(after! org-agenda
  (defun cc/open-agenda()
    (interactive)
    (org-agenda nil "."))
  (define-key! "<f12>" 'cc/open-agenda))

(use-package! vulpea
        :hook ((org-roam-db-autosync-mode . vulpea-db-autosync-enable)))


(use-package! deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/MyNotes"
                deft-recursive t
                deft-extensions '("md" "org")))


(after! org-roam

 ;; (org-roam-completion-everywhere t)
 ;;  (org-roam-completion-system 'default)
 ;;  (org-roam-capture-templates
 ;;   '(("d" "default" plain
 ;;      #'org-roam-capture--get-point
 ;;      "%?"
 ;;      :file-name "%<%Y%m%d%H%M%S>-${slug}"
 ;;      :head "#+title: ${title}\n"
 ;;      :unnarrowed t)
 ;;     ("ll" "link note" plain
 ;;      #'org-roam-capture--get-point
 ;;      "* %^{Link}"
 ;;      :file-name "Inbox"
 ;;      :olp ("Links")
 ;;      :unnarrowed t
 ;;      :immediate-finish)
 ;;     ("lt" "link task" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* TODO %^{Link}"
 ;;      :file-name "Inbox"
 ;;      :olp ("Tasks")
 ;;      :unnarrowed t
 ;;      :immediate-finish)))
 ;;  (org-roam-dailies-directory "Journal/")
 ;;  (org-roam-dailies-capture-templates
 ;;   '(("d" "default" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* %?"
 ;;      :file-name "Journal/%<%Y-%m-%d>"
 ;;      :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
 ;;     ("t" "Task" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* TODO %?\n  %U\n  %a\n  %i"
 ;;      :file-name "Journal/%<%Y-%m-%d>"
 ;;      :olp ("Tasks")
 ;;      :empty-lines 1
 ;;      :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
 ;;     ("j" "journal" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* %<%I:%M %p> - Journal  :journal:\n\n%?\n\n"
 ;;      :file-name "Journal/%<%Y-%m-%d>"
 ;;      :olp ("Log")
 ;;      :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
 ;;     ("l" "log entry" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* %<%I:%M %p> - %?"
 ;;      :file-name "Journal/%<%Y-%m-%d>"
 ;;      :olp ("Log")
 ;;      :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
 ;;     ("m" "meeting" entry
 ;;      #'org-roam-capture--get-point
 ;;      "* %<%I:%M %p> - %^{Meeting Title}  :meetings:\n\n%?\n\n"
 ;;      :file-name "Journal/%<%Y-%m-%d>"
 ;;      :olp ("Log")
 ;;             :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")))


  )


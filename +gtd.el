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

  (setq org-capture-templates
        '(
          ("t" "Simple todo item " entry
                 (file+headline +org-capture-todo-file "Inbox")
                 "* TODO %?\n%i\n%a" :prepend t)))


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

    (defun cc/org-font-setup ()
      ;; Replace list hyphen with dot
      (font-lock-add-keywords 'org-mode
                              '(("^ *\\([-]\\) "
                                 (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

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

    ;; TODO for now should fix the font zoom in not working for zen mode
    ;; (cc/org-font-setup)
  )


(after! org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map)

  )

(after! org-agenda
  (defun cc/open-agenda()
    (interactive)
    (org-agenda nil "."))
  (define-key! "<f12>" 'cc/open-agenda))

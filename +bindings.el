;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; setup fd to exit insert mode instead jk

(setq-default evil-escape-key-sequence "fd")

(map!
 (:map with-editor-mode-map
   :desc "Previous comment" "C-k" #'log-edit-previous-comment
   (:prefix ","
     :desc "Commit" :n "c" #'with-editor-finish
     :desc "Abort commit" :n "k" #'with-editor-cancel)))


(map!
 ;; Comma for shortcut to local-leader
 :n "," (λ! (push (cons t ?m) unread-command-events)
            (push (cons t 32) unread-command-events))

 (:after org-super-agenda
   (:map org-super-agenda-header-map
     :desc "Previous line" "k" #'evil-previous-line
     :desc "Next line" "j" #'evil-next-line))

 (:after org-agenda
   (:map org-agenda-mode-map
     :desc "Previous line" "k" #'evil-previous-line
     :desc "next line" "j" #'evil-next-line))

 (:after magit
   (:map with-editor-mode-map
     :desc "Previous comment" "C-k" #'log-edit-previous-comment
     (:prefix ","
       :desc "Commit" :n "c" #'with-editor-finish
       :desc "Commit" :n "," #'with-editor-finish
       :desc "Abort commit" :n "k" #'with-editor-cancel)))

 (:leader
   (:prefix "o"
     :desc "Goto any Heading of opening org" :n "j" #'counsel-org-goto-all
     :desc "Open org file" :n "o" #'eggcaker/hydra-org-starter/body))

 (:leader
   (:prefix "f"
     :desc "Save file (Spacemacs)" :n "s" #'save-buffer
     :desc "Find file (Spacemacs)" :n "f" #'find-file
     :desc "Neotree toggle (Spacemacs)" :n "t" #'neotree-toggle)
   (:prefix "b"
     :desc "Previous buffer (Spacemacs)" :n "p" #'previous-buffer
     :desc "Next buffer (Spacemacs)" :n "n" #'next-buffer
     :desc "Switch buffer (Spacemacs)" :n "b" #'switch-to-buffer)
   (:prefix "w"
     :desc "Vertical split (Spacemacs)" :n "|" #'evil-window-vsplit
     :desc "Horizontal split (Spacemacs)" :n "-" #'evil-window-split
     ;; Displaced by other-frame keybinding
     :desc "Window enlargen" :n "O" #'doom/window-enlargen)
   ))

(map! :leader :desc "M-x" "SPC"  #'execute-extended-command)

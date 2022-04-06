;;; ~/.doom.d/+chat.el -*- lexical-binding: t; -*-

(after! circe
  (set-irc-server! "localhost"
    `(:tls nil
      :port 6667
      :nick "eggcaker"
      :sasl-username "eggcaker"
      :sasl-password "wabjtam"
      :channels ("#openapi" "#nu-help")))
  )
(load! ".private.el")

;; (use-package! slack
;;   :commands (slack-start)
;;   :init
;;   (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
;;   (setq slack-prefer-current-team t)
;;   :config
;;   (slack-register-team
;;    :name "xiaobingworkspace"
;;    :default t
;;    :token my-slack-token
;;    :cookie my-slack-cookie
;;    :subscribed-channels '(openapi openapi-kuangshi)
;;    :full-and-display-names t)

;;   (evil-define-key 'normal slack-info-mode-map
;;     ",u" 'slack-room-update-messages)
;;   (evil-define-key 'normal slack-mode-map
;;     ",c" 'slack-buffer-kill
;;     ",ra" 'slack-message-add-reaction
;;     ",rr" 'slack-message-remove-reaction
;;     ",rs" 'slack-message-show-reaction-users
;;     ",pl" 'slack-room-pins-list
;;     ",pa" 'slack-message-pins-add
;;     ",pr" 'slack-message-pins-remove
;;     ",mm" 'slack-message-write-another-buffer
;;     ",me" 'slack-message-edit
;;     ",md" 'slack-message-delete
;;     ",u" 'slack-room-update-messages
;;     ",2" 'slack-message-embed-mention
;;     ",3" 'slack-message-embed-channel
;;     "\C-n" 'slack-buffer-goto-next-message
;;     "\C-p" 'slack-buffer-goto-prev-message)
;;   (evil-define-key 'normal slack-edit-message-mode-map
;;     ",k" 'slack-message-cancel-edit
;;     ",s" 'slack-message-send-from-buffer
;;     ",2" 'slack-message-embed-mention
;;     ",3" 'slack-message-embed-channel))

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

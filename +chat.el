;;; ~/.doom.d/+chat.el -*- lexical-binding: t; -*-

(after! circe
  (set-irc-server! "chat.freenode.net"
    `(:tls t
      :port 6697
      :nick "eggcaker"
      :sasl-username "eggcaker"
      :sasl-password ,(+pass-get-secret "websites/freenode.net/eggcaker")
      :channels ("#emacs" "#org-mode"))))

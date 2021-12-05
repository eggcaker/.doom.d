;;; ~/.doom.d/+mail.el -*- lexical-binding: t; -*-

(after! mu4e
  (setq
   mu4e-get-mail-command "mbsync -c ~/.mbsyncrc -a"
   mu4e-maildir        (expand-file-name "~/.mails")
   mu4e-attachment-dir (expand-file-name "attachments" mu4e-maildir)
   smtpmail-stream-type 'starttls
   smtpmail-smtp-user "eggcaker"
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587
   mu4e-sent-folder "/Sent Mail"
   mu4e-drafts-folder "/Drafts"
   mu4e-trash-folder "/Trash"
   mu4e-refile-folder "/All Mail"
   mu4e-maildir-shortcuts '(("/Inbox"     . ?i)
                            ("/Sent Mail" . ?s)
                            ("/All Mail"  . ?a)
                            ("/Trash"     . ?t))
   mu4e-bookmarks `(("maildir:/Inbox" "Inbox" ?i)
                    ("maildir:/Drafts" "Drafts" ?d)
                    ("flag:unread AND maildir:/Inbox" "Unread messages" ?u)
                    ("flag:flagged" "Starred messages" ?s)
                    ("date:today..now" "Today's messages" ?t)
                    ("date:7d..now" "Last 7 days" ?w)
                    ("mime:image/*" "Messages with images" ?p))
   mu4e-use-fancy-chars t
   mu4e-headers-has-child-prefix '("+" . "◼")
   mu4e-headers-empty-parent-prefix '("-" ."◽")
   mu4e-headers-first-child-prefix '("\\" . "↳")
   mu4e-headers-duplicate-prefix '("=" . "⚌")
   mu4e-headers-default-prefix '("|" . "┃")
   mu4e-headers-draft-mark '("D" . "📝 ")
   mu4e-headers-flagged-mark '("F" . "🏴 ")
   mu4e-headers-new-mark '("N" . "★ ")
   mu4e-headers-passed-mark '("P" . "→ ")
   mu4e-headers-replied-mark '("R" . "← ")
   mu4e-headers-seen-mark '("S" . "✓ ")
   mu4e-headers-trashed-mark '("T" . "✗ ")
   mu4e-headers-attach-mark '("a" . "📎 ")
   mu4e-headers-encrypted-mark '("x" . "🔐 ")
   mu4e-headers-signed-mark '("s" . "🔏 ")
   mu4e-headers-unread-mark '("u" . "✉ ")))

(after! mu4e
  (fset 'my-move-to-trash "mt")
  (define-key mu4e-headers-mode-map (kbd "d") 'my-move-to-trash)
  (define-key mu4e-view-mode-map (kbd "d") 'my-move-to-trash)

  (define-key mu4e-headers-mode-map (kbd "D") 'my-move-to-trash)
  (define-key mu4e-view-mode-map (kbd "D") 'my-move-to-trash))

;;; +misc.el -*- lexical-binding: t; -*-

(defun gpt-replace-text-after-yank (&rest args)
  "Perform multiple replacements on pasted text using regex."
  (let* ((start (mark t))
         (end (point))
         (replacements '(("&nbsp;" . " ")
                         ("^```.*$" . "\n\n")
                         ))) ; Add more regex and replacement pairs if needed
    (save-excursion
      (dolist (pair replacements)
        (goto-char start)
        (while (re-search-forward (car pair) end t)
          (replace-match (cdr pair) t nil))))))

(advice-add 'yank :after #'gpt-replace-text-after-yank)
(advice-add 'evil-paste-after :after #'gpt-replace-text-after-yank)

(defun doom/reload()
  "Call the doom-sync.sh script to reload Doom."
  (interactive)
  (shell-command "~/.bin/doom-sync.sh"))

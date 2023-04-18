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


(defun query-gpt-chat()
  "Run script command with selected text or current line content and insert output in buffer"
  (interactive)
  (let* ((selected-text (if (region-active-p)
                            (buffer-substring-no-properties (region-beginning) (region-end))
                          nil))
         (current-line (if selected-text
                            (replace-regexp-in-string "\n" "POOR_GPT_SEP" selected-text)
                          (thing-at-point 'line t)))
         (output    (shell-command-to-string (concat "wgpt " "`" current-line "`"))))
    (beginning-of-line)
    (insert "GPT>>> ")
    (end-of-line)
    (insert "\n\n")
    (insert (mapconcat 'identity (nthcdr 5 (seq-filter (lambda (line) (not (string-suffix-p "Copy code" line))) (split-string output "\n"))) "\n"))

    (insert "\n<<<GPT\n")))

(global-set-key (kbd "C-:") 'query-gpt-chat)


(defun query-claude-chat()
  "Run script command with selected text or current line content and insert output in buffer"
  (interactive)
  (let* ((selected-text (if (region-active-p)
                            (buffer-substring-no-properties (region-beginning) (region-end))
                          nil))
         (current-line (if selected-text
                            (replace-regexp-in-string "\n" "POOR_GPT_SEP" selected-text)
                          (thing-at-point 'line t)))
         (output
                     (shell-command-to-string (concat "claude " "`" current-line "`"))


                   ))
    (beginning-of-line)
    (insert "GPT>>> ")
    (end-of-line)
    (insert "\n\n")
    (if (not (string= output ""))
    (insert (mapconcat 'identity (nthcdr 5 (seq-filter (lambda (line) (not (string-suffix-p "Copy code" line))) (split-string output "\n"))) "\n"))
    (insert "\n<<<GPT\n")
    )


    ))

(global-set-key (kbd "C-;") 'query-claude-chat)


GPT>>>

GPT>>>

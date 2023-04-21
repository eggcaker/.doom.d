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

;;(advice-add 'yank :after #'gpt-replace-text-after-yank)
;;(advice-add 'evil-paste-after :after #'gpt-replace-text-after-yank)

(defun doom/reload()
  "Call the doom-sync.sh script to reload Doom."
  (interactive)
  (shell-command "~/.bin/doom-sync.sh"))

(defun generate-gpt-prefix ()
     """Generate a prefix for the GPT prompt."""
     (if (< (length (thing-at-point 'lint t )) 2)
         ""
       "GTP>>> " ))

(defun generate-gpt-subfix ()
     """Generate a subfix for the GPT prompt."""
     "\n<<<GPT"
)


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
    (insert (generate-gpt-prefix))
    (end-of-line)
    (insert "\n\n")
    (insert (mapconcat 'identity (nthcdr 5 (seq-filter (lambda (line) (not (string-suffix-p "Copy code" line))) (split-string output "\n"))) "\n"))

    (insert "\n<<<GPT\n")))

(global-set-key (kbd "C-:") 'query-gpt-chat)


(defun query-claude-chat()
  "Run script command with selected text or current line content and insert output in buffer"
  (interactive)
  (let* ((selected-text (when (region-active-p)
                            (buffer-substring-no-properties (region-beginning) (region-end))))
         (current-line (if selected-text
                            (replace-regexp-in-string "\n" "POOR_GPT_SEP" selected-text)
                          (thing-at-point 'line t)))
         (output (shell-command-to-string (concat "claude " " " current-line ))))
    (beginning-of-line)
    (insert "GPT>>> ")
    (end-of-line)
    (insert "\n\n")
    (if (not (string= output ""))
    (insert (mapconcat 'identity (nthcdr 5 (seq-filter (lambda (line) (not (string-suffix-p "Copy code" line))) (split-string output "\n"))) "\n"))
    (insert "\n<<<GPT\n"))))

(global-set-key (kbd "C-M-;") 'query-claude-chat)

(defun format-azure-output (output)
  "Format the output of the azure script."
  (let ((formatted-output output)
        (replacements '(("\n" . "")
                        ("\n" . "")
                        ("[[:space:]]+$" . "")
                        (" +" . ""))))
    ;; Remove unwanted characters
    (dolist (replacement replacements)
      (setq formatted-output (replace-regexp-in-string (car replacement) (cdr replacement) formatted-output)))

    ;; Replace more than 2 newlines with 2 newlines
    (while (string-match "\n\n\n+" formatted-output)
      (setq formatted-output (replace-match "\n\n" t t formatted-output)))

    formatted-output))

(defun query-azure-chat()
  "Run script command with selected text or current line content and insert output in buffer"
  (interactive)
  (let* ((selected-text (when (region-active-p)
                            (buffer-substring-no-properties (region-beginning) (region-end))))
         (current-line (if selected-text
                            (replace-regexp-in-string "\n" "POOR_GPT_SEP" selected-text)
                          (thing-at-point 'line t)))
         (output  (shell-command-to-string (concat "azure" " " (base64-encode-string (string-as-unibyte current-line) t)  ))))
    (beginning-of-line)
    (insert (generate-gpt-prefix))
    (end-of-line)
    (if (not (string= output ""))
    (insert (mapconcat 'identity (nthcdr 5 (seq-filter (lambda (line) (not (string-suffix-p "Copy code" line))) (split-string (format-azure-output output) "\n"))) "\n"))
    (insert (generate-gpt-subfix)))))


(global-set-key (kbd "C-;") 'query-azure-chat)



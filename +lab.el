;;; +lab.el -*- lexical-binding: t; -*-


(setq org-agenda-files (list "~/MyNotes"))

(setq org-agenda-prefix-format
      '((agenda . " %i %-12(vulpea-agenda-category 12)%?-12t% s")
        (todo . " %i %-12(vulpea-agenda-category 12) ")
        (tags . " %i %-12(vulpea-agenda-category 12 ) ")
        (search . " %i %-12(vulpea-agenda-category 12) ")))

(defun vulpea-agenda-category (&optional len)
  "Get category of item at point for agenda.
Category is defined by one of the following items:

- CATEGORY property
- TITLE keyword
- TITLE property
- filename without directory and extension

Usage example:
  (setq org-agenda-prefix-format
        '((agenda . \" %(vulpea-agenda-category) %?-12t %12s\")))

Refer to `org-agenda-prefix-format' for more information."

  (let* ((file-name (when buffer-file-name
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name))))
         (title (vulpea-buffer-prop-get "title"))
         (category (org-get-category))
         (result
          (or (if (and
                   title
                   (string-equal category file-name))
                  title
                category)
              "")))
    (if (numberp len)
        (s-truncate len (s-pad-right len " " result))
            result)))

(defun vulpea-buffer-prop-get (name)
      "Get a buffer property called NAME as a string."
      (org-with-point-at 1
        (when (re-search-forward (concat "^#\\+" name ": \\(.*\\)")
                                 (point-max) t)
          (buffer-substring-no-properties
           (match-beginning 1)
                  (match-end 1)))))



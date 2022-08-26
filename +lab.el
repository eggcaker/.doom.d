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


(defun vulpea-ensure-filetag ()
      "Add respective file tag if it's missing in the current note."
      (interactive)
      (let ((tags (vulpea-buffer-tags-get))
            (tag (vulpea--title-as-tag)))
        (when (and (seq-contains-p tags "people")
                   (not (seq-contains-p tags tag)))
          (vulpea-buffer-tags-add tag))))

(defun vulpea--title-as-tag ()
  "Return title of the current note as tag."
  (vulpea--title-to-tag (vulpea-buffer-title-get)))

(defun vulpea--title-to-tag (title)
  "Convert TITLE to tag."
    (concat "@" (s-replace " " "" title)))


(defun vulpea-tags-add ()
  "Add a tag to current note."
  (interactive)
  ;; since https://github.com/org-roam/org-roam/pull/1515
  ;;   ;; `org-roam-tag-add' returns added tag, we could avoid reading tags
  ;;     ;; in `vulpea-ensure-filetag', but this way it can be used in
  ;;       ;; different contexts while having simple implementation.
  (when (call-interactively #'org-roam-tag-add)
    (vulpea-ensure-filetag)))


(defun dw/org-path (path)
    (expand-file-name path org-directory))


(defun org-roam-node-insert-wrapper (fn)
        "Insert a link to the note using FN.

If inserted node has PEOPLE tag on it, tag the current outline
accordingly."
        (interactive)
        (when-let*
            ((node (funcall fn))
             (title (org-roam-node-title node))
             (tags (org-roam-node-tags node)))
          (when (seq-contains-p tags "people")
            (save-excursion
              (ignore-errors
                (org-back-to-heading)
                (org-set-tags
                 (seq-uniq
                  (cons
                   (vulpea--title-to-tag title)
                   (org-get-tags nil t)))))))))

(advice-add
 #'org-roam-node-insert
 :around
  #'org-roam-node-insert-wrapper)



(setq org-agenda-custom-commands
          `(("d" "Dashboard"
             ((agenda "" ((org-deadline-warning-days 7)))
              (tags-todo "+PRIORITY=\"A\""
                         ((org-agenda-overriding-header "High Priority")))
              (tags-todo "+followup" ((org-agenda-overriding-header "Needs Follow Up")))
              (todo "NEXT"
                    ((org-agenda-overriding-header "Next Actions")
                     (org-agenda-max-todos nil)))
              (todo "TODO"
                    ((org-agenda-overriding-header "Unprocessed Inbox Tasks")
                     (org-agenda-files '(,(dw/org-path "Inbox.org")))
                     (org-agenda-text-search-extra-files nil)))))

            ("n" "Next Tasks"
             ((agenda "" ((org-deadline-warning-days 7)))
              (todo "NEXT"
                    ((org-agenda-overriding-header "Next Tasks")))))

            ;; Low-effort next actions
            ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
             ((org-agenda-overriding-header "Low Effort Tasks")
              (org-agenda-max-todos 20)
              (org-agenda-files org-agenda-files)))))



(setq org-roam-dailies-capture-templates '(("d" "default" entry "* %<%I:%M %p>: %?"
                                            :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

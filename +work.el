;;; +work.el -*- lexical-binding: t; -*-

(setq-default xiaoice-project-root "~/src/Xiaobing/private/src/Workflow.Scripts")

(defun counsel-partner-workflow-list ()
  (split-string (shell-command-to-string "cat /mnt/d/Work/Cloud/Scripts/partner/configtest/OpenApi/WorkflowMapping.ini") "\n" t))

(defun counsel-partner-workflow-action-default(workflow)
  (let ((w  (car (last (split-string (car (last (split-string workflow "\t" t))) ":" t)))))
    (find-file (concat xiaoice-project-root "/workflowint/" w ".workflow.xml"))))

(defun counsel-workflow (&optional arg)
  "Open a worfflow file. When ARG is non-nil, ignore NoDisplay property in *.desktop files."
  (interactive "P")
  (ivy-read "Open a .workflow.xml: " (counsel-partner-workflow-list)
            :action #'counsel-partner-workflow-action-default
            :caller 'counsel-workflow))

(defun my-function ()
 (interactive)
  (if (equal current-prefix-arg nil) ; no C-u
   ;; then
    (message "my-function was called normally")
   ;; else
    (message "my-function was called with C-u")))

(setq-default py-files '("scriptint" "scripttest" "script"))
(setq-default xml-files '("workflowint" "workflowtest" "workflow"))

(defun cc/push-workflow-file()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name)
        (async-shell-command (concat "w.push " file-name)))))

(defun cc/pull-workflow-file()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name)
        (async-shell-command (concat "w.pull " file-name)))))


(defun cc/swith-workflow-file ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name )
        (progn
          (setq case-fold-search nil)
          (setq env (car (--> (s-match-strings-all "scriptint\\|scripttest\\|script" file-name) (-flatten-n 1 it)  )))
          (message env)
          (message file-name)
          (delete-other-windows)
          (cond
           ((and (s-ends-with? ".py" file-name ) (string-match-p "scriptint\\|scripttest\\|script" file-name))
           (let ((right-file-name (s-replace env (-> env (-elem-index py-files) (+ 1) (mod 3) (nth py-files)) file-name)  ))
              (message right-file-name)
              (if (file-exists-p right-file-name)
                  (find-file-other-window right-file-name)
                (copy-file file-name right-file-name)
                (find-file-other-window right-file-name))))

           ((and (s-ends-with? "workflow.xml" file-name ) (s-contains? "workflowint" file-name))
            (let ((workflow-item-name (s-trim (buffer-substring (line-beginning-position) (line-end-position)))))
              (cond
               ((s-contains? "<Service>" workflow-item-name)
                (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                          (s-concat (s-chop-suffix "</Service>" (s-chop-prefix "<Service>" workflow-item-name)) ".py"))))

               ((s-contains? "<PostAction>" workflow-item-name)
                (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                           (s-concat (s-chop-suffix "</PostAction>" (s-chop-prefix "<PostAction>" workflow-item-name)) ".py"))))

               )))

           ((and (s-ends-with? "service.xml" file-name ) (s-contains? "workflowint" file-name))
            (let ((workflow-item-name (s-trim (buffer-substring (line-beginning-position) (line-end-position)))))
              (cond
               ((s-contains? "<Service>" workflow-item-name)
                (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                          (s-concat (s-chop-suffix "</Service>" (s-chop-prefix "<Service>" workflow-item-name)) ".py"))))

               ((s-contains? "<PostAction>" workflow-item-name)
                (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                           (s-concat (s-chop-suffix "</PostAction>" (s-chop-prefix "<PostAction>" workflow-item-name)) ".py"))))

               )))


           )))))

(require 's)

(map! (:when (s-contains? "Workflow.Scripts" (buffer-file-name))
       :map (xml-mode python-mode)
       :leader
       :desc "Swith project workflow files."
       "m g" #'cc/swith-workflow-file))

(map! (:when (s-contains? "Workflow.Scripts" (buffer-file-name))
       :map (xml-mode python-mode)
       :leader
       :desc "Open a project int workflow file"
       "f w" #'counsel-workflow))


(map! ;;(:when (s-contains? "Workflow.Scripts" (buffer-file-name))
       :map (xml-mode python-mode)
       :leader
       :desc "Push local file to azure."
       "m p" #'cc/push-workflow-file)

(map! ;;(:when (s-contains? "Workflow.Scripts" (buffer-file-name))
        :map (xml-mode python-mode)
       :leader
       :desc "Pull a file from azure."
       "m f" #'cc/pull-workflow-file)

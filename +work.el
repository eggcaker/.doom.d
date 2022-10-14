;;; +work.el -*- lexical-binding: t; -*-

(setq-default xiaoice-project-root "~/src/Xiaobing/private/src/Workflow.Scripts")

(defun counsel-partner-workflow-list ()
  (split-string (shell-command-to-string "cat /mnt/d/Work/Cloud/Scripts/partner/configtest/OpenApi/WorkflowMapping.ini") "\n" t))

(defun cc/open-workflow-file(workflow)
  (let ((w  (car (last (split-string (car (last (split-string (s-replace "\r" "" workflow) "\t" t))) ":" t)))))
    (find-file (concat xiaoice-project-root "/workflowint/" w ".workflow.xml"))))

(defun consult-workflow ()
  "Open a workflow file"
  (interactive)
  (cc/open-workflow-file
   (consult--read (counsel-partner-workflow-list))))

(setq-default py-files '("scriptint" "scripttest" "script"))
(setq-default xml-files '("workflowint" "workflowtest" "workflow"))

(defun kill-async-command-buffer()
  (interactive)
  (kill-matching-buffers "*Async Shell Command*" nil t))

(defun cc/push-workflow-file()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name)
        (progn (async-shell-command (concat "w.push " file-name))
      (run-at-time 3 nil  #'kill-async-command-buffer)))))

(defun cc/pull-workflow-file()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name)
        (progn
          (async-shell-command (concat "w.pull " file-name))
          (run-at-time 3 nil  #'kill-async-command-buffer)))))


(defun cc/swith-workflow-file ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (s-contains? "Workflow.Scripts" file-name )
        (progn
          (setq case-fold-search nil)
          (setq env (car (--> (s-match-strings-all "scriptint\\|scripttest\\|script" file-name) (-flatten-n 1 it)  )))
          (delete-other-windows)
          (cond
           ((and (s-ends-with? ".py" file-name ) (string-match-p "scriptint\\|scripttest\\|script" file-name))
           (let ((right-file-name (s-replace env (-> env (-elem-index py-files) (+ 1) (mod 3) (nth py-files)) file-name)  ))
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
                (progn
                  (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                                                  (s-concat (s-chop-suffix "</PostAction>" (s-chop-prefix "<PostAction>" workflow-item-name)) ".py")))
                  (beginning-of-buffer)
                  (search-forward "def PostRun")
                  ))

               )))

           ((and (s-ends-with? "service.xml" file-name ) (s-contains? "workflowint" file-name))
            (let ((workflow-item-name (s-trim (buffer-substring (line-beginning-position) (line-end-position)))))
              (cond
               ((s-contains? "<Service>" workflow-item-name)
                (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                          (s-concat (s-chop-suffix "</Service>" (s-chop-prefix "<Service>" workflow-item-name)) ".py"))))

               ((s-contains? "<PostAction>" workflow-item-name)
                (progn
                  (find-file-other-window (s-concat (s-replace "workflowint" "scriptint" (f-dirname file-name )) "/"
                                                  (s-concat (s-chop-suffix "</PostAction>" (s-chop-prefix "<PostAction>" workflow-item-name)) ".py")))
                  (beginning-of-buffer)
                  (search-forward "def PostRun")
                  ))
               )))


           )))))


(defun get-character-by-id(pid)
  (interactive)
  (let* ((json-object-type 'hash-table)
         (json-array-type 'list)
         (json-key-type 'string)
         (json (json-read-file partner-json-file)))
    (gethash "Character" (gethash pid json))))


(setq partner-json-file
      (cond (
             (string= system-type "windows-nt") "d:/Work/Cloud/Tools/Postman/Partners.json")
            (t "/home/eggcaker/.bin/Partners.json")))

(defun create-xiaoice-api-test()
  (interactive)
  (let ((workflow (consult--read (counsel-partner-workflow-list))))
    (let (
          (w  (car (last (split-string (car (last (split-string (s-replace "\r" "" workflow) "\t" t))) ":" t))))
          (pid (car (split-string (s-replace "\r" "" workflow) "\t" t)))
          (query (read-string "Type Query: " "你叫什么名字?")))

      (create-file-buffer (concat "demo-xiaoice-api-" pid))
      (switch-to-buffer (concat "demo-xiaoice-api-" pid))
      (restclient-mode)
      (erase-buffer)
      (insert (format "# xiaoice core api call for for partner %s with workflow %s\n" pid w ) )
      (insert ":random_id := (org-id-uuid)\n")
      (insert "\n")
      (insert (format "POST http://prod-xiaoicecore-commercialppe.trafficmanager.cn/api/chitchat/reply?workflow=%s\n" w))
      (insert "Content-Type: application/json\n")
      (insert "\n")
      (insert "{\n")
      (insert "  \"MasterPuid\": \":random_id\",\n")
      (insert "  \"SenderPuid\": \":random_id\",\n")
      (insert "  \"MasterUuid\": \":random_id\",\n")
      (insert "  \"SenderUuid\": \":random_id\",\n")
      (insert "  \"Content\": {\n")
      (insert (concat "    \"Text\": \"" query "\",\n"))
      (insert "    \"Metadata\": {\n")
      (insert (concat "      \"Character\": \"" (get-character-by-id pid) "\"\n"))
      (insert "    },\n")
      (insert "    \"ContentType\": 1\n")
      (insert "  },\n")
      (insert "  \"PartnerInfo\": {\n")
      (insert (format "    \"PartnerId\": %s ,\n" pid))
      (insert (format "    \"PartnerName\": \"TEST-PARTNER-%s\"\n" pid))
      (insert "  }\n")
      (insert "}\n")

      (restclient-http-send-current nil t)
      (goto-line 13)
      (move-to-column 13 )
      (evil-visual-char)
      )))


(map! :leader "os" 'create-xiaoice-api-test)


(map! ;; (:when (s-contains? "Workflow.Scripts" (buffer-file-name))
       :map (xml-mode python-mode)
       :leader
       :desc "Swith project workflow files."
       "m g" #'cc/swith-workflow-file)

(map! ;;(:when (s-contains? "Workflow.Scripts" (buffer-file-name))
       :map (xml-mode python-mode)
       :leader
       :desc "Open a project int workflow file"
       "f w" #'consult-workflow)


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

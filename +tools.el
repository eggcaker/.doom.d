;;; +tools.el -*- lexical-binding: t; -*-


(use-package! verb
  :after org
  :init
  (setq verb-auto-kill-response-buffers t)
  (setq verb-json-use-mode 'json-mode)
  :config
)

(use-package! ob-verb
  :ensure verb
  :after ob-core
  :commands
  org-babel-execute:verb)

(map! (:map org-mode-map
       :localleader
       :desc "Send Request Only" :n "vs" #'verb-send-request-on-point-other-window-stay
       :desc "Send and Jump Focus" :n "vS" #'verb-send-request-on-point-other-window
       :desc "Send from Here.." :n "vf" #'verb-send-request-on-point
       :desc "Send and hide window" :n "vm" #'verb-send-request-on-point-no-window
       :desc "Kill all response buffers" :n "vk" #'verb-kill-all-response-buffers
       :desc "Export request to format" :n "ve" #'verb-export-request-on-point
       :desc "Export req to curl format" :n "vu" #'verb-export-request-on-point-curl
       :desc "Export req to verb format" :n "vb" #'verb-export-request-on-point-verb
       :desc "Verb set var " :n "vv" #'verb-set-var
       :desc "Verb set var " :n "vl" #'verb-show-vars))
(map!
      (:map verb-response-body-mode-map
       :localleader
       :desc "Resend Request" :n "s" #'verb-re-send-request
       :desc "Kill Response buffer and window" :n "k" #'verb-kill-response-buffer-and-window
       :desc "Toggle headers" :n "t" #'verb-toggle-show-headers))

(map!
      (:map verb-response-headers-mode-map
       :localleader
       :desc "Kill buffer and window" :n "q" #'verb-kill-buffer-and-window))




;; accept completion from copilot and fallback to company
;; (defun my-tab ()
;;   (interactive)
;;   (or (copilot-accept-completion)
;;       (company-indent-or-complete-common nil)))

;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (("C-TAB" . 'copilot-accept-completion-by-word)
;;          ("C-<tab>" . 'copilot-accept-completion-by-word)
;;          ("M-]" . 'copilot-next-completion)
;;          ("M-[" . 'copilot-previous-completion)
;;          :map company-active-map
;;          ("<tab>" . 'my-tab)
;;          ("TAB" . 'my-tab)
;;          :map company-mode-map
;;          ("<tab>" . 'my-tab)
;;          ("TAB" . 'my-tab)))



(use-package! nushell-mode
  :mode "\\.nu"
  :ensure t
  )

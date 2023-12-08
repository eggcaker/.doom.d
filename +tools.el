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
(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         ("M-]" . 'copilot-next-completion)
         ("M-[" . 'copilot-previous-completion)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         ("C-TAB" . 'copilot-accept-completion-by-word)
         ("M-]" . 'copilot-next-completion)
         ("M-[" . 'copilot-previous-completion)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))



(use-package! nushell-mode
  :mode "\\.nu"
  :ensure t
  )

(use-package! just-mode
  :ensure t
  )



(after! dockerfile-mode
  (set-docsets! 'dockerfile-mode "Docker")

  (when (modulep! +lsp)
    (add-hook 'dockerfile-mode-local-vars-hook #'lsp! 'append)))


(use-package! chatgpt
  :defer t
  :config
  (unless (boundp 'python-interpreter)
    (defvaralias 'python-interpreter 'python-shell-interpreter))
  (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
  (set-popup-rule! (regexp-quote "*ChatGPT*")
    :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
  :bind ("C-c q" . chatgpt-query))

(use-package! pyim
  :defer t
  :init
  (setq pyim-title "R")
  (setq pyim-english-input-switch-functions
        '(pyim-probe-auto-english
          pyim-probe-evil-normal-mode
          pyim-probe-isearch-mode
          pyim-probe-org-speed-commands
          pyim-probe-org-structure-template
          pyim-probe-program-mode

          ))
  :config
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'wubi))

(use-package! pyim-wbdict
  :after pyim
  :config
  (pyim-wbdict-v86-enable)
  (message "get ininto pyim-wbdict"))

;; (require 'pyim-wbdict)
;; (pyim-wbdict-v86-enable)

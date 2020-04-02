;;; input/chinese/config.el -*- lexical-binding: t; -*-
;;;

(defvar +my-ext-dir (expand-file-name "~/.doom.d/extensions"))

(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english pyim-probe-isearch-mode pyim-probe-program-mode pyim-probe-org-structure-template))
(setq-default pyim-punctuation-half-width-functions '(pyim-probe-punctuation-line-beginning pyim-probe-punctuation-after-punctuation))


(use-package! pyim
  :demand t
  :defer 1
  :diminish pyim-isearch-mode
  :init
  (setq default-input-method "pyim"
        pyim-title "ㄓ"
        pyim-default-scheme 'rime
        pyim-page-length 7
        pyim-page-tooltip 'popup) ;;proframe)

  :config
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-evil-normal-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation)))

(use-package! liberime
  :when (featurep! +rime)
  :load-path (lambda()(expand-file-name "liberime" +my-ext-dir))
  :defer 1
  :custom
  (rime_share_data_dir "/Library/Input Methods/Squirrel.app/Contents/SharedSupport/")
  (rime_user_data_dir (expand-file-name "rime" +my-ext-dir))
  :init
  (module-load (expand-file-name "liberime.so" +my-ext-dir))
  :config
  (liberime-start rime_share_data_dir rime_user_data_dir)
  (liberime-select-schema "luna_pinyin_simp"))

(use-package! pangu-spacing
  :hook (text-mode . pangu-spacing-mode)
  :config
  ;; Always insert `real' space in org-mode.
  (setq-hook! 'org-mode-hook pangu-spacing-real-insert-separtor t))

(use-package! fcitx
  :after evil
  :config
  (when (executable-find "fcitx-remote")
    (fcitx-evil-turn-on)))

(use-package! ace-pinyin
  :after avy
  :init (setq ace-pinyin-use-avy t)
  :config (ace-pinyin-global-mode t))


;;
;;; Hacks

(defun +chinese*org-html-paragraph (paragraph contents info)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  (let* ((fix-regexp "[[:multibyte:]]")
         (origin-contents contents)
         (fixed-contents
          (replace-regexp-in-string
           (concat "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)")
           "\\1\\2"
           origin-contents)))
    (list paragraph fixed-contents info)))
;; (advice-add #'org-html-paragraph :filter-args #'+chinese*org-html-paragraph)

;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

;; theme
(setq doom-theme 'doom-dark+) ;;'doom-palenight)

(setq doom-font (font-spec :family "Fira Code Retina" :size 26 :weight 'normal :width 'normal)
      doom-variable-pitch-font (font-spec :family "Fira Code Retina" :size 26 :weight 'normal :width 'normal)
      doom-big-font (font-spec :family "Fira Code Retina" :size 40))

(defun set-chinese-font()
  (interactive)
  (if (not (boundp 'writeroom-mode))
      (setq writeroom-mode nil))
 (dolist (charset '(kana han cjk-misc bopomofo)) ;; TODO symbol not included
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name  "-*-STKaiti-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
                :weight 'normal
                :slant 'normal
                :size (cond
                            ((and doom-big-font-mode writeroom-mode) 72)
                            (doom-big-font-mode 50)
                            (writeroom-mode  46)
                            (t 32))))))

(boundp 'writeroom-mode)
(defadvice! add-my-font-config (&rest _)
  :after #'unicode-fonts--setup-1
  (set-chinese-font))

(add-hook! 'doom-big-font-mode-hook (set-chinese-font))
(add-hook! 'writeroom-mode-hook (set-chinese-font))

;; line spacing
(setq display-line-numbers-type nil)
(setq-default line-spacing 4)

;; doom-modeline
(setq doom-modeline-major-mode-icon t)

;; start frame size
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; dashboard custom
(defun banner-line(msg)
 (insert
   (propertize
    (+doom-dashboard--center
     +doom-dashboard--width
     msg)
    'face 'doom-dashboard-menu-title)
   "\n"))


(defun my-dashboard-banner()
  (banner-line "平生不修善果，")
  (banner-line "只愛殺人放火。")
  (banner-line "忽地頓開金繩，")
  (banner-line "這裏扯斷玉鎖。")
  (banner-line "   咦！錢塘江上潮信來，")
  (banner-line "  今日方知我是我。")
  (banner-line "  ")
  (banner-line "              ---魯智深"))

(setq +doom-dashboard-functions
      '(
        my-dashboard-banner
        doom-dashboard-widget-loaded
        ))

(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))


(doom/set-frame-opacity 96)


;; (setq initial-frame-alist '((top . 1) (left . 1) (width . 120) (height . 55)))

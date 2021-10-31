;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

;; theme
(setq doom-theme 'doom-vibrant)

(setq doom-font (font-spec :family "MesloLGM NF" :size 26 :weight 'normal :width 'normal)
      doom-variable-pitch-font (font-spec :family "MesloLGM NF" :size 26 :weight 'normal :width 'normal)
      doom-big-font (font-spec :family "MesloLGM NF" :size 40))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
   (set-fontset-font
    (frame-parameter nil 'font)
    charset
    (font-spec :name "-*-STFangsong-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
               :weight 'normal
               :slant 'normal
               :size 32)))

;; line spacing
(setq display-line-numbers-type nil)
(setq-default line-spacing 4)

;; start frame size
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; dashboard custom
(defun banner-line(msg)
 (insert
   (propertize
    (+doom-dashboard--center
     +doom-dashboard--width
     msg
     )
    'face 'doom-dashboard-menu-title)
   "\n"
   )
 )


(defun my-dashboard-banner()
  (banner-line "平生不修善果，")
  (banner-line "只愛殺人放火。")
  (banner-line "忽地頓開金繩，")
  (banner-line "這裏扯斷玉鎖。")
  (banner-line "   咦！錢塘江上潮信來，")
  (banner-line "  今日方知我是我。")
  ;;(banner-line "         ---魯智深")
   )

(setq +doom-dashboard-functions
      '(
        my-dashboard-banner
        doom-dashboard-widget-loaded
        ))

(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))


(doom/set-frame-opacity 93)

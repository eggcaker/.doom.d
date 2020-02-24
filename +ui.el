;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

;; theme
(setq doom-theme 'doom-vibrant)

;; fonts
;; (setq doom-font (font-spec :family "Iosevka Term Medium" :size 18))
;; (setq doom-variable-pitch-font (font-spec :family "Noto Sans" :weight 'semi-bold :width 'extra-condensed))
;; (setq doom-serif-font (font-spec :family "Noto Serif" :weight 'semi-bold :width 'extra-condensed))

(set-face-attribute
 'default nil
 :font (font-spec :name "-*-Fantasque Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 20.0))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-*-STFangsong-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 19.6)))

(setq ispell-program-name "/usr/local/bin/ispell")

;; line spacing
(setq display-line-numbers-type nil)
(setq line-spacing 4)

;; start frame size
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; dashboard custom
(setq +doom-dashboard-functions
      '(
        doom-dashboard-widget-banner
        doom-dashboard-widget-loaded
        doom-dashboard-widget-footer))

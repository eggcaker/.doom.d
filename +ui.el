;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

;; theme
(setq doom-theme 'doom-vibrant)


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
(setq line-spacing 6)

;; start frame size
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; dashboard custom
(defun my-dashboard-banner()
  (insert
   (propertize
    (+doom-dashboard--center
     200 ;;+doom-dashboard--width
     (concat
      "\n- 酒喝的不少了，差不多得了"
      "\n- 不是你的圈子不要厚着脸皮闯，你牛B了你就是圈子"
      "\n- 身体是你唯一赚钱的本钱，身体发肤受之父母，要珍惜"
      "\n- 不要把尖酸刻薄当成幽默，好话三冬暖才是高情商的表现"
      "\n\n\n"
      ))
    'face 'doom-dashboard-menu-title)
   ))


(setq +doom-dashboard-functions
      '(
        my-dashboard-banner
        doom-dashboard-widget-loaded
        ))

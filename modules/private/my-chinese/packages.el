;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el


(when (featurep! +rime)
    (package! liberime-config :ignore t))


(package! pyim)
(package! fcitx)
(package! ace-pinyin)
(package! pangu-spacing)
(package! posframe :recipe (:host github :repo "tumashu/posframe"))

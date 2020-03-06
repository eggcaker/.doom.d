;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el


(when (featurep! +rime)
    (package! liberime-config :ignore t))


(package! pyim :pin "bbeb68605e")
(package! fcitx :pin "12dc2638dd")
(package! ace-pinyin :pin "8b2e9335b0")
(package! pangu-spacing :pin "f92898949b")
(package! posframe :recipe (:host github :repo "tumashu/posframe"))
;; (package! pyim)
;; (package! fcitx)
;; (package! ace-pinyin)
;; (package! pangu-spacing)

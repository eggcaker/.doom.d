;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el


(package! org-super-agenda)
(package! org-starter)
;;(package! org-wild-notifier)
(package! org-books :recipe (:host github :repo "lepisma/org-books"))
(package! notdeft :recipe (:host github :repo "eggcaker/notdeft"))
(package! anki-editor)
(disable-packages! evil-snipe)
(package! org-protocol-capture-html :recipe (:host github :repo "alphapapa/org-protocol-capture-html"))

(package! ox-novel :recipe (:host github :repo "eggcaker/ox-novel"))
(package! latex-pretty-symbol :recipe (:host github :repo "epa095/latex-pretty-symbols.el"))

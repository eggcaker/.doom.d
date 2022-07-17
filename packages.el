;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el


(package! org-super-agenda)
(package! org-starter)
;;(package! org-wild-notifier)
(package! org-books :recipe (:host github :repo "lepisma/org-books"))
;;(package! notdeft :recipe (:host github :repo "eggcaker/notdeft"))
(package! anki-editor)
(disable-packages! evil-snipe)
(package! org-protocol-capture-html :recipe (:host github :repo "alphapapa/org-protocol-capture-html"))

;; (package! ox-novel :recipe (:host github :repo "eggcaker/ox-novel"))
(package! latex-pretty-symbol :recipe (:host github :repo "epa095/latex-pretty-symbols.el"))
(package! org-fragtog :recipe (:host github :repo "io12/org-fragtog"))
(package! tiny :recipe (:host github :repo "abo-abo/tiny"))

(package! weblorg :recipe (:host github :repo "emacs-love/weblorg"))

;; (package! slack :recipe (:host github :repo "eggcaker/emacs-slack"))
(package! helm-slack :recipe (:host github :repo "yuya373/helm-slack"))

(package! kubernetes)
(package! kubernetes-evil)
(package! k8s-mode)
(unpin! org-roam)
(package! org-bullets :recipe (:host github :repo "sabof/org-bullets"))
(package! org-roam-ui)

(package! verb :recipe (:host github :repo "federicotdn/verb"))

;; (package! nu-mode :recipe (:host github :repo "eggcaker/nu-mode"))

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))


(package! vulpea :recipe (:host github :repo "d12frosted/vulpea"))

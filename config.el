;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "eggcaker"
      user-mail-address "eggcaker@gmail.com")

;; Modules
(load! "+defaults")
(load! "+bindings")
(load! "+ui")
(load! "+git")
(load! "+mail")
(load! "+org")
(load! "+anki")
(load! "+chat")

(after! pyim
  (setq pyim-page-tooltip 'posframe)

  (setq-default pyim-english-input-switch-functions
                '(
                  pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  (map! :gnvime
        "M-l" #'pyim-convert-string-at-point))

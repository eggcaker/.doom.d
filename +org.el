;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-

(after! org
  (setq org-directory "~/.org-files/")
  (setq org-crypt-tag-matcher "secret")
  (setq org-tags-exclude-from-inheritance (quote ("secret")))
  (setq org-crypt-key "CF0B552FF"))

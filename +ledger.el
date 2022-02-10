;;; +ledger.el -*- lexical-binding: t; -*-
(use-package! hledger-mode
  :mode ("\\.journal" "\\.hledger" "\\.ledger")
  :commands hledger-enable-reporting
  :preface

  (defun center-text-for-reading (&optional arg)
    "Setup margins for reading long texts.
If ARG is supplied, reset margins and fringes to zero."
    (interactive "P")
    ;; Set the margin width to zero first so that the whole window is
    ;; available for text area.
    (set-window-margins (selected-window) 0)
    (let* ((max-text-width (save-excursion
                             (let ((w 0))
                               (goto-char (point-min))
                               (while (not (eobp))
                                 (end-of-line)
                                 (setq w (max w (current-column)))
                                 (forward-line))
                               w)))
           (margin-width (if arg
                             0
                           (/ (max (- (frame-width) max-text-width) 0) 3))))
      (setq left-margin-width margin-width)
      (setq right-margin-width margin-width)
      ;; `set-window-margings' does a similar thing but those changes do
      ;; not persist across buffer switches.
      (set-window-buffer nil (current-buffer))))


  (defun hledger/next-entry ()
    "Move to next entry and pulse."
    (interactive)
    (hledger-next-or-new-entry)
    (hledger-pulse-momentary-current-entry))
  (defface hledger-warning-face
    '((((background dark))
       :background "Red" :foreground "White")
      (((background light))
       :background "Red" :foreground "White")
      (t :inverse-video t))
    "Face for warning"
    :group 'hledger)
  (defun hledger/prev-entry ()
    "Move to last entry and pulse."
    (interactive)
    (hledger-backward-entry)
    (hledger-pulse-momentary-current-entry))
  :bind (("C-c j" . hledger-run-command)
         :map hledger-mode-map
         ("C-c e" . hledger-jentry)
         ("M-p" . hledger/prev-entry)
         ("M-n" . hledger/next-entry))
  :init
  (setq hledger-jfile (expand-file-name "~/.finance/current.hledger")
        hledger-email-secrets-file (expand-file-name "~/secrets.el" ))
  ;; Expanded account balances in the overall monthly report are
  ;; mostly noise for me and do not convey any meaningful information.
  (setq hledger-show-expanded-report nil)

  (setq-default hledger-currency-string "￥" )
  (setq-default hledger-top-asset-account "资产")
  (setq-default hledger-top-expense-account "支出")
  (setq-default hledger-top-income-account "收入")
  (setq-default hledger-year-of-birth 1979)
  (setq-default hledger-daily-report-accounts "支出")
  (setq-default hledger-ratios-assets-accounts "资产")
  (setq-default hledger-ratios-income-accounts "收入")
  (setq-default hledger-ratios-liquid-asset-accounts "活期 天添利 公积金 美元")
  (setq-default hledger-ratios-essential-expense-accounts "支出:淘宝 支出:日常支出:买菜和日常用品 支出:日常支出:外出就餐 支出:日常支出:超市购物 支出:车:油费 支出:转帐:刘春兰")
  (setq-default hledger-ratios-debt-accounts "信用卡")
  (when (boundp 'my-hledger-service-fetch-url)
    (setq hledger-service-fetch-url
          my-hledger-service-fetch-url))
  :config
  (add-hook 'hledger-view-mode-hook #'hl-line-mode)
  (add-hook 'hledger-view-mode-hook #'center-text-for-reading)
  (add-hook 'hledger-view-mode-hook
            (lambda ()
              (run-with-timer 1
                              nil
                              (lambda ()
                                (when (equal hledger-last-run-command
                                             "balancesheet")
                                  ;; highlight frequently changing accounts
                                  (highlight-regexp "^.*\\(savings\\|cash\\).*$")
                                  (highlight-regexp "^.*credit-card.*$"
                                                    'hledger-warning-face))))))

  (add-hook 'hledger-mode-hook
            (lambda ()
              (make-local-variable 'company-backends)
              (add-to-list 'company-backends 'hledger-company))))

(use-package hledger-input
  :pin manual
  :bind (("C-c e" . hledger-capture)
         :map hledger-input-mode-map
         ("C-c C-b" . popup-balance-at-point))
  :preface
  (defun popup-balance-at-point ()
    "Show balance for account at point in a popup."
    (interactive)
    (if-let ((account (thing-at-point 'hledger-account)))
        (message (hledger-shell-command-to-string (format " balance -N %s "
                                                          account)))
      (message "No account at point")))
  :config
  (setq hledger-input-buffer-height 20)
  (add-hook 'hledger-input-post-commit-hook #'hledger-show-new-balances)
  (add-hook 'hledger-input-mode-hook #'auto-fill-mode)
  (add-hook 'hledger-input-mode-hook
            (lambda ()
              (make-local-variable 'company-idle-delay)
              (setq-local company-idle-delay 0.1))))

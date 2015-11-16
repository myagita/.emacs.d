(custom-set-variables '(org-startup-folded nil))
(declare-function org-insert-heading "org" (&optional arg invisible-ok))
(defun org-my-return ()
  (interactive)
  (let ((current-line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (if (string-match "^[ \t]*-[ \t]*[^ \t]+" current-line)
        (org-insert-heading)
      (newline))))
(defun org-my-insert-date-heading ()
  (interactive)
  (beginning-of-line)
  (insert (format-time-string "* %Y-%m-%d ")))
(add-hook 'org-mode-hook 
          (lambda ()
            (local-unset-key (kbd "<C-tab>"))
            (local-unset-key (kbd "<S-up>"))
            (local-unset-key (kbd "<S-down>"))
            (local-unset-key (kbd "<S-left>"))
            (local-unset-key (kbd "<S-right>"))
            (local-unset-key (kbd "<M-left>"))
            (local-unset-key (kbd "<M-right>"))
            (local-unset-key (kbd "<M-S-left>"))
            (local-unset-key (kbd "<M-S-right>"))
            (local-set-key (kbd "<C-left>") 'org-metaleft)
            (local-set-key (kbd "<C-right>") 'org-metaright)
            (local-set-key (kbd "RET") 'org-my-return)
            (local-set-key (kbd "C-c d") 'org-my-insert-date-heading)))
(add-hook 'org-beamer-mode-hook
          (lambda () (local-set-key (kbd "<f5>") 'org-beamer-export-to-pdf)))
(font-lock-add-keywords 'org-mode '(("^[ \t]*. \\[X\\].*[\r\n]?" 0 'shadow append)))

(declare-function org-beamer--element-has-overlay-p "ox-beamer" (element))
(advice-add 'org-beamer-bold :override
            #'(lambda (bold contents info)
                (format "\\textbf%s{%s}"
                        (or (org-beamer--element-has-overlay-p bold) "")
                        contents)))

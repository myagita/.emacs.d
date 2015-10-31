(el-get-bundle tarao/with-eval-after-load-feature-el)

(el-get-bundle! flymake ; don't load this after auto-complete
  (add-hook 'flymake-mode-hook
            (lambda ()
              (local-set-key (kbd "M-p") 'flymake-goto-prev-error)
              (local-set-key (kbd "M-n") 'flymake-goto-next-error))))
(el-get-bundle auto-complete
  (custom-set-variables `(ac-comphist-file ,(expand-file-name (concat user-emacs-directory "/.achist")))))
(el-get-bundle dash)
(el-get-bundle undo-tree
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-z") 'undo-tree-undo)
  (global-set-key (kbd "C-S-z") 'undo-tree-redo)
  (global-set-key (kbd "C-_") 'undo-tree-undo)
  (custom-set-variables `(undo-tree-history-directory-alist `(("." . ,(locate-user-emacs-file ".undo"))))
                        '(undo-tree-auto-save-history t)))
(el-get-bundle ws-trim
  (global-ws-trim-mode t)
  (set-default 'ws-trim-level 0))
(el-get-bundle zlc
  (zlc-mode t)
  (define-key minibuffer-local-map (kbd "/") nil))
(el-get-bundle multiple-cursors
  (global-set-key (kbd "C-: C-]") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-: C-[") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-: C-}") 'mc/unmark-next-like-this)
  (global-set-key (kbd "C-: C-{") 'mc/unmark-previous-like-this)
  (global-set-key (kbd "C-: C-:") 'mc/mark-all-dwim))
(el-get-bundle pcre2el)
(el-get-bundle visual-regexp)
(el-get-bundle visual-regexp-steroids
  (with-eval-after-load-feature 'visual-regexp
    (require 'visual-regexp-steroids)
    (global-set-key (kbd "M-%") 'vr/query-replace)
    (global-set-key (kbd "C-c m") 'vr/mc-mark)
    (global-set-key (kbd "C-M-r") 'vr/isearch-backward)
    (global-set-key (kbd "C-M-s") 'vr/isearch-forward)
    (custom-set-variables '(vr/engine 'pcre2el))))
(let ((bluebird (expand-file-name "~/Dropbox/Settings/bluebird.el")))
  (if (and (not env-hikarie) (file-exists-p bluebird))
      (el-get-bundle hayamiz/twittering-mode
        (global-unset-key "\C-t")
        (global-set-key "\C-t\C-h" 'twit)
        (global-set-key "\C-t\C-t" 'twittering-update-status-interactive)
        (global-set-key "\C-t\C-r" 'twittering-replies-timeline)
        (custom-set-variables
         '(twittering-status-format "%i @%s / %S %p: \n %T\n [%@]%r %R %f%L\n")
         '(twittering-retweet-format " RT @%s: %t")
         '(twittering-use-ssl 1)
         '(twittering-icon-mode nil)
         '(twittering-convert-fix-size 48)
         '(twittering-timer-interval 120)
         '(twittering-update-status-function 'twittering-update-status-from-minibuffer))
        (define-key twittering-mode-map (kbd "f") 'twittering-favorite)
        (define-key twittering-mode-map (kbd "r") 'twittering-reply-to-user)
        (define-key twittering-mode-map (kbd "t") 'twittering-native-retweet)
        (define-key twittering-mode-map (kbd "m") 'twittering-direct-message)
        (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)
        (define-key twittering-mode-map (kbd "C-c C-f") 'twittering-home-timeline)
        (add-hook 'twittering-mode-hook (lambda () (setq truncate-partial-width-windows nil)))
        (load-file bluebird))))

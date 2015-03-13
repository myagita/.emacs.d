(el-get-bundle tarao/with-eval-after-load-feature-el)

(el-get-bundle! flymake ; don't load this after auto-complete
  (defvar flymake-fringe-overlays nil)
  (make-variable-buffer-local 'flymake-fringe-overlays)
  (custom-set-variables '(flymake-run-in-place nil))
  (defadvice flymake-make-overlay (after add-to-fringe first
                                         (beg end tooltip-text face mouse-face)
                                         activate compile)
    (push (fringe-helper-insert-region
           beg end
           (fringe-lib-load (if (eq face 'flymake-errline)
                                fringe-lib-exclamation-mark
                              fringe-lib-question-mark))
           'left-fringe 'font-lock-warning-face)
          flymake-fringe-overlays))
  (defadvice flymake-delete-own-overlays (after remove-from-fringe activate compile)
    (mapc 'fringe-helper-remove flymake-fringe-overlays)
    (setq flymake-fringe-overlays nil)))
(el-get-bundle auto-complete
  (custom-set-variables `(ac-comphist-file ,(expand-file-name (concat user-emacs-directory "/.achist")))))
(el-get-bundle! session
  (setq history-length 10000)
  (setq history-delete-duplicates t)
  (custom-set-variables
   `(session-set-file-name-exclude-regexp
     ,(concat session-set-file-name-exclude-regexp "\\|" "[/\\]\\.scratch" "\\|" "[/\\]geben[/\\]")))
  (session-initialize))
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
  (zlc-mode t))
(el-get-bundle multiple-cursors
  (global-set-key (kbd "C-: C-]") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-: C-[") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-: C-:") 'mc/mark-all-dwim))
(el-get-bundle k-talo/foreign-regexp.el
  (autoload 're-builder "foreign-regexp" nil t)
  (autoload 'foreign-regexp/re-builder/query-replace-on-target-buffer "foreign-regexp" nil t)
  (eval-after-load "foreign-regexp"
    '(custom-set-variables
      '(foreign-regexp/regexp-type 'perl)
      '(reb-re-syntax 'foreign-regexp)))
  (global-set-key (kbd "M-s M-l") 're-builder)
  (global-set-key (kbd "M-s M-%") 'foreign-regexp/re-builder/query-replace-on-target-buffer))
(let ((bluebird (expand-file-name "~/Dropbox/Settings/bluebird.el")))
  (if (and (not hikarie) (file-exists-p bluebird))
      (el-get-bundle hayamiz/twittering-mode
        (autoload 'twittering-update-status-interactive "twittering-mode" nil t)
        (autoload 'twittering-replies-timeline "twittering-mode" nil t)
        (global-unset-key "\C-t")
        (global-set-key "\C-t\C-h" 'twit)
        (global-set-key "\C-t\C-t" 'twittering-update-status-interactive)
        (global-set-key "\C-t\C-r" 'twittering-replies-timeline)
        (eval-after-load 'twittering-mode
          '(progn
             (setq twittering-status-format "%i @%s / %S %p: \n %T\n [%@]%r %R %f%L\n")
             (setq twittering-retweet-format " RT @%s: %t")
             (setq twittering-use-ssl 1)
             (setq twittering-icon-mode nil)
             (setq twittering-scroll-mode nil)
             (setq twittering-convert-fix-size 48)
             (setq twittering-timer-interval 120)
             (setq twittering-update-status-function 'twittering-update-status-from-minibuffer)))
        (add-hook 'twittering-mode-hook
                  '(lambda ()
                     (setq truncate-partial-width-windows nil)
                     (define-key twittering-mode-map (kbd "f") 'twittering-favorite)
                     (define-key twittering-mode-map (kbd "r") 'twittering-reply-to-user)
                     (define-key twittering-mode-map (kbd "t") 'twittering-native-retweet)
                     (define-key twittering-mode-map (kbd "m") 'twittering-direct-message)
                     (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)
                     (define-key twittering-mode-map (kbd "C-c C-f") 'twittering-home-timeline)))
        (load-file bluebird))))

(ns-toggle-toolbar)
(custom-set-variables '(mac-command-modifier 'meta)
                      '(frame-inherited-parameters '(tool-bar-lines)))
(let* ((path-raw (shell-command-to-string "$SHELL -lic 'echo $PATH'"))
       (path-trimmed (replace-regexp-in-string "[ \t\n]*$" "" path-raw))
       (path-separated (split-string path-trimmed path-separator)))
  (setenv "PATH" path-trimmed)
  (setq exec-path path-separated))

(global-set-key (kbd "M-\"")
                (defun open-iterm-here ()
                  (interactive)
                  (shell-command "open -a iTerm .")))

(custom-set-faces
 '(default ((t (:height 98 :family "MonacoB")))))
(set-fontset-font "fontset-default" 'japanese-jisx0208 '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-fontset-font "fontset-default" 'katakana-jisx0201 '("Hiragino Kaku Gothic ProN" . "iso10646-1"))

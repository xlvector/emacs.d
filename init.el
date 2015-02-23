(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'go-mode-autoloads)

(setq exec-path (cons "/usr/local/go/bin" exec-path))
(add-to-list 'exec-path "/Users/xiangliang/GoCode/bin")

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/ac-dict")
(ac-config-default)

(require 'go-autocomplete)


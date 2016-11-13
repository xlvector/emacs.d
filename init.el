(setq make-backup-files nil)
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(setq truncate-partial-width-windows t)
(menu-bar-mode nil)
(setq column-number-mode t)
(display-time-mode t)
(setq display-time-24hr-format t)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'package-archives
	     '("popkit" . "http://elpa.popkit.org/packages/"))

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;;(setq compilation-auto-jump-to-first-error nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-neotree/")
(add-to-list 'load-path "~/.emacs.d/lisp/yaml-mode/")

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))

(add-to-list 'command-switch-alist '("-diff" . command-line-diff))
(setq ediff-split-window-function 'split-window-horizontally)
(global-set-key (kbd "C-.") 'scroll-all-mode)

(require 'linum)
(setq linum-format "%4d ")
(global-linum-mode t)

;;(standard-display-ascii ?\t "^")

(require 'window-numbering)
(window-numbering-mode 1)

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[ch]*\" | etags -" dir-name))
)

(require 'molokai-theme)
;;(require 'monokai-theme)
;;(require 'color-theme)
;;(color-theme-deep-blue)
;;(load-theme 'wombat t)

;;(require 'git-emacs)

(require 'cuda-mode)

(require 'column-enforce-mode)
(global-column-enforce-mode t)

(require 'go-mode-autoloads)

(setq exec-path (cons "/usr/local/go/bin" exec-path))
(add-to-list 'exec-path "/Users/xiangliang/GoCode/bin")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/ac-dict")
(ac-config-default)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(require 'go-autocomplete)

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
      "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(unless (fboundp 'window-body-width)
  ;; Compatibility for Emacs pre-24
  (defalias 'window-body-width 'window-width))

(unless (boundp 'directory-files-no-dot-files-regexp)
  (defconst directory-files-no-dot-files-regexp "^\\([^.]\\|\\.\\([^.]\\|\\..\\)\\).*"
    "Regexp that matches anything except `.' and `..'."))

(require 'neotree)
(global-set-key (kbd "<f7>") 'neotree-toggle)
(global-set-key (kbd "<f12>") 'compile)
(setq compile-command "make opt -j10")
(global-set-key (kbd "<f4>") 'shell)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(when (load "flymake" t)
 (defun flymake-pylint-init ()
   (let* ((temp-file (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
          (local-file (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
         (list "pep8" (list "--repeat" local-file))))

 (add-to-list 'flymake-allowed-file-name-masks
              '("\\.py\\'" flymake-pylint-init)))

(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

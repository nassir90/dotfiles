(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(beacon-mode t)
 '(custom-safe-themes
   '("c7000071e9302bee62fbe0072d53063da398887115ac27470d664f9859cdd41d" default))
 '(ede-project-directories
   '("/home/naza/projects/python/wandb/subproject" "/home/naza/projects/python/wandb" "/media/projects/SpaceObjectVisualiser"))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(cmake-mode elpy graphviz-dot-mode arduino-mode zzz-to-char lsp-java ejson-mode lsp-ui pianobar lsp-mode slime-company slime opencl-mode markdown-mode ein package-lint-flymake flycheck rust-mode go-mode hippie-exp-ext hippie-namespace hippie-expand-slime multiple-cursors dracula-theme beacon evil ess helm-company helm json-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-c p") 'picture-mode)

(setq lsp-rust-server 'rust-analyzer)

(setq error-next-message-highlight t)
(setq use-short-answers t)
(setq scroll-margin 2
      scroll-conservatively 1)

(tool-bar-mode -1)
(menu-bar-mode -1)

(load-theme 'modus-vivendi t)

(setq backup-directory-alist '(("." . "~/.cache/emacs/saves/")))

(load (expand-file-name "/usr/lib/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

(add-hook 'rust-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'go-mode-hook (lambda () (setq tab-width 2)))
(add-hook 'python-mode-hook #'elpy-enable)

(defun org-mode-custom-settings ()
  (local-set-key (kbd "C-c o p") #'org-latex-export-to-pdf)
  (local-set-key (kbd "C-c o h") #'org-html-export-to-html))

(add-hook 'org-mode-hook #'org-mode-custom-settings)

(defun custom-java-mode-settings ()
  (setq dabbrev-case-replace nil)) ; <3

(add-hook 'java-mode-hook 'custom-java-mode-settings)

(require 'helm-config)
(helm-mode 1)

(defvar helm-replacement-keys
  '((helm-find-files . "C-x C-f")
    (helm-buffers-list . "C-x b")
    (helm-M-x . "M-x")))

(global-set-key (kbd "C-c m") 'mc/edit-lines)
(global-set-key (kbd "C-c <return>") 'find-file-at-point) ; Forgot about this

(defun pde-mode ()
  "Basically java mode with some custom features"
  (java-mode)
  (c-set-offset 'arglist-intro '+)
  (setq c-basic-offset 2
	tab-width 2))

(setq c-basic-offset 4)

(add-to-list 'auto-mode-alist '("\\.pde\\'" . pde-mode))
(add-to-list 'auto-mode-alist '("\\CMakeLists.txt\\'" . cmake-mode))

(defvar csu-config-file-name ".gdb")

(defun naza/current-file-and-line-number (&optional delimiter)
  "Concatenates the current buffer name and the current line number"
  (interactive)
  (unless delimiter (setq delimiter ":"))
  (concat (file-name-nondirectory buffer-file-name) delimiter (number-to-string (line-number-at-pos))))

(defun naza/remove-csu-breakpoint ()
  "Opens the file stored at csu-config-file-name and searches for any breakpoint there. If one is found, it's deleted."
  (interactive)
  (let ((current-file-and-line-number (naza/current-file-and-line-number)))
    (shell-command (concat "sed -i -e '" current-file-and-line-number "/d' " csu-config-file-name))))

(defun naza/add-csu-breakpoint ()
  "Add an entry in the format 'b 'FILENAME:LINUM' to the .gdb file int he current folder.
Should fail if there is no file named .gdb in the current directory, so make it first."
  (interactive)
  (let ((current-file-and-line-number (naza/current-file-and-line-number)))
    (with-temp-file csu-config-file-name      
      (insert-file-contents csu-config-file-name)
      (insert "b " current-file-and-line-number "\n"))))

(defun naza/svn-modified-files ()
  (interactive)
  (defalias 'sh 'shell-command-to-string)
  (if (member ".svn" (split-string (sh "ls -a")))
      (split-string (sh "svn status | sed -e '/^[^M]/d' -e 's/^M\s*//'"))
    (message (concat "You are not in an SVN directory: " (sh "echo -n `pwd`")))))

(defun window-half-height () (interactive) (max 1 (/ (1- (window-height (selected-window))) 2)))
(defun scroll-up-half () (interactive) (scroll-up (window-half-height)))
(defun scroll-down-half () (interactive) (scroll-down (window-half-height)))

(global-set-key (kbd "C-v") 'scroll-up-half)
(global-set-key (kbd "M-v") 'scroll-down-half)
(global-set-key (kbd "C-c v") 'evil-mode)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(setq compilation-read-command nil)
(setq compile-command "make")

(dolist (key '("<C-left>" "<C-right>" "<C-up>" "<C-down>"
	       "<M-left>" "<M-right>" "<M-up>" "<M-down>"))
  (global-unset-key (kbd key)))

(defvar window-movement-key-alist
  '((windmove-right . "<right>")
    (windmove-up . "<up>")
    (windmove-left . "<left>")
    (windmove-down . "<down>")))

(defun prefixed-key-alist (prefix key-alist)
  (mapcar #'(lambda (elem) (cons (car elem) (concat prefix " " (cdr elem)))) key-alist))

(defun global-set-keys (key-alist)
  (dolist (elem key-alist)
    (global-set-key (kbd (cdr elem)) (car elem))))

(defun local-set-keys (key-alist)
  (dolist (elem key-alist)
    (local-set-key (kbd (cdr elem)) (car elem))))

(defvar logic-keybindings '(((lambda () (interactive) (insert-char 8707 1 t)) . "C-c e")
			    ((lambda () (interactive) (insert-char 8704 1 t)) . "C-c f")
			    ((lambda () (interactive) (insert-char 8743 1 t)) . "C-c a")
			    ((lambda () (interactive) (insert-char 8744 1 t)) . "C-c o")
			    ((lambda () (interactive) (insert-char 923 1 t)) . "C-c l")
			    ((lambda () (interactive) (insert-char 8594 1 t)) . "C-c r")
			    ((lambda () (interactive) (insert-char 8596 1 t)) . "C-c b")
			    ((lambda () (interactive) (insert-char 955 1 t)) . "C-c u")))
(global-set-keys logic-keybindings)

(defun custom-asm-mode-settings ()
  (setq tab-width 2)
  (local-set-key (kbd "C-x a b") 'naza/add-csu-breakpoint)
  (local-set-key (kbd "C-x a d") 'naza/remove-csu-breakpoint))

(add-hook 'asm-mode-hook #'custom-asm-mode-settings)

(defun custom-terminal-settings ()
  (setq scroll-margin 0
	scroll-conservatively 0))

(add-hook 'term-mode-hook #'custom-terminal-settings)

(global-set-keys (append window-movement-key-alist
		   (prefixed-key-alist "C-x" window-movement-key-alist)
		   helm-replacement-keys))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)

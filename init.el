(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ;; Possibly redundant
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
 '(package-selected-packages
   '(hippie-exp-ext hippie-namespace hippie-expand-slime multiple-cursors dracula-theme beacon evil ess helm-company helm json-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(tool-bar-mode -1)
(menu-bar-mode -1)

(package-refresh-contents)
(package-install-selected-packages)

'((require 'seq)
(seq-map
 (lambda (s) (package-install (symbol-name s)))
 package-selected-packages))

(if (display-graphic-p) (load-theme 'dracula t))

(setq backup-directory-alist '(("." . "~/.cache/emacs/saves/")))

(add-to-list 'load-path "/home/naza/.config/emacs/tsv-mode.el")
(autoload 'tsv-mode "tsv-mode" "A mode to edit table like file" t)
(autoload 'tsv-normal-mode "tsv-mode" "A minor mode to edit table like file" t)

(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-c <return>") 'find-file-at-point)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(defun pde-mode ()
  "Basically java mode with some custom features"
  (java-mode)
  (c-set-offset 'arglist-intro '+)
  (setq c-basic-offset 2))

(add-to-list
 'auto-mode-alist
 '("\\.pde\\'" . pde-mode))

(add-hook
 'asm-mode-hook
 (lambda ()
   (setq tab-width 2)
   (local-set-key (kbd "C-x a b") 'naza/add-csu-breakpoint)
   (local-set-key (kbd "C-x a d") 'naza/remove-csu-breakpoint)))

(setq csu-config-file-name ".gdb")

(defun naza/current-file-and-line-number (delimiter &optional)
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
      (insert current-file-and-line-number "\n"))))

(defun naza/svn-modified-files ()
  (defalias 'sh 'shell-command-to-string)
  (if (member ".svn" (split-string (sh "ls -a")))
      (split-string (sh "svn status | sed -e '/^[^M]/d' -e 's/^M\s*//'"))
    (message (concat "You are not in an SVN directory: " (sh "echo -n `pwd`")))))

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))
(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))
(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(global-set-key (kbd "C-v") 'scroll-up-half)
(global-set-key (kbd "M-v") 'scroll-down-half)

(global-set-key (kbd "C-c v") 'evil-mode)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(setq compilation-read-command nil)
(setq compile-command "make")

(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "<left>") 'windmove-left)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "<down>") 'windmove-down)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "C-x <right>") 'windmove-right)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

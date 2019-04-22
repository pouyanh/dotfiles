(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))

  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)

  (add-to-list 'package-archives (cons "marmalade" (concat proto "://marmalade-repo.org/packages/")) t)

  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(setq url-proxy-services
       '(("no_proxy" . "^\\(localhost\\|10.*\\)")
         ("http" . "127.0.0.1:8118")
         ("https" . "127.0.0.1:8118")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("41c8c11f649ba2832347fe16fe85cf66dafe5213ff4d659182e25378f9cfc183" default)))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
	  (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
			 (:color "#808080"))
     (implicitParams :underline
		     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(package-selected-packages
   (quote
    (cmake-project cmake-mode clang-format irony-eldoc flycheck-irony company-irony-c-headers company-irony irony go-rename editorconfig company-shell company-c-headers company-erlang company-lua company-php company-go company flycheck cuda-mode go-mode yaml-mode php-mode markdown-mode dockerfile-mode docker-compose-mode golint flymake-go go-eldoc darcula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; Install the missing packages
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Display

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(line-number-mode 1)   ; have line numbers and
(column-number-mode 1) ; column numbers in the mode line

(global-hl-line-mode) ; highlight current line
(global-linum-mode 1) ; add line numbers to the left

(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Dired

(add-hook 'dired-mode-hook 'auto-revert-mode)

;; History

(savehist-mode 1)
(desktop-save-mode 1)

;; Editorconfig

(editorconfig-mode 1)

;; Company

(add-hook 'after-init-hook 'global-company-mode)

;(setq company-dabbrev-code-modes t)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; Golang Specific Configs

(eval-after-load 'go-mode
  (lambda ()
    (add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
    (require 'golint)
    (require 'flymake-go)
    (add-hook 'go-mode-hook
	      (lambda ()
		(go-eldoc-setup)
		(add-hook (make-local-variable 'before-save-hook) 'gofmt-before-save)
		(add-to-list (make-local-variable 'company-backends) '(company-go))
		(company-mode)))))

;; C Specific Configs

(defun pouyan-c-mode ()
  (set (make-local-variable 'clang-format-style-option) "llvm")
  (add-to-list (make-local-variable 'company-backends) '(company-irony-c-headers company-irony company-c-headers company-clang))
  (add-hook (make-local-variable 'before-save-hook) 'clang-format-buffer)
  (irony-mode))

(add-hook 'c-mode-hook 'pouyan-c-mode)
(add-hook 'c++-mode-hook 'pouyan-c-mode)
(add-hook 'objc-mode-hook 'pouyan-c-mode)

(add-hook 'irony-mode-hook
	  (lambda ()
	    (irony-eldoc)
	    (company-irony-setup-begin-commands)
	    (irony-cdb-autosetup-compile-options)))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; CMake

(add-hook 'cmake-mode-hook
	  (lambda ()
	    (set (make-local-variable 'company-backends) '(company-cmake))))

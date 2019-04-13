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
    ;; (company-shell company-c-headers company-erlang company-lua company-php company-go company flycheck auto-complete cuda-mode go-mode yaml-mode php-mode markdown-mode dockerfile-mode docker-compose-mode golint flymake-go go-autocomplete auto-complete-c-headers go-eldoc darcula-theme))))
    (company-shell company-c-headers company-erlang company-lua company-php company-go company flycheck cuda-mode go-mode yaml-mode php-mode markdown-mode dockerfile-mode docker-compose-mode golint flymake-go go-eldoc darcula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Company

(add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

(add-hook 'go-mode-hook
      (lambda ()
        (set (make-local-variable 'company-backends) '(company-go))
        (company-mode)))

;; Flymake

(eval-after-load "go-mode"
  '(require 'flymake-go))

;; golint

(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

;; go-eldoc

(add-hook 'go-mode-hook 'go-eldoc-setup)

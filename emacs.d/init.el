;; My init.el script.
;;
;; Mostly inspired by:
;;
;;   * Arne Brasseur "The amazing lisp Vim" blog post:
;;     http://devblog.arnebrasseur.net/2014-08-amazing-lisp-vim
;;   * What the .emacs.d!?: http://whattheemacsd.com/

;; First things first, clean the screen, no toolbar, no menubar, no
;; scrollbar, no splash
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)

;; Write backup files to their own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
       (concat user-emacs-directory "backups")))))

;; Always backup files, even when in version control
(setq vc-make-backup-files t)

;; Look-n-feel
(set-default-font "Hermit-12")
(setq-default indent-tabs-mode nil) ; tabs are evil

;; Package thingy, for installing extension
(require 'package)

(setq package-archives
      '(("gnu"    . "http://elpa.gnu.org/packages/")
        ("melpa"  . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(defun package-require (pkg)
  "Install a package if it is not already installed, and load its associated .el file"
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; Packages and associated configuration

(package-require 'evil)
(require 'evil)

(evil-mode 1)

(package-require 'powerline)
(require 'powerline)
(powerline-default-theme)

(package-require 'yaml-mode)
(require 'yaml-mode)

;; Load the mode for *.yml and *.yaml file
(setq auto-mode-alist
      (append '(("\\.yml$" . yaml-mode)
                ("\\.yaml$" . yaml-mode))
              auto-mode-alist))

;; Set the indent depth to 2
(add-hook 'yaml-mode-hook
          (function (lambda ()
                      (setq evil-shift-width 2))))

;; Org-mode configuration
(require 'org)

;; define some keybinding
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; Behavior configuration
(setq org-log-done t) ;; When switching to done, log the done time
(setq org-startup-folded 'content) ;; Replace the default folding by CONTENT
(setq org-startup-indented 'indent) ;; Indented style by default

;; Setup all my org files
(setq org-agenda-files (list "~/org/perso.org"))

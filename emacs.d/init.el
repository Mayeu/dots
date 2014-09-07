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

;; Package thingy, for installing extension
(require 'package)

(setq package-archives
      '(("gnu"    . "http://elpa.gnu.org/packages/")
        ("melpa"  . "http://melpa.milkbox.net/packages/")))

(package-initialize)

;; Look for evil and install it
(when (not (package-installed-p 'evil))
  (package-refresh-contents)
  (package-install 'evil))

(evil-mode 1)

;; Powerline things, to feel more at home
(when (not (package-installed-p 'powerline))
  (package-refresh-contents)
  (package-install 'powerline))

(require 'powerline)

(powerline-default-theme)

;; Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t) ;; When switching to done, log the done time

;; Replace the default OVERVIEW folding by the CONTENT one
(setq org-startup-folded 'content)
(setq org-startup-indented 'indent)

;; Setup all my org files
(setq org-agenda-files (list "~/org/perso.org"))

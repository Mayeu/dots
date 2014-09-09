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

;; Change the load path
(add-to-list 'load-path (concat user-emacs-directory "init.d"))

;; Helper function for the packages
(load "packages.el")

;; Package and associated configuration loader
(load "evil.el")
(load "powerline.el")
(load "yaml.el")
(load "org.el")

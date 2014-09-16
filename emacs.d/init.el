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

;; Evil configuration
;; ------------------

(package-require 'evil)
(package-require 'evil-leader)
(require 'evil)
(require 'evil-leader)

(evil-leader/set-leader ",")
(global-evil-leader-mode)

;; Deactivate arrow key
(define-key evil-insert-state-map [left] 'undefined)
(define-key evil-insert-state-map [right] 'undefined)
(define-key evil-insert-state-map [up] 'undefined)
(define-key evil-insert-state-map [down] 'undefined)

(define-key evil-motion-state-map [left] 'undefined)
(define-key evil-motion-state-map [right] 'undefined)
(define-key evil-motion-state-map [up] 'undefined)
(define-key evil-motion-state-map [down] 'undefined)

(evil-mode 1)

;; Powerline configuration
;; -----------------------

(package-require 'powerline)
(require 'powerline)
(powerline-default-theme)

;; YAML configuration
;; ------------------

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
;; ----------------------

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require 'evil-org)
(require 'org)

;; define some keybinding
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)

;; Behavior configuration
(setq org-log-done t) ;; When switching to done, log the done time
(setq org-startup-folded 'content) ;; Replace the default folding by CONTENT
(setq org-startup-indented 'indent) ;; Indented style by default

;; Keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))


;; Setup all my org files
(setq org-agenda-files (list "~/org/perso.org"
                             "~/org/aide.org"))

;; Regular saving of all the org buffer
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

;; Setting up leader command
(evil-leader/set-key-for-mode 'org-mode
  "t" 'org-todo
  "h" '(lambda ()
         (interactive)
         (evil-org-eol-call (lambda()
                              (org-insert-todo-heading nil))))
  "st" 'org-show-todo-tree
  "ci" 'org-clock-in
  "co" 'org-clock-out
  ;; Switch org buffer
  "b"  'org-iswitchb)

;; Relative line-number
;; --------------------
(package-require 'linum-relative)
(require 'linum-relative)

(setq linum-relative-current-symbol "->")

(linum-on)

;; Haskell-mode
;; ------------

(package-require 'haskell-mode)
(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Scala-mode
;; ----------

(package-require 'scala-mode2)
(require 'scala-mode2)

(package-require 'sbt-mode)
(require 'sbt-mode)

;; Global keybinding
;; -----------------

(global-set-key [f6] (lambda () (interactive) (find-file "~/org/perso.org")))
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

;; Function aliases
;; ----------------
(defalias 'eb 'eval-buffer)

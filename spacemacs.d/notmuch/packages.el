;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; Original source: https://github.com/bgamari/spacemacs-config/blob/c0f0246fc9b2fdc2d7abbdc1f16dc8daa34a62e9/private/notmuch/packages.el
;;
;;; License: GPLv3

(defvar notmuch-packages
  '(
    ;; package notmuchs go here
    notmuch
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar notmuch-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function notmuch/init-<package-notmuch>
;;
;; (defun notmuch/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun notmuch/init-notmuch ()
  "Initialize notmuch"
  (use-package notmuch
    :defer t
    :config
    (progn
      ;; Fix helm
      ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
      (setq notmuch-address-selection-function
            (lambda (prompt collection initial-input)
              (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

                                        ;(evil-leader/set-key)
      (evilify notmuch-hello-mode notmuch-hello-mode-map)
      (evilify notmuch-show-mode notmuch-show-mode-map
               (kbd "N") 'notmuch-show-next-message
               (kbd "n") 'notmuch-show-next-open-message)
      (evilify notmuch-tree-mode notmuch-tree-mode-map)
      (evilify notmuch-search-mode notmuch-search-mode-map)

      ;; 'd' delete stuff in both search and show mode
      (define-key notmuch-show-mode-map "d"
        (lambda ()
          (interactive)
          (notmuch-show-tag (list "+deleted" "-inbox"))
          (notmuch-bury-or-kill-this-buffer)
          (notmuch-refresh-this-buffer)))
      (define-key notmuch-search-mode-map "d"
        (lambda ()
          (interactive)
          (notmuch-search-tag (list "+deleted" "-inbox"))
          (next-line)))
      )))


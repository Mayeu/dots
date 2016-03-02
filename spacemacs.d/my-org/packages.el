;;; packages.el --- my-org Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq my-org-packages
  '(
    ;; org is installed by `org-plus-contrib'
    (org :location built-in)
    (org-plus-contrib :step pre)
    ))

(setq my-org-excluded-packages '())

;; For each package, define a function my-org/init-<package-my-org>
;;
;; (defun my-org/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun my-org/pre-init-org()
  (spacemacs|use-package-add-hook org-plus-contrib
    :post-config
    (progn
       (org-clock-persistence-insinuate)
       ;; Save all org buffer when idle 5 min
       (run-with-idle-timer 360 t 'org-save-all-org-buffers)
    )))

(defun my-org/pre-init-org-plus-contrib ()
  (spacemacs|use-package-add-hook org-plus-contrib
    :post-config
    (progn
      ;; Checkbox reset from contrib
      (require 'org-checklist)
      ;; Notmuch integration
      (require 'org-notmuch)
      )))

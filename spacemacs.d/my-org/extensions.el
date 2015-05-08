;;; extensions.el --- my-org Layer extensions File for Spacemacs
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

(defvar my-org-pre-extensions
  '(
    ;; pre extension my-orgs go here
    )
  "List of all extensions to load before the packages.")

(defvar my-org-post-extensions
  '(
    ;; post extension my-orgs go here
    org-checklist ;; For automatic reset of checkbox
    )
  "List of all extensions to load after the packages.")

;; For each extension, define a function my-org/init-<extension-my-org>
;;
;; (defun my-org/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun my-org/init-org-checklist ()
  (require 'org-checklist))

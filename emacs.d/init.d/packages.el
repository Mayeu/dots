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

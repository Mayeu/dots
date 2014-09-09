;; Look for yaml-mode and install it
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


;; Org mode
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

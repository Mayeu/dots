;; --------------------------------------------------------
;; Global keybindings
;; --------------------------------------------------------
;; F6 open my perso.org
(global-set-key [f6] (lambda () (interactive) (find-file "~/org/perso.org")))
;; F12 open the agenda
;;(global-set-key (kbd "<f12>") 'org-agenda)
;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;;; Clocking keybindings
;;
;; Goto the current clocked task
(global-set-key (kbd "<f11>") 'org-clock-goto)



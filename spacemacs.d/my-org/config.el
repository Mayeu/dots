;;; config.el --- my-org Layer packages File for Spacemacs
;;
;; Lot of code come from: http://doc.norang.ca/org-mode.html

;; Setup the org folder
(setq org-directory "~/org")
(setq org-agenda-files (list "~/org/"))

;; Behavior configuration
(setq org-log-done t) ;; When switching to done, log the done time
(setq org-startup-folded 'content) ;; Replace the default folding by CONTENT
(setq org-startup-indented 'indent) ;; Indented style by default

;; Keywords sequence and definition
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

;; When moving to certain state add associated tag
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; --------------------------------------------------------
;; Clocking configuration & behaviour
;; --------------------------------------------------------

;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist 'history)
;; Do not prompt to resume an active clock
;;(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution 'when-no-clock-is-running)
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)
;; Change tasks to NEXT when clocking in
;;(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)


;; --------------------------------------------------------
;; Capture mode
;; --------------------------------------------------------

(setq org-default-notes-file "~/org/refile.org")

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("i" "inbox" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n\n" :clock-in t :clock-resume t)
              ("t" "todo" entry (file "~/org/tasks.org")
               "* TODO %?\n%U\n\n" :clock-in t :clock-resume t)
              ;;("r" "respond" entry (file "~/org/refile.org")
              ;; "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("r" "read" entry (file "~/org/read.org")
               "* %?\n%U\n")
              ("n" "note" entry (file "~/org/references.org")
               "* %? :NOTE:\n%U\n")
              ("w" "watch" entry (file "~/org/watch.org")
               "* %?\n%U\n")
              ("m" "maybe" entry (file "~/org/maybe.org")
               "* %?\n%U\n")
              ("o" "oneday" entry (file "~/org/oneday.org")
               "* %?\n%U\n")
              ("e" "email" entry (file "~/org/refile.org")
               "* TODO %?\n%U\nSource: %c\n%i")
              ("x" "org-protocol" entry (file "~/org/refile.org")
               "* TODO Review %c\n%U\n%i\n" :immediate-finish)
              ;;("j" "Journal" entry (file+datetree "~/org/diary.org")
              ;; "* %?\n%U\n" :clock-in t :clock-resume t)
              ;;("w" "org-protocol" entry (file "~/org/refile.org")
              ;; "* TODO Review %c\n%U\n" :immediate-finish t)
              ;;("m" "Meeting" entry (file "~/org/refile.org")
              ;; "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ;;("h" "Habit" entry (file "~/org/refile.org")
              ;; "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
              )))

;; --------------------------------------------------------
;; Agenda
;; --------------------------------------------------------

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command
(setq org-agenda-custom-commands
      '(("w" todo "NEXT")))


;; --------------------------------------------------------
;; Refile config
;; --------------------------------------------------------

;; Refile on top of file max
(setq org-refile-use-outline-path 'file)
;; Seems that the multistep nature of the path to refile selection is not
;; compatible with helm. So deactivating this.
;; https://github.com/syl20bnr/spacemacs/issues/3094
(setq org-outline-path-complete-in-steps nil)
;; use a depth level of 3 max for now
(setq org-refile-targets
      '(;;(nil . (:maxlevel . 1))
        (org-agenda-files . (:maxlevel . 3))))


;; --------------------------------------------------------
;; Wiki (WIP)
;; --------------------------------------------------------

;; Link abbreviations
(setq org-link-abbrev-alist
      '(("wiki" . "file:/home/m/org/wiki/%s.org")))

;; --------------------------------------------------------
;; Mutt e-mail support
;; --------------------------------------------------------

(defun open-mail-in-mutt (message)
  "Open a mail message in Mutt, using an external terminal.
  Message can be specified either by a path pointing inside a
  Maildir, or by Message-ID."
  (interactive "MPath or Message-ID: ")
  (shell-command
   (format "termite -e \"%s %s\""
           (substitute-in-file-name "$HOME/bin/mutt-open") message)))

;; add support for "mutt:ID" links
;;(org-add-link-type "mutt" 'open-mail-in-mutt)

;; --------------------------------------------------------
;; Babel thingy
;; --------------------------------------------------------

(setq org-babel-load-languages
 '((emacs-lisp . t)
   (org . t)
   (sh . t)
   (ruby . t)
   (makefile . t)
   (elixir . t)))

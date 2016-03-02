;;; config.el --- notmuch Layer packages File for Spacemacs

;; set the default order to newest first
;;(setq notmuch-search-oldest-first nil)

;; Change the format of element showed in search
(setq notmuch-search-result-format '(("date" . "%12s ")
                                     ("count" . "%-7s ")
                                     ("authors" . "%-20s ")
                                     ("tags" . "(%s)")
                                     ("subject" . "%s ")))

;; In hello screen go directly to the saved search
(add-hook 'notmuch-hello-refresh-hook
          (lambda ()
            (if (and (eq (point) (point-min))
                     (search-forward "Saved searches:" nil t))
                (progn
                  (forward-line)
                  (widget-forward 1))
              (if (eq (widget-type (widget-at)) 'editable-field)
                  (beginning-of-line)))))

    ;; Set my default saved search
    (setq notmuch-saved-searches
      '((:name "inbox" :query "tag:inbox AND NOT tag:nothing AND NOT tag:ml")
        (:name "nothing" :query "tag:inbox AND tag:nothing")
        (:name "ml" :query "tag:inbox AND tag:ml AND NOT tag:ansible")
        (:name "ansible" :query "tag:inbox AND tag:ml AND tag:ansible")
        (:name "notmuch" :query "tag:inbox AND to:notmuchmail.org")))

;; GPG
(setq notmuch-crypto-process-mime t)
;; Sign messages by default.
(add-hook 'message-setup-hook 'mml-secure-message-sign-encrypt)
;;(add-hook 'message-setup-hook 'mml-secure-encrypt-pgpmime)
;;(add-hook 'notmuch-show-hook 'epa-mail-decrypt)

(setq message-kill-buffer-on-exit t) ; kill buffer after sending mail)
(setq mail-specify-envelope-from t) ; Settings to work with msmtp
(setq message-sendmail-envelope-from 'header)
(setq mail-envelope-from 'header)

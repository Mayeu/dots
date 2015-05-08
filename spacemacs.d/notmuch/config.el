;;; config.el --- notmuch Layer packages File for Spacemacs

;; set the default order to newest first
(setq notmuch-search-oldest-first nil)

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
      '((:name "unread" :query "tag:inbox AND NOT tag:nothing AND NOT tag:ml" :count-query "tag:inbox AND tag:unread AND NOT tag:nothing AND NOT tag:ml" :sort-order 'newest-first)
        (:name "inbox" :query "tag:inbox AND NOT tag:nothing AND NOT tag:ml" :sort-order 'oldest-first)
        (:name "unread" :query "tag:inbox AND tag:nothing" :count-query "tag:inbox AND tag:nothing AND tag:unread" :sort-order 'newest-first)
        (:name "nothing" :query "tag:inbox AND tag:nothing" :sort-order 'oldest-first)
        (:name "unread" :query "tag:inbox AND tag:ml" :count-query "tag:inbox AND tag:ml AND tag:unread" :sort-order 'newest-first)
        (:name "ml" :query "tag:inbox AND tag:ml" :count-query "tag:inbox AND tag:ml" :sort-order 'oldest-first)
        (:name "unread" :query "tag:inbox AND to:notmuchmail.org" :count-query "tag:inbox AND to:notmuchmail.org AND tag:unread" :sort-order 'newest-first)
        (:name "notmuch" :query "tag:inbox AND to:notmuchmail.org" :sort-order 'oldest-first)))

;; GPG
(setq notmuch-crypto-process-mime t)
;; Sign messages by default.
(add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)
(add-hook 'message-setup-hook 'mml-secure-encrypt-pgpmime)

(setq message-kill-buffer-on-exit t) ; kill buffer after sending mail)
(setq mail-specify-envelope-from t) ; Settings to work with msmtp
(setq message-sendmail-envelope-from 'header)
(setq mail-envelope-from 'header)

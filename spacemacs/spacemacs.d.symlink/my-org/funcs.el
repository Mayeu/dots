;;;
;; Capture floating frame
;;
;; taken from: http://www.windley.com/archives/2010/12/capture_mode_and_emacs.shtml
;;;

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

;; make the frame contain a single window. by default org-capture
;; splits the window.
(add-hook 'org-capture-mode-hook
          'delete-other-windows)

(defadvice org-switch-to-buffer-other-window
    (after supress-window-splitting activate)
  "Delete the extra window if we're in a capture frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-other-windows)))

;;(defun make-capture-frame ()
;;  "Create a new frame and run org-capture."
;;  (interactive)
;;  (make-frame '((name . "capture")
;;                (width . 120)
;;                (height . 15)))
;;  (select-frame-by-name "capture")
;;  (setq word-wrap 1)
;;  (setq truncate-lines nil)
;;  (org-capture))

(defun make-capture-frame (&optional capture-url)
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")
                (width . 120)
                (height . 15)))
  (select-frame-by-name "capture")
  (setq word-wrap 1)
  (setq truncate-lines nil)
  (if capture-url (org-protocol-capture capture-url) (org-capture)))

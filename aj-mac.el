(set-variable 'ns-pop-up-frames nil)

(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier 'alt)

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen)
                           nil
                         'fullboth)))

;; Aquaemacs prevent opening new frames
(when (boundp 'aquamacs-version)
  (progn
    (one-buffer-one-frame-mode 0)
    ;; Prevent buffers to be opened in new frame
    (setq special-display-regexps nil)
    (tabbar-mode -1)))

(provide 'aj-mac)
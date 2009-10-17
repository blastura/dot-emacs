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
  (one-buffer-one-frame-mode 0))

(provide 'aj-mac)
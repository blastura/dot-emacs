;; Octave ;;;;;;;;;;;;;;;;;;;;;;;;;
(defun aj-octave-mode-hook()
  (local-set-key (kbd "C-<return>") (lambda () (interactive)
                                       (octave-send-region 1 (point-max)))) ;; send buffer
  )
(add-hook 'octave-mode-hook 'aj-octave-mode-hook)

(provide 'aj-octave)
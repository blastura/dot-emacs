;; Octave ;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-octave-mode-hook()
  (local-set-key (kbd "C-<return>") (lambda () (interactive)
                                       (octave-send-region 1 (point-max)))) ;; send buffer
  )
(add-hook 'octave-mode-hook 'my-octave-mode-hook)

(provide 'my-octave)
;; Ediff
(set-variable 'ediff-split-window-function 'split-window-horizontally)


;; TODO: fix, this adds a lot of hooks without removing them!
(add-hook 'ediff-load-hook
          (lambda ()
            (add-hook 'ediff-before-setup-hook
                      (lambda ()
                        (setq ediff-saved-window-configuration
                              (current-window-configuration))))
    
            (let ((restore-window-configuration
                   (lambda ()
                     (set-window-configuration
                      ediff-saved-window-configuration))))
              (add-hook 'ediff-quit-hook
                        restore-window-configuration 'append)
              (add-hook 'ediff-suspend-hook
                        restore-window-configuration 'append))))

(provide 'aj-ediff)
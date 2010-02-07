(set-variable 'nxml-child-indent 3)
(defun aj-nxml-mode-hook ()
  (if (string= "build.xml" (buffer-name))
      (local-set-key (kbd "C-<return>") 'jde-build))
  (toggle-truncate-lines nil))
(add-hook 'nxml-mode-hook 'aj-nxml-mode-hook)

(provide 'aj-nxml)
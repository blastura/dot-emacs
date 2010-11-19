(defun aj-c-mode-hook ()
  (c-set-style "java")
  
  ;; Doesn't work in emacs 23...
  ;;(c-set-offset (quote case-label) (quote +))
  
  ;; Indent switch statement correctly
  (local-set-key "\C-c\C-o" 'ffap)
  (local-set-key (kbd "C-<return>") 'recompile))
(add-hook 'c-mode-hook 'aj-c-mode-hook)
(provide 'aj-c)
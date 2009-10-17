(defun aj-c-mode-hook ()
  (c-set-style "java")
  ;; Indent switch statement correctly
  (local-set-key "\C-c\C-o" 'ffap)
  (local-set-key (kbd "C-<return>") 'recompile)
  
  (local-set-key "'" 'skeleton-pair-insert-maybe)
  (local-set-key "\"" 'skeleton-pair-insert-maybe)
  (local-set-key "[" 'skeleton-pair-insert-maybe)
  (local-set-key "(" 'skeleton-pair-insert-maybe)
  (local-set-key "{" 'skeleton-pair-insert-maybe)
  (set-variable 'skeleton-pair t)
  
  (c-set-offset (quote case-label) (quote +)))
(add-hook 'c-mode-hook 'aj-c-mode-hook)
(provide 'aj-c)
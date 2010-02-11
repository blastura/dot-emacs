(fset 'aj-start-four-shells
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 49 134217848 115 104 101 108 108 return 24 50 21 134217848 115 104 101 108 108 return return 24 50 21 134217848 115 104 101 108 108 return return 24 50 21 134217848 115 104 101 108 108 return return 24 43 C-tab] 0 "%d")) arg)))

(provide 'aj-macros)
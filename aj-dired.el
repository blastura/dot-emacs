(defun aj-dired-osx-open-file-at-point()
  (interactive)
  (shell-command
   (concat "open " (dired-get-file-for-visit))))

(defun aj-dired-mode-hook ()
  (local-set-key (kbd "C-<return>") 'aj-dired-osx-open-file-at-point))

(add-hook 'dired-mode-hook 'aj-dired-mode-hook)

(provide 'aj-dired)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)

(defun ido-aj-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-w" 'ido-delete-backward-word-updir))
(add-hook 'ido-setup-hook 'ido-aj-keys)

(provide 'aj-ido)

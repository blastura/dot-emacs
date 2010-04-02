(defun aj-emacs-lisp-hook ()
  (eldoc-mode t))
(add-hook 'emacs-lisp-mode-hook 'aj-emacs-lisp-hook)

(provide 'aj-elisp)
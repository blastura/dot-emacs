;; Tex
;; Time-stamp: "2008-10-08 19:25:54 anton"

(defun my-latex-mode-hook()
  (TeX-PDF-mode t)
  ;;(longlines-mode 0)
  (flyspell-mode 1)
  (ispell-change-dictionary "sv" nil)
  (auto-fill-mode 1)
  (local-set-key (kbd "C-c C-f") 'LaTeX-close-environment) ;; Nxml style close
  (local-set-key (kbd "C-c C-n") 'TeX-next-error)
  (local-set-key (kbd "C-c C-o") 'browse-url)
  (local-set-key (kbd "C-<return>") 'TeX-command-master))
(add-hook 'LaTeX-mode-hook 'my-latex-mode-hook)

(setq TeX-parse-self t)                 ; Enable parse on load.
(setq TeX-auto-save t)                  ; Enable parse on save.

(provide 'my-latex)
;; Tex
;; Time-stamp: "2010-01-17 01:02:46 anton"

(defun aj-latex-mode-hook()
  (TeX-PDF-mode t)
  (TeX-fold-mode 1)
  ;;(longlines-mode 0)
  (flyspell-mode 1)
  ;;(ispell-change-dictionary "svenska" nil)
  (auto-fill-mode 1)
  (local-set-key (kbd "C-c C-f") 'LaTeX-close-environment) ;; Nxml style close
  (local-set-key (kbd "C-c C-n") 'TeX-next-error)
  (local-set-key (kbd "C-c C-o") 'ffap)
  (local-set-key (kbd "C-<return>") 'TeX-command-master))
(add-hook 'LaTeX-mode-hook 'aj-latex-mode-hook)

(setq TeX-parse-self t)                 ; Enable parse on load.
(setq TeX-auto-save t)                  ; Enable parse on save.

(provide 'aj-latex)
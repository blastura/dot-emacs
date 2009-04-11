(defun my-org-mode-hook()
  ;;(flyspell-mode t)
  ;;(ispell-change-dictionary "sv" nil)
  (auto-fill-mode 1)
  (local-set-key (kbd "C-<return>") 'org-export-as-html-and-open)
  (local-set-key (kbd "C-<tab>") 'other-window)
  (local-set-key (kbd "C-S-<tab>") (lambda ()
                                     (interactive) (other-window -1))))
(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-directory "~/Documents/org")
(setq org-default-notes-file "~/Documents/org/notes.org")
;;(setq remember-annotation-functions '(org-remember-annotation))
;;(setq remember-handler-functions '(org-remember-handler))
;;(add-hook 'remember-mode-hook 'org-remember-apply-template)

(set-variable 'org-export-html-style
              "<link rel=\"stylesheet\" type=\"text/css\" href=\"/Users/anton/.emacs.d/org-mode.css\" />")
(set-variable 'org-export-with-section-numbers nil)

(defun my-text-mode()
  (interactive)
  ;;   (set-default-font "-apple-gill sans-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (set-default-font "-apple-adobe caslon pro-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (highlight-current-line-set-bg-color "grey88")
  (progn (color-theme-jsc-light2) ;;dark and fine
         (highlight-current-line-set-bg-color "grey77"))
  (custom-set-faces
   '(flymake-warnline ((((class color)) (:underline "yellow"))))
   '(flyspell-duplicate ((t (:underline "Gold3"))))
   '(flyspell-incorrect ((t (:underline "OrangeRed"))))))

(provide 'my-org)

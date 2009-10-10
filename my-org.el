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

;; (defun process-file (file)
;;    "Read the contents of a file into a temp buffer and then do
;;  something there."
;;    (when (file-readable-p file)
;;      (with-temp-buffer
;;        (insert-file-contents file)
;;        (goto-char (point-min))
;;        (while (not (eobp))
;;        ;; do something here with buffer content
;;          (forward-line)))))

;; (set-variable 'org-export-html-style
;;               "<link rel=\"stylesheet\" type=\"text/css\">"
              
;;               ~/.emacs.d/org-mode.css
;;               "</link>")

(set-variable 'org-export-with-section-numbers nil)

;; Clocking
(setq org-clock-history-length 35)


(provide 'my-org)

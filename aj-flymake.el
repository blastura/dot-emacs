;;-1 = NONE, 0 = ERROR, 1 = WARNING, 2 = INFO, 3 = DEBUG
(set-variable 'flymake-log-level 0)
(set-variable 'flymake-no-changes-timeout 0.5)
(set-variable 'flymake-start-syntax-check-on-newline nil)

(defun aj-flymake-restart-after-crach()
  (interactive)
  (setf compilation-in-progress nil))

(defun aj-flymake-mode-hook () 
 (define-key (current-local-map) "\C-c\C-d" 'flymake-display-err-menu-for-current-line)
 (define-key (current-local-map) "\C-c\C-n" 'aj-flymake-show-next-error)
 (define-key (current-local-map) "\C-c\C-p" 'aj-flymake-show-prev-error)
 (define-key (current-local-map) "\C-c\C-f" 'aj-flymake-display-err-minibuf))
(add-hook 'flymake-mode-hook 'aj-flymake-mode-hook)

(custom-set-faces
 '(flymake-errline ((((class color)) (:underline "OrangeRed"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))

(defun aj-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (aj-flymake-display-err-minibuf))

(defun aj-flymake-show-prev-error()
  (interactive)
  (flymake-goto-prev-error)
  (aj-flymake-display-err-minibuf))

(defun aj-flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

(provide 'aj-flymake)
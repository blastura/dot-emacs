;;; TODO: Unbind key-map or something, right now it for example
;;; removes org-modes keybindings when switching back to no write mode


;; (defun aj-find-file-hook()
;;   (when buffer-file-name
;;     (toggle-read-only 1))
;;   (message "Read-only"))

;; (add-hook 'find-file-hook 'aj-find-file-hook)

;; (defvar aj-read-only-mode-map
;;   (let ((map (make-keymap)))
;;     (suppress-keymap map)
;;     ;; (define-key map [mouse-2] 'dired-mouse-find-file-other-window)
;;     ;; (define-key map [follow-link] 'mouse-face)
    
;;     (define-key map "n" 'next-line)
;;     (define-key map "p" 'previous-line)
;;     (define-key map "f" 'forward-char)
;;     (define-key map "b" 'backward-char)
;;     (define-key map "a" 'move-beginning-of-line)
;;     (define-key map "e" 'move-end-of-line)
;;     (define-key map "v" 'scroll-up)
    
;;     (define-key map "k" 'kill-line)
;;     (define-key map (kbd "SPC") 'set-mark-command)
;;     map)
;;   "Local keymap for read-only buffers.")

;; (defadvice toggle-read-only (after aj-read-only-toggle-keymap())
;;   "Toggle keymap for read-only buffers"
;;   (if buffer-read-only
;;       (use-local-map aj-read-only-mode-map)
;;     (use-local-map nil)))

;; (ad-activate 'toggle-read-only)

(provide 'aj-read-only-keymap-hooks)

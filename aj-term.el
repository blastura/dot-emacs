;; From http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/
(require 'term)
(require 'multi-term)

(setq multi-term-program "/bin/bash")
;;(setq ansi-color-context nil)


(setq comint-prompt-read-only t)
;; (setq ansi-color-names-vector
;;       ["black" "red4" "green4" "yellow4"
;;        "blue3" "magenta4" "cyan4" "white"])

(defun aj-shell-hook()
  (toggle-truncate-lines 1)
  (ansi-color-for-comint-mode-on))

(add-hook 'shell-mode-hook 'aj-shell-hook)


;; Add color to a shell running in emacs ‘M-x shell’
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))

;;(global-set-key (kbd "<f2>") 'visit-ansi-term)
(global-set-key (kbd "<f2>") 'multi-term)


(defun aj-term-toggle-line-char ()
  "Function to toggle line and char mode in ansi-term"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

(add-hook 'term-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-j" 'aj-term-toggle-line-char)
            (message "loading term-hook-aj")
            ;; Terminal color
            (set-variable 'term-default-bg-color (face-background 'default))
            (set-variable 'term-default-fg-color (face-foreground 'default))
            ))

;; Bind key for multi-term
(push '("C-c C-j" . aj-term-toggle-line-char) term-bind-key-alist)

;; From http://atomized.org/2008/07/emacs-open-a-shell-in-the-current-directory/
;; Added cd
(defun shell-here ()
  "Open a shell in `default-directory'."
  (interactive)
  (let ((dir (expand-file-name default-directory))
        (buf (or (get-buffer "*shell*") (shell))))
    (goto-char (point-max))
    (if (not (string= (buffer-name) "*shell*"))
        (switch-to-buffer-other-window buf))
    (message list-buffers-directory)
    (if (not (string= (expand-file-name list-buffers-directory) dir))
        (progn (comint-send-string (get-buffer-process buf)
                                   (concat "cd \"" dir "\"\r"))
               (cd dir) ;; Added
               (setq list-buffers-directory dir)))))

(global-set-key (kbd "C-c !") 'shell-here)

(provide 'aj-term)

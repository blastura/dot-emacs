;; Generics
;; Time-stamp: "2009-10-10 11:33:05 anton"
(server-start)
(set-variable 'inhibit-startup-message t)
(set-variable 'user-mail-address "anton\.johansson@gmail\.com")
(set-variable 'user-full-name "Anton Johansson")
(setq truncate-lines t)
(prefer-coding-system 'utf-8)
(global-font-lock-mode t)
(show-paren-mode t)
(setq fill-column 80)
(column-number-mode t)
(add-hook 'before-save-hook 'time-stamp) ;; insert time-stamp before saves
(setq visible-bell t)                    ;; disable audible bell
(setq-default indent-tabs-mode nil)      ;; TAB ger mellanslag
(setq default-tab-width 3)               ;; set tabs to 3 spaces
(setq speedbar-show-unknown-files t) ;;show all files in speedbar
(set-face-background (quote cursor) "red")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq sentence-end-double-space nil)
(setq dabbrev-abbrev-skip-leading-regexp "[^ ]*[<>=*]") ;; script <tags> when expanding

;; Add color to a shell running in emacs ‘M-x shell’
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq exec-path (cons "/opt/local/bin" exec-path))
(setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:"
                       (getenv "PATH")))
(set-variable 'vc-path '("/opt/local/bin"))

;; Regex-tool
;; (set-variable 'regex-tool-backend (quote perl))

;; Mouse-scroll amount
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control))))

;; Frame-title shows filename
(setq frame-title-format '(multiple-frames "%b" "%b"))

;; Skeletons
(global-set-key "'" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(set-variable 'skeleton-pair t)

;; Keybindings
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)) ;; allows window move with shift-arrowkeys
(global-set-key "\M-1" 'beginning-of-buffer)
(global-set-key "\M-2" 'end-of-buffer)
(global-set-key (kbd "C-M-SPC") 'anything)
(global-set-key "\M-n" 'just-one-space)
(global-set-key "\M-p" 'mark-paragraph)
(global-set-key "\M-j" 'hippie-expand) ;dabbrev-expand)

(setq hippie-expand-dabbrev-as-symbol t)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev-visible
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        ;;try-expand-all-abbrevs
        ;;try-expand-list
        ;;try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        ))

(global-set-key "\C-w" 'backward-kill-word) ;; erases standard kill-region
(global-set-key "\C-x\C-k" 'kill-region) ;; replace standard kill-region
(global-set-key "\M-y" 'anything-show-kill-ring) ;; replace standard yank-pop
(global-set-key (kbd "C-x C-b") #'ibuffer) ;; removes standard list-buffers
(global-set-key "\C-c\C-o" 'ffap)
(global-set-key "\C-x\C-m" 'execute-extended-command) ;; M-x
(global-set-key "\C-c\C-m" 'execute-extended-command) ;; M-x
(global-set-key "\C-xO" (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") (lambda () (interactive) (other-window -1)))
(global-set-key "\C-o" (lambda() (interactive)
                         (save-excursion (newline-and-indent))
                         (indent-according-to-mode)))
(global-set-key (kbd "C-7") 'indent-region)
(global-set-key (kbd "C-8") 'comment-region)
(global-set-key (kbd "C-9") 'uncomment-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key "\M-s" 'speedbar-get-focus)
(global-set-key [f5]   'call-last-kbd-macro) ;; bind key for calling last macro
(global-set-key "\M-\"" 'shell-command-on-region)

;; Alias
(defalias 'qrr 'query-replace-regexp)

;; GDB
(setq gdb-many-windows t)

;; Autosaves ;;;;;;;;;;;;;;;;;;;;
;; Put autosave files (ie #foo#) in one place, *not* scattered all over the
;; file system! (The make-autosave-file-name function is invoked to determine
;; the filename of an autosave file.)
(defvar autosave-dir "~/.emacs.d/autosave")
(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "/#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "~/.emacs.d/autosave/backup"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Style ;;;;;;;;;;;;;;;;;;;;;;;;;
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(when window-system
;;  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;; Functions
(defun insert-date-time()
  "Inserts standard date time string."
  (interactive)
  (insert (format-time-string "%c")))

(defun indent-whole-buffer()
  "indent whole buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace))
(defalias 'iwb 'indent-whole-buffer)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "*sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "*DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil)
        t))))

(defun tidy-buffer ()
  "Run Tidy HTML parser on current buffer."
  (interactive)
  (if (get-buffer "tidy-errs") (kill-buffer "tidy-errs"))
  (shell-command-on-region (point-min) (point-max)
                           "tidy -f /tmp/tidy-errs -q -i -utf8 -asxhtml -wrap 0 -c" t)
  (find-file-other-window "/tmp/tidy-errs")
  (other-window 1)
  (delete-file "/tmp/tidy-errs")
  (message "buffer tidy'ed"))

(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))

;; Open all existing files read-only
;; (defun my-find-file-hook()
;;   (toggle-read-only t))
;; (add-hook 'find-file-hook 'my-find-file-hook)

;; Make switching better with completions
(ido-mode 1)
(setq ido-enable-flex-matching t) ; fuzzy matching
(setq ido-create-new-buffer 'always)

;; Log-edit
(add-hook 'log-edit-mode-hook 'flyspell-mode)

;; Buffers/files identical names
;; TODO : move
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
  (fill-paragraph nil)))


(provide 'my-generic)
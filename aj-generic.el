;; Generics and keybindings ~random stuff
;; Time-stamp: "2010-11-27 14:44:54 anton"
(set-variable 'inhibit-startup-message t)
(set-variable 'user-mail-address "anton\.johansson@gmail\.com")
(set-variable 'user-full-name "Anton Johansson")
(set-default 'truncate-lines t)
(setq delete-by-moving-to-trash t)
(setq transient-mark-mode t)
(global-font-lock-mode t)
(show-paren-mode t)
(setq fill-column 80)
(column-number-mode t)
(setq visible-bell t)                ;; disable audible bell
(setq-default indent-tabs-mode nil)  ;; TAB ger mellanslag
(setq default-tab-width 3)           ;; Emacs < 23 set tabs to 3 spaces
(setq tab-width 3)                   ;; Emacs 23: set tabs to 3 spaces
(setq speedbar-show-unknown-files t) ;;show all files in speedbar
(set-face-background (quote cursor) "red")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq sentence-end-double-space nil)
(setq dabbrev-abbrev-skip-leading-regexp "[^ ]*[<>=*]") ;; skip <tags> when expanding

;; Coding system
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(fset 'yes-or-no-p 'y-or-n-p)

(let ((aj-path (mapcar 'expand-file-name '("~/bin" ;; Mine
                                           "/usr/local/bin" ;; Brew
                                           "/opt/local/bin" ;; Macport
                                           "/opt/local/sbin"
                                           "~/.gem/ruby/1.8/bin" ;; Gems
                                           "/usr/local/mysql/bin"))))

  ;; Set PATH env
  (setenv "PATH"
          (concat (mapconcat 'identity aj-path ":") ":" (getenv "PATH") ))
  ;; Set exec-path
  (setq exec-path
        (append aj-path
                exec-path)))

(set-variable 'vc-path '("/usr/local/bin"))

;; Mouse-scroll amount
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control))))

;; Frame-title shows filename
(setq frame-title-format '(multiple-frames "%b" "%b"))

;; Skeletons
;; (global-set-key "'" 'skeleton-pair-insert-maybe)
;; (global-set-key "\"" 'skeleton-pair-insert-maybe)
;; (global-set-key "[" 'skeleton-pair-insert-maybe)
;; (global-set-key "(" 'skeleton-pair-insert-maybe)
;; (global-set-key "{" 'skeleton-pair-insert-maybe)
;; (set-variable 'skeleton-pair t)

;; Keybindings
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)) ;; allows window move with shift-arrowkeys
(global-set-key "\M-1" 'beginning-of-buffer)
(global-set-key "\M-2" 'end-of-buffer)
(global-set-key (kbd "C-M-SPC") 'anything)
(global-set-key (kbd "C-M--") 'shrink-window)
(global-set-key (kbd "C-M-_") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-+") 'enlarge-window)
(global-set-key (kbd "C-M-?") 'enlarge-window-horizontally)
(global-set-key "\M-n" 'just-one-space)
(global-set-key "\M-p" 'mark-paragraph)
(global-set-key "\M-j" 'hippie-expand)  ;dabbrev-expand)

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
(global-set-key (kbd "C-x C-b") (lambda() (interactive) (ibuffer nil))) ;; removes standard list-buffers
(global-set-key "\C-co" 'ffap)
;; Open file with osx open shell command
(global-set-key "\C-cO" (lambda() (interactive)
                          (shell-command
                           (concat "open " (buffer-file-name)))))
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
(defalias 'mkdir 'make-directory)
(defun ls()
  (interactive)
  (shell-command "ls"))

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
;; (defun aj-find-file-hook()
;;   (toggle-read-only t))
;; (add-hook 'find-file-hook 'aj-find-file-hook)

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

;; Hooks ;;;;;;;;;;;;;;;;;;;;;;;;
;; Timestamp
(add-hook 'before-save-hook 'time-stamp) ;; insert time-stamp before saves

;; From sean @ http://emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/
(add-hook 'after-save-hook 'aj-recompile-el)
(defun aj-recompile-el ()
  (interactive)
  (when (and buffer-file-name
             (string-match "/.*\\.el$"  buffer-file-name)
             (file-newer-than-file-p buffer-file-name
                                     (concat buffer-file-name "c"))
             (y-or-n-p (format "byte-compile %s? "
                               (file-name-nondirectory (buffer-file-name)))))
    (byte-compile-file buffer-file-name)))

;; Log-edit
(add-hook 'log-edit-mode-hook 'flyspell-mode)

;; Folding

(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key [(M C i)] 'aj-toggle-fold)

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (local-set-key [(M C i)] 'aj-toggle-fold)))


;; Logview mode from http://stackoverflow.com/questions/133821/the-best-tail-gui
(defvar angry-fruit-salad-log-view-mode-map
  (make-sparse-keymap))

(define-minor-mode angry-fruit-salad-log-view-mode
  "View logs with colors.

Angry colors."
  nil " AngryLog" nil

  (cond (angry-fruit-salad-log-view-mode
         (auto-revert-tail-mode 1)
         (highlight-changes-mode 1)
         (define-key angry-fruit-salad-log-view-mode-map
           (kbd "C-c C-r")
           'highlight-changes-rotate-faces)
         (if (current-local-map)
             (set-keymap-parent angry-fruit-salad-log-view-mode-map
                                (current-local-map)))
         ;; set the keymap
         (use-local-map angry-fruit-salad-log-view-mode-map))

        (t
         (auto-revert-tail-mode -1)
         (highlight-changes-mode -1)
         (use-local-map (keymap-parent angry-fruit-salad-log-view-mode-map)))))

;; CUA rectangle edits
;; (setq cua-enable-cua-keys nil) ;; only for rectangles
;; (cua-mode t)

;; by Nikolaj Schumacher, 2008-10-20. Licensed under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))

(defun extend-selection (arg &optional incremental)
  "Mark the symbol surrounding point.
Subsequent calls mark higher levels of sexps."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))

(global-set-key "\M-p" 'extend-selection)

(provide 'aj-generic)
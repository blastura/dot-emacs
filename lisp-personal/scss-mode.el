;;; scss-mode.el --- Major mode for editing SCSS files
;;
;; Author: Anton Johansson <anton.johansson@gmail.com> - http://antonj.se
;; URL: http://github.com/blastura/dot-emacs/blob/master/lisp-personal/scss-mode.el
;; Created: Sep 1 23:11:26 2010
;; Keywords: scss css mode
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;;; Commentary:
;;
;; Command line utility sass is required, see http://sass-lang.com/
;; To install sass (haml):
;; gem install haml
;;
;; Also make sure sass location is in emacs PATH, example:
;; (setq exec-path (cons (expand-file-name "~/.gem/ruby/1.8/bin/sass") exec-path))
;; or customize `scss-sass-command' to point to your sass executable.
;;
;;; Code:

(require 'derived)
(require 'compile)

(defgroup scss nil
  "Scss mode"
  :prefix "scss-"
  :group 'css)

(defcustom scss-sass-command "sass"
  "Command used to compile SCSS files, should be sass or the
  complete path to your sass runnable example:
  \"~/.gem/ruby/1.8/bin/sass\""
  :group 'scss)

(defcustom scss-compile-at-save t
  "If not nil the SCSS buffers will be compiled after each save"
  :type 'boolean
  :group 'scss)

(defcustom scss-compile-error-regex '("\\(Syntax error:\s*.*\\)\n\s*on line\s*\\([0-9]+\\) of \\([^ ]+\\)$" 3 2 nil nil 1)
  "Regex for finding line number file and error message in
compilation buffers, syntax from
`compilation-error-regexp-alist' (REGEXP FILE LINE COLUMN TYPE
HYPERLINK HIGHLIGHT)"
  :group 'scss)

(defconst scss-font-lock-keywords
  ;; Variables
  '(("\$[^\s:;]+" . font-lock-constant-face)
    ("//.*$" . font-lock-comment-face)))

(defun scss-compile-maybe()
  "Runs `scss-compile' on if `scss-compile-at-save' is t"
  (if scss-compile-at-save
      (scss-compile)))

(defun scss-compile()
  "Compiles the current buffer, sass buffername.scss buffername.css"
  (interactive)
    (compile (concat scss-sass-command " "
          (buffer-name) " "
          (first (split-string (buffer-name) ".scss")) ".css")))

(defun scss-insert-and-indent (key)
  "Run the command bound to KEY, and indent if necessary.
Indentation does not take place if point is in a string or
comment.  Adapted from js-insert-and-indent."
  (interactive (list (this-command-keys)))
  (call-interactively (lookup-key (current-global-map) key))
  (let ((syntax (save-restriction (widen) (syntax-ppss))))
    (when (and (not (nth 8 syntax))
	      (not (nth 4 syntax)))
      (indent-according-to-mode))))

(defvar scss-mode-map
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "C-c C-c") #'scss-compile)
    (mapc (lambda (key)
	    (define-key keymap key #'scss-insert-and-indent))
	  '("{" "}" ";"))
    keymap))

;;;###autoload
(define-derived-mode scss-mode css-mode "Scss"
  "Major mode for editing Scss files, http://sass-lang.com/
Special commands:
\\{scss-mode-map}"
  (font-lock-add-keywords nil scss-font-lock-keywords)
  (add-to-list 'compilation-error-regexp-alist scss-compile-error-regex)
  (add-hook 'after-save-hook 'scss-compile-maybe nil t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(provide 'scss-mode)
;;; scss-mode.el ends here
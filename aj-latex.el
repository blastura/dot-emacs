;; Tex (auctex)
;; Time-stamp: "2010-11-26 18:24:10 anton"

;;;  Auctex (non-elpa install)
;; From http://ftp.gnu.org/pub/gnu/auctex/auctex-11.86.zip
;; ./configure --prefix=/Users/anton/.emacs.d/lisp/auctex \
;; 	--without-texmf-dir \
;; 	--with-emacs=/Applications/Emacs-23.app/Contents/MacOS/Emacs \
;; 	--with-lispdir=/Users/anton/.emacs.d/lisp/auctex
;; make && make install
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/auctex"))
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

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

;; OSX view command → open
(setq TeX-view-program-list-builtin
      '(("Preview.app" "open -a Preview.app %o")
        ("Skim" "open -a Skim.app %o")
        ("displayline" "displayline %n %o %b")
        ("open" "open %o")))
(setq TeX-view-program-selection '((output-dvi "open")
                                   (output-pdf "open")
                                   (output-html "open")))



(provide 'aj-latex)
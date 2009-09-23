;; Anton Johansson
;; Time-stamp: "2009-09-20 19:14:13 anton"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/yasnippet"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/magit"))

;; JDE load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet/common"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb"))

;; Modes
(require 'flymake)
(require 'magit)
(require 'anything-config)
(require 'git)
(require 'babel) ;; Translate with eg Google
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$\\|\\.yaml$" . yaml-mode))

;; Personal customizations
;;(require 'slime)
(require 'my-generic)
(require 'my-ediff)
(require 'my-color)
(require 'my-html)
(require 'my-latex)
(require 'my-irc)
(require 'my-org)
(require 'my-octave)
(require 'my-mac)
(require 'my-c)
(require 'my-flymake)
(require 'my-flymake-c)
(require 'my-flymake-css)
(require 'my-python)
;; (require 'anything-match-plugin)
;; (set-variable 'anything-mp-highlight-delay nil)

;;(require 'fuzzy-match)
(require 'my-anything)

(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(load-file "~/.emacs.d/lisp/graphviz-dot-mode.el")

(load-file "~/.emacs.d/lisp/cedet/common/cedet.el")
(require 'my-cedet)
(make-directory "~/.emacs.d/semanticCache" t)
(setq semanticdb-default-save-directory "~/.emacs.d/semanticCache")

(require 'ecb-autoloads)
(require 'jde)
(require 'my-java)

;; Javascript
(autoload 'js2-mode "js2" nil t)

;; File assosiation
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Other customizations
(load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'my-nxml)
;;(load "~/.emacs.d/lisp/nxhtml/autostart.el")

(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

(require 'yasnippet)
(yas/load-directory "~/.emacs.d/my-snippets")
(add-to-list 'yas/extra-mode-hooks
             'rst-mode-hook)

(add-to-list 'yas/extra-mode-hooks
             'nxml-mode-hook)

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (indent-region yas/snippet-beg
                            yas/snippet-end)))
(set-variable 'yas/trigger-key "")
(yas/initialize)

;; Find-file-not-found-hooks
(setq default-major-mode 'org-mode)

(add-hook 'find-file-not-found-hooks
          '(lambda ()
             (if (equal (file-name-extension (buffer-file-name)) "java")
                 (progn
                   (java-mode)
                   (insert-java-template)
                   (message "Inserted java template")))

             (if (equal (file-name-extension (buffer-file-name)) "html")
                 (progn
                   (nxml-mode)
                   (insert-xhtml-template)
                   (message "Inserted xhtml template")))))

(setq custom-file "~/.emacs.d/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
(message "loaded init.el")

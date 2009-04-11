;; Anton Johansson
;; Time-stamp: "2009-04-11 10:28:56 anton"

;; Debug on all errors, currently for jde :(
(setq debug-on-error nil)

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
(require 'my-flymake-c)
;; (require 'anything-match-plugin)
;; (set-variable 'anything-mp-highlight-delay nil)

;;(require 'fuzzy-match)
(require 'my-anything)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)
(load-file "~/.emacs.d/lisp/graphviz-dot-mode.el")
;;(require 'psvn)

(load-file "~/.emacs.d/lisp/cedet/common/cedet.el")
(require 'my-cedet)
(make-directory "~/.emacs.d/semanticCache" t)
(setq semanticdb-default-save-directory "~/.emacs.d/semanticCache")
(require 'ecb-autoloads)
(require 'jde)
;; (require 'jswat)
;; (set-variable 'jswat-path (expand-file-name "~/bin/jswat-4.3"))
(require 'my-java)
(require 'my-flymake)

;; Javascript
(autoload 'js2-mode "js2" nil t)

;; File assosiation
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Other customizations
(load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(load "~/.emacs.d/lisp/nxhtml/autostart.el")

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

;;Find-file-not-found-hooks
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

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6"))))
 '(org-agenda-files (quote ("~/Documents/org/notes.org"))))
 
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "red"))))
 '(flymake-errline ((((class color)) (:underline "OrangeRed"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(flyspell-duplicate ((t (:underline "Gold3"))))
 '(flyspell-incorrect ((t (:underline "OrangeRed"))))
 '(ido-first-match-face ((t (:background "green")))))

(message "loaded init.el")

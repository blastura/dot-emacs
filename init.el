;; Anton Johansson
;; Time-stamp: "2010-11-26 18:42:49 anton"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/org-mode/lisp"))

;;;; Auto-install start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/auto-install.el")
  (require 'auto-install)
  (setq auto-install-directory (expand-file-name "~/.emacs.d/lisp/auto-install/"))
  (add-to-list 'load-path auto-install-directory)

  ;; TODO: Autoinstalled from where?
  (require 'ring+)
  (require 'doremi)
  (require 'doremi-frm)

  ;;(auto-install-from-url "http://download.savannah.gnu.org/releases-noredirect/espresso/espresso.el")
  (autoload 'espresso-mode "espresso" nil t)

  ;;(auto-install-from-url "http://autopair.googlecode.com/svn/tags/REL_0_3/autopair.el")
  (require 'autopair)
  (autopair-global-mode t)

  ;;(auto-install-from-url "http://www.dr-qubit.org/undo-tree/undo-tree.el")
  (require 'undo-tree)

  ;;(auto-install-from-url "http://jblevins.org/git/markdown-mode.git/plain/markdown-mode.el")
  (autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
  (setq auto-mode-alist (cons '("\\.text$\\|\\.markdown$" . markdown-mode) auto-mode-alist))

  ;;(auto-install-from-url "http://www.xsteve.at/prg/emacs/psvn.el")
  (require 'psvn)

  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/php-mode-improved.el")
  (require 'php-mode-improved)

  ;;;; (auto-install-from-url "http://github.com/nex3/haml/raw/master/extra/haml-mode.el")
  ;;;; (auto-install-from-url "http://github.com/nex3/haml/raw/master/extra/sass-mode.el")
  ;;(require 'sass-mode)

  ;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
  ;; TODO: (auto-install-from-url ???)
  (autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
  (add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
  (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

  ;; Personal
  (autoload 'less-mode "less-mode")
  (add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

  ;;(autoload 'scss-mode "scss-mode")
  (require 'scss-mode)
  ;;(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

  ;; Modes
  (require 'flymake)

  ;; (auto-install-from-url "http://git.naquadah.org/?p=rainbow.git;a=blob_plain;f=rainbow-mode.el")
  (require 'rainbow-mode)

  ;; (auto-install-from-url "http://github.com/juergenhoetzel/babel/raw/STABLE/babel.el")
  (require 'babel) ;; Translate with eg Google

  ;;
  ;;;; Auto-install end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )

;;;; ELPA start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn
  ;;

  ;; OLD package.el
  ;; (auto-install-from-url "http://tromey.com/elpa/package.el")
  ;; NEW Builtin emacs pull from git repo HEAD
  ;;(auto-install-from-url "http://git.savannah.gnu.org/gitweb/?p=emacs.git;a=blob_plain;f=lisp/emacs-lisp/package.el;hb=HEAD")
  (require 'package)
  (package-initialize) ;; TODO: should be done within package.el?
  ;; (defcustom package-enable-at-startup t ...) maybe in emacs24 only?

  ;; Use official emacs 24 repository with ELPA
  (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                           ("gnu" . "http://elpa.gnu.org/packages/")))

  ;;;; Auctex elpa from gnu repo
  ;; (package-install 'auctex)
  ;;;; ELPA end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )


;; Anyting
(require 'anything-config)
;; (require 'magit)
;; (require 'git)

;; JDE ;; CEDET needs to be loaded first
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib-1.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb-2.40"))
(require 'aj-cedet)
(require 'ecb-autoloads)
(require 'jde)
(require 'aj-java)

;; Git emacs
;; From https://github.com/tsgates/git-emacs/tree/master
;; $ git clone git://github.com/tsgates/git-emacs.git
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/git-emacs"))
(require 'git-emacs)
(require 'git-status)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$\\|\\.yaml$" . yaml-mode))

;; Personal customizations
(require 'aj-ibuffer)
(require 'aj-macros)
(require 'aj-generic)
(require 'aj-elisp)
(require 'aj-ediff)
(require 'aj-color)
(require 'aj-html)
(require 'aj-latex)
(require 'aj-irc)
(require 'aj-org)
(require 'aj-octave)
(require 'aj-mac)
(require 'aj-c)
(require 'aj-flymake)
(require 'aj-flymake-c)
(require 'aj-flymake-css)
(require 'flymake-scss)
(require 'aj-anything)
(require 'aj-compilation)
(require 'aj-ido)
(require 'aj-term)
(require 'aj-js)
(require 'aj-dired)
(require 'aj-python)
;; (requiraje 'anything-match-plugin)
;; (set-variable 'anything-mp-highlight-delay nil)
;;(require 'fuzzy-match)

(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

;; Javascript
(autoload 'js2-mode "js2" nil t)

;; File association
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Other customizations
;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'aj-nxml)
;; (load "~/.emacs.d/lisp/nxhtml/autostart.el")
(setq mumamo-background-colors nil)

(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

;; Yasnippet
;; http://yasnippet.googlecode.com/files/yasnippet-0.6.1c.tar.bz2
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/yasnippet-0.6.1c/"))
(require 'yasnippet)

(setq yas/root-directory '("~/.emacs.d/aj-snippets"
                           "~/.emacs.d/lisp/yasnippet-0.6.1c/snippets"))

;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)

(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt
                             yas/x-prompt
                             yas/no-prompt))

;; (add-to-list 'yas/extra-mode-hooks
;;              'nxml-mode-hook)

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (indent-region yas/snippet-beg
                            yas/snippet-end)))
(set-variable 'yas/trigger-key "")
(set-variable 'yas/wrap-around-region nil)
(yas/initialize)

;; Find-file-not-found-hooks
(setq major-mode 'org-mode)

;; Default to read-only open files
(require 'aj-read-only-keymap-hooks)

;; Insert snippets to bufferts with certain extensions
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
;; Start server
(server-start)
(message "loaded init.el")

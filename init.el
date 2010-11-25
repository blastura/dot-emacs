;; Anton Johansson
;; Time-stamp: "2010-11-21 20:38:45 anton"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/rainbow"))

;; Auto install
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/auto-install.el")
(require 'auto-install)
(setq auto-install-directory (expand-file-name "~/.emacs.d/lisp/auto-install/"))
(add-to-list 'load-path auto-install-directory)

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

;;(auto-install-from-url "http://tromey.com/elpa/package.el")
(require 'package)

;;(auto-install-from-url "http://jblevins.org/git/markdown-mode.git/plain/markdown-mode.el")
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text$\\|\\.markdown$" . markdown-mode) auto-mode-alist))

;;(auto-install-from-url "http://www.xsteve.at/prg/emacs/psvn.el")
(require 'psvn)
(require 'php-mode-improved)

;; (auto-install-from-url "http://github.com/nex3/haml/raw/master/extra/haml-mode.el")
;; (auto-install-from-url "http://github.com/nex3/haml/raw/master/extra/sass-mode.el")
;;(require 'sass-mode)

;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; ;; w3m
;; (add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/w3m"))
;; (require 'w3m-load)
;; (require 'w3m-e21)
;; (provide 'w3m-e23)

;; JDE ;; CEDET needs to be loaded first
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib-1.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb-2.40"))
(require 'aj-cedet)
(require 'ecb-autoloads)
(require 'jde)
(require 'aj-java)

;; Personal
(autoload 'less-mode "less-mode")
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

;;(autoload 'scss-mode "scss-mode")
(require 'scss-mode)
;;(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; Modes
(require 'flymake)
(require 'rainbow-mode)
(require 'anything-config)
;; (require 'magit)
;; (require 'git)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/git-emacs"))
(require 'git-emacs)
(require 'git-status)

;; (auto-install-from-url "http://github.com/juergenhoetzel/babel/raw/STABLE/babel.el")
(require 'babel) ;; Translate with eg Google
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

(load-file "~/.emacs.d/lisp/graphviz-dot-mode.el")

;; Javascript
(autoload 'js2-mode "js2" nil t)

;; File assosiation
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

;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
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

;; Color and style
;; Time-stamp: "2009-10-17 19:03:33 anton"

(when window-system
  (require 'highlight-current-line)
  (highlight-current-line-on t)
  
  (require 'color-theme)
  (color-theme-initialize)
  (load "~/.emacs.d/lisp/color-themes/color-theme-cl-frame.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-tango.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-rlx.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-inkport.el")
  ;;(color-theme-goldenrod) ;;nice and dark
  ;;(color-theme-charcoal-black) ;; grey and blue low sat
    
  (progn (color-theme-jsc-light2) ;;nice and bright
         (highlight-current-line-set-bg-color "light yellow")))
;;   (progn (color-theme-rlx) ;;dark and fine
;;          (highlight-current-line-set-bg-color "black")))

;; Font
(set-default-font "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1" nil)
;;(set-default-font "-apple-bitstream vera sans mono-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
(setq Man-overstrike-face 'woman-bold)

(defun aj-code-mode()
  (interactive)
  ;;(set-default-font "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1" nil)
  (set-default-font "-apple-menlo-medium-r-normal--10-0-72-72-m-0-iso10646-1")
  ;;(set-default-font "-apple-bitstream vera sans mono-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
  
  (setq truncate-lines t)
  (highlight-current-line-set-bg-color "grey11")
  (color-theme-tango))

(defun aj-code-mode-light()
  (interactive)
  (set-default-font "-apple-menlo-medium-r-normal--10-0-72-72-m-0-iso10646-1")
  (setq truncate-lines t)
  (color-theme-jsc-light2)
  
  ;; Some changes
  (highlight-current-line-on t)
  (highlight-current-line-set-bg-color "#ddddcc")

  (custom-set-faces
   ;;'(dired-directory ((t (:foreground "#008800"))))
   '(dired-directory ((t (:inherit font-lock-function-name-face))))
   '(ido-subdir ((t (:inherit font-lock-function-name-face))))
   '(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
   '(ido-first-match-face ((t (:inherit font-lock-string-face))))
   '(minibuffer-prompt ((t (:foreground "black"))))
   '(default ((t (:background "#eeeedd" :foreground "#333344"))))))

(defun aj-text-mode()
  (interactive)
  ;;  (set-default-font "-apple-adobe caslon pro-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (set-default-font "-apple-baskerville-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (highlight-current-line-set-bg-color "grey88")
  (progn (color-theme-jsc-light2) ;;dark and fine
         (highlight-current-line-set-bg-color "grey93"))
  (custom-set-faces
   '(flymake-warnline ((((class color)) (:underline "yellow"))))
   '(flyspell-duplicate ((t (:underline "Gold3"))))
   '(flyspell-incorrect ((t (:underline "OrangeRed"))))))


;; From http://sachachua.com/wp/2006/09/15/emacs-changingn-the-font-size-on-the-fly/
(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

(provide 'aj-color)
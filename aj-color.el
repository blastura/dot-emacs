;; Color and style
;; Time-stamp: "2010-09-18 23:32:38 anton"

(when window-system
  (require 'highlight-current-line)
  (highlight-current-line-on t)
  (set-variable 'default-indicate-empty-lines t)
  
  (require 'color-theme)
  (color-theme-initialize)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-themes"))
  (load "~/.emacs.d/lisp/color-themes/color-theme-cl-frame.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-tango.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-rlx.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-inkport.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-wombat.el")
  (autoload 'zenburn "zenburn" "Color-theme-zenburn." t)
  ;;(color-theme-goldenrod) ;;nice and dark
  ;;(color-theme-charcoal-black) ;; grey and blue low sat
  (set-frame-font "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1" nil)
  
  
  ;; (progn (color-theme-jsc-light2) ;;nice and bright
  ;;        (highlight-current-line-set-bg-color "light yellow"))
  (zenburn)
  (custom-set-faces
   '(cursor ((t (:background "red"))))))
;;   (progn (color-theme-rlx) ;;dark and fine
;;          (highlight-current-line-set-bg-color "black")))

(defun aj-color-org-levels()
  (interactive)
  (let ((i 0)
        (faces (list
                font-lock-type-face
                font-lock-constant-face
                font-lock-string-face
                font-lock-builtin-face
                font-lock-function-name-face
                font-lock-keyword-face
                font-lock-comment-delimiter-face
                )))
    (dolist (level org-level-faces)
      (set-face-foreground level (face-foreground (nth i faces)))
      (setq i (% (+ i 1) (length faces)))
      )))
;; (aj-color-org-levels)

;; Font
;;(set-frame-font "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1" nil)
;;(set-frame-font "-apple-bitstream vera sans mono-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
(setq Man-overstrike-face 'woman-bold)

(defun aj-code-mode()
  (interactive)
  (set-frame-font "-apple-monaco-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
  ;;(set-frame-font "-apple-menlo-medium-r-normal--10-0-72-72-m-0-iso10646-1")
  ;;(set-frame-font "-apple-bitstream vera sans mono-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
  (color-theme-wombat)
  (custom-set-faces
   '(cursor ((t (:background "red")))))

  (setq truncate-lines t)
  (highlight-current-line-set-bg-color "black"))

(defun aj-code-mode-light()
  (interactive)
  (set-frame-font "-apple-monaco-medium-r-normal--10-0-72-72-m-0-iso10646-1" nil)
  ;;(set-frame-font "-apple-menlo-medium-r-normal--10-0-72-72-m-0-iso10646-1")
  (setq truncate-lines t)
  (color-theme-jsc-light2)
  
  ;; Some changes
  (highlight-current-line-on t)
  (highlight-current-line-set-bg-color "#ddddcc")
  
  (setq-default mode-line-buffer-identification
              (list (propertize "%12b" 'face
                                (list :weight 'bold
                                      :foreground "Orchid"))))
    
  (custom-set-faces
   ;;'(dired-directory ((t (:foreground "#008800"))))
   '(dired-directory ((t (:inherit font-lock-function-name-face))))
   '(ido-subdir ((t (:inherit font-lock-function-name-face))))
   '(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
   '(ido-first-match ((t (:inherit font-lock-string-face))))
   '(ido-first-match-face ((t (:inherit font-lock-string-face))))
   '(minibuffer-prompt ((t (:foreground "black"))))
   '(nxml-element-local-name ((t (:foreground "#07C" ))))
   '(nxml-tag-delimiter ((t (:inherit nxml-element-local-name))))
   '(nxml-attribute-local-name ((t (:foreground "#7C0" ))))
   '(nxml-attribute-value ((t (:inherit font-lock-string-face))))
   '(default ((t (:background "#eeeedd" :foreground "#333344"))))))

(defun aj-text-mode()
  (interactive)
  ;;  (set-frame-font "-apple-adobe caslon pro-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (set-frame-font "-apple-baskerville-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  (highlight-current-line-set-bg-color "grey88")
  (progn (color-theme-jsc-light2) ;;dark and fine
         (highlight-current-line-set-bg-color "grey93"))
  (custom-set-faces
   '(minibuffer-prompt ((t (:foreground "black"))))
   '(dired-directory ((t (:inherit font-lock-function-name-face))))
   '(ido-subdir ((t (:inherit font-lock-function-name-face))))
   '(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
   '(ido-first-match ((t (:inherit font-lock-string-face))))
   '(ido-first-match-face ((t (:inherit font-lock-string-face))))
   '(flymake-warnline ((((class color)) (:underline "yellow"))))
   '(flyspell-duplicate ((t (:underline "Gold3"))))
   '(flyspell-incorrect ((t (:underline "OrangeRed"))))))

;; http://xahlee.org/emacs/emacs_make_modern.html
(defun toggle-line-spacing ()
"Toggle line spacing between no extra space to extra half line height."
(interactive)
(if (eq line-spacing nil)
    (setq-default line-spacing 0.2) ; add 0.5 height between lines
  (setq-default line-spacing nil)   ; no extra heigh between lines
  ))
(global-set-key (kbd "<f7>") 'toggle-line-spacing)

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


;; From http://www.emacswiki.org/emacs/HexColour
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{3,6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background 
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords))

(provide 'aj-color)
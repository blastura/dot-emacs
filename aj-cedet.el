(load-file (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common/cedet.el"))

(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu
(setq semantic-idle-summary-mode nil)
;;(semantic-tag-folding-mode t)

;; Put tmp files in own dir
(make-directory "~/.emacs.d/semanticCache" t)
(setq semanticdb-default-save-directory "~/.emacs.d/semanticCache")

(provide 'aj-cedet)
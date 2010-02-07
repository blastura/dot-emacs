;; CSS
;; Time-stamp: "2009-10-29 22:52:41 anton"

;; C-style indentation
(setq cssm-indent-function #'cssm-c-style-indenter)

(defun aj-css-mode-hook()
  (flymake-mode t))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(provide 'aj-css)
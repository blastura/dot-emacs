;; Fixar inte riktigt extern int ...
;; (defun flymake-c-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "gcc" (list "-Wall" "-std=c99" "-pedantic" local-file))))

(defun flymake-c-init ()
  (list "make"
        (list "-s" "-C"
              (flymake-find-buildfile "Makefile" "."))))

(push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

;; (add-hook 'c-mode-hook
;;           '(lambda ()
;;              (flymake-mode t)))

(provide 'aj-flymake-c)
(defconst css-validator-path "/Users/anton/bin/css-validator")

(defun flymake-css-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list css-validator-path (list "-output gnu" (concat "file:" local-file)))))

(push '(".+\\.css$" flymake-css-init) flymake-allowed-file-name-masks)

(push '("Line : \\([0-9]+\\)" nil 1 nil) flymake-err-line-patterns)

(provide 'aj-flymake-css)

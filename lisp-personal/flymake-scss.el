(defconst scss-validator "sass")

(defun flymake-scss-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list scss-validator (list "--scss" "--check" local-file))))

(push '(".+\\.scss$" flymake-scss-init) flymake-allowed-file-name-masks)

;;'("on line \\([0-9]+\\) of \\([^ ]+\\)$" 2 1 nil 2 nil)

;;;; TODO: Not possible to have multiline regexs in flymake-err-line-patterns?
;; '("Syntax error:\s*\\(.*\\)\n\s*on line\s*\\([0-9]+\\) of \\([^ ]+\\)$" 3 2 nil 1)
(push '("on line \\([0-9]+\\) of \\([^ ]+\\)$" 2 1 nil 2) flymake-err-line-patterns)

(provide 'flymake-scss)

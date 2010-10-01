;; http://jigsaw.w3.org/css-validator/DOWNLOAD.html
(defconst css-validator (expand-file-name "~/bin/css-validator"))
(defconst css-validator-profile "css3")

(defun flymake-css-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list css-validator (list "-output" "gnu" "-profile" css-validator-profile (concat "file:" local-file)))))

(push '(".+\\.css$" flymake-css-init) flymake-allowed-file-name-masks)

(push '("^file:\\([^:]+\\):\\([^:]+\\):\\(.*\\)" 1 2 nil 3) flymake-err-line-patterns)

(provide 'aj-flymake-css)

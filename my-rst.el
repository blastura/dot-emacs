;; Rst
;; Time-stamp: "2008-05-12 23:58:28 anton"

(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("rst") t) "\\'")
                   'rst-mode))

(provide 'my-rst)
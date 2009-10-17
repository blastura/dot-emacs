;; Rst
;; Time-stamp: "2009-10-17 19:03:11 anton"

(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("rst") t) "\\'")
                   'rst-mode))

(provide 'aj-rst)
(speedbar-add-supported-extension ".js")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.js" . speedbar-parse-c-or-c++tag))

(provide 'aj-speedbar)
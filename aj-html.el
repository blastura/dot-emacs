;; Html, xml
;; Time-stamp: "2009-10-17 19:03:20 anton"

(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("html" "xhtml" "xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                   'nxml-mode))

(when (boundp 'magic-mode-alist)
  (setq magic-mode-alist
        (cons '("<?xml " . nxml-mode)
              magic-mode-alist)))

(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)

(defun aj-nxml-mode-hook()
  (setq truncate-lines t))
(add-hook 'nxml-mode-hook 'aj-nxml-mode-hook)

(defun insert-xhtml-template ()
  "inserts xhtml template"
  (interactive)
  (nxml-mode)
  (goto-line 1)
  (insert
   (concat
    "<?xml version=\"1.0\" encoding=\"utf-8\"?>
          <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
          \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
           <html xmlns=\"http://www.w3.org/1999/xhtml\">
           <head>
           <!-- Time-stamp: \"" (format-time-string "%c") "\" -->
           <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />
           <meta name=\"author\" content=\""
           (user-full-name)
           "\" />
           <title></title>
           </head>
           <body>
           </body>
           </html>"))
  (mark-whole-buffer)
  (indent-region (region-beginning) (region-end) nil)
  (search-forward "title>"))

;; Snatched from Benjamin Ferrari http://blog.bookworm.at/
(defun aj-nxml-pretty (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Done!"))

(provide 'aj-html)
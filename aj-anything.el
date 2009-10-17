(set-variable 'anything-c-adaptive-history-file "~/.emacs.d/autosave/anything-c-adaptive-history-file")

;; Choose from ./lisp/anything-config.el
(setq anything-sources
      '(anything-c-source-ffap-guesser
        ;;anything-c-source-imenu ;;(Imenu)
        anything-c-source-ctags ;;(Exuberant ctags)
        anything-c-source-semantic ;;(Semantic Tags)
        anything-c-source-simple-call-tree-functions-callers ;;(Function is called by)
        anything-c-source-simple-call-tree-callers-functions ;;(Function calls)
        anything-c-source-commands-and-options-in-file ;;(Commands/Options in file)

        anything-c-source-buffers+
        anything-c-source-file-name-history
        anything-c-source-files-in-current-dir+
        anything-c-source-occur
        anything-c-source-info-pages
        anything-c-source-emacs-commands
        ;;anything-c-source-locate
        ;;anything-c-source-info-elisp
        ;;anything-c-source-man-pages
        ;;anything-c-source-buffer-not-found
        ))

(provide 'aj-anything)

;; Original
;; (anything-c-source-ffap-guesser
;;  anything-c-source-recentf
;;  anything-c-source-buffers+
;;  anything-c-source-bookmarks
;;  anything-c-source-file-cache
;;  anything-c-source-files-in-current-dir+
;;  anything-c-source-locate)
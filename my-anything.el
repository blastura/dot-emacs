(set-variable 'anything-c-adaptive-history-file "~/.emacs.d/autosave/anything-c-adaptive-history-file")

(setq anything-sources
      '(anything-c-source-buffers
        anything-c-source-file-name-history
        anything-c-source-files-in-current-dir
        anything-c-source-occur
        anything-c-source-info-pages
        anything-c-source-locate
        anything-c-source-emacs-commands
        ;;anything-c-source-info-elisp
        anything-c-source-man-pages
        ;;anything-c-source-buffer-not-found
        ))

(provide 'my-anything)

;; Original
;; (anything-c-source-ffap-guesser
;;  anything-c-source-recentf
;;  anything-c-source-buffers+
;;  anything-c-source-bookmarks
;;  anything-c-source-file-cache
;;  anything-c-source-files-in-current-dir+
;;  anything-c-source-locate)
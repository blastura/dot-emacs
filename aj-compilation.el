;; Compilation mode
;; Compilation ;;;;;;;;;;;;;;;;;;;;;;;;;
(setq compilation-scroll-output t)
;;(setq compilation-window-height nil)


(defvar aj-compilation-saved-window-configuration nil
  "Previous window conf from before a compilation")

(defvar aj-compile-command ""
  "The compile command used by compilation-start since
  `compile-command' is only saved by `compile' command.")

;; Hide *compilation* buffer is compile didn't give erros
;; compilation-start  command comint
(defadvice compilation-start (before aj-compilation-save-window-configuration(command comint))
  "Save window configuration before compilation in
`aj-compilation-saved-window-configuration'"

  ;; compile command is not saved in compilation-start function only in
  ;; compile function (rgrep only uses compilation-start)
  (setq aj-compile-command command)
  ;; Save window configuration
  (setq aj-compilation-saved-window-configuration
        (current-window-configuration)))
(ad-activate 'compilation-start)

;; compilation-handle-exit returns (run-hook-with-args
;; 'compilation-finish-functions cur-buffer msg) Could use but it only
;; got a string describing status
(defadvice compilation-handle-exit
  (after aj-compilation-exit-function(process-status exit-status msg))
  "Hack to restore window conf"
  ;; (print "================ START ANton debug ================")
  ;; (print process-status)
  ;; (print exit-status)
  ;; (print msg)
  ;; (print compile-command)
  ;; (print aj-compile-command)
  ;; (print "================ END ANton debug ================")
  
  ;; TODO: fgly
  ;; Howto test for nil and 0 zerop doesn't
  ;; find is used by rgrep don't hide buffer
  (let ((hide (string-match "find" aj-compile-command)))
    (when (and (eq process-status 'exit)
               (zerop exit-status)
               ;; Not nil and not 0 means that command was "find" at
               ;; pos 0 which means that I don't want to restore the
               ;; layout
               (not (and (integerp hide) (zerop hide))))
      (set-window-configuration aj-compilation-saved-window-configuration))))
(ad-activate 'compilation-handle-exit)

;; (setq compilation-finish-functions nil)
;; (setq compilation-finish-functions (lambda(buff msg)
;;       (print (concat "compilation-finish-functions msg: " msg))))


;; ;; (setq compilation-start-hook nil)
;; (add-hook 'compilation-start-hook
;;           (lambda(process)
;;             (setq aj-compilation-saved-window-configuration
;;                   (current-window-configuration))
;;             (print aj-compilation-saved-window-configuration)
;;             ))

;; ;; (setq compilation-process-setup-function nil)
;; (setq compilation-process-setup-function
;;       (lambda()
;;         (setq aj-compilation-saved-window-configuration
;;               (current-window-configuration))                                           
;;         ))

;; ;; Close the compilation window if there was no error at all.
;; ;; (setq compilation-exit-message-function nil)
;; (setq compilation-exit-message-function
;;       (lambda (status code msg)
;;         ;; If M-x compile exists with a 0
;;         (when (and (eq status 'exit) (zerop code))
;;           ;; ;; then bury the *compilation* buffer, so that C-x b doesn't go there
;;           ;; (bury-buffer "*compilation*")
;;           ;; ;; and return to whatever were looking at before
;;           ;; (replace-buffer-in-windows "*compilation*")
;;           (message "anton ____ restore window conf")
;;           ;; Restore saved window conf
;;           (print aj-compilation-saved-window-configuration)
;;           ;; Compilation is not fully finished, this causes insertion
;;           ;; of status from compilation in wrong buffer.
;;           (set-window-configuration aj-compilation-saved-window-configuration))
;;         ;; Always return the anticipated result of compilation-exit-message-function
;;         (cons msg code)))

(provide 'aj-compilation)
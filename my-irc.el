;; Irc
;; Time-stamp: "2009-03-06 23:05:35 anton"

(eval-after-load 'rcirc '(require 'rcirc-notify))

(add-hook 'rcirc-mode-hook
          (lambda ()
            (flyspell-mode 1)
            (set (make-local-variable 'scroll-conservatively)
                 8192)))

(setq rcirc-default-nick "blastura")

(setq rcirc-startup-channels-alist
      '(("\\.freenode\\.net$" "#emacs" "#svn")))

(eval-after-load 'rcirc
  '(defun-rcirc-command reconnect (arg)
     "Reconnect the server process."
     (interactive "i")
     (unless process
       (error "There's no process for this target"))
     (let* ((server (car (process-contact process)))
            (port (process-contact process :service))
            (nick (rcirc-nick process))
            channels query-buffers)
       (dolist (buf (buffer-list))
         (with-current-buffer buf
           (when (eq process (rcirc-buffer-process))
             (remove-hook 'change-major-mode-hook
                          'rcirc-change-major-mode-hook)
             (if (rcirc-channel-p rcirc-target)
                 (setq channels (cons rcirc-target channels))
               (setq query-buffers (cons buf query-buffers))))))
       (delete-process process)
       (rcirc-connect server port nick
                      rcirc-default-user-name
                      rcirc-default-user-full-name
                      channels))))

(provide 'my-irc)
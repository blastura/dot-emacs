(require 'flymake)
(defconst ecj-jar-path "/Users/anton/.emacs.d/java/ecj-3.5.1.jar")

;; TODO fix hardcoded 1.6, from jde-jdk
(defvar flymake-java-version "1.6")

;; To display current classpath from build.xml
;; <target name="show-classpath">
;;    <property name="classpath" refid="project.classpath"/>
;;    <echo message="classpath= ${classpath}"/>
;; </target>

(defun flymake-java-ecj-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-ecj-create-temp-file))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "java" (list "-jar" ecj-jar-path "-Xemacs" "-d" "none" 
                       ;; "-warn:none"
                       "-warn:+over-ann,uselessTypeCheck";;,allJavadoc"
                       "-source" flymake-java-version "-target" flymake-java-version "-proceedOnError"
                       "-classpath" (jde-build-classpath jde-global-classpath)
                       ;; "-log" "c:/temp/foo.xml"
                       local-file))))

(defun flymake-java-ecj-cleanup ()
  "Cleanup after `flymake-java-ecj-init' -- delete temp file and dirs."
  (flymake-safe-delete-file flymake-temp-source-file-name)
  (when flymake-temp-source-file-name
    (flymake-safe-delete-directory (file-name-directory flymake-temp-source-file-name))))
 
(defun flymake-ecj-create-temp-file (file-name prefix)
  "Create the file FILE-NAME in a unique directory in the temp directory."
  (file-truename (expand-file-name (file-name-nondirectory file-name)
                                   (expand-file-name  (int-to-string (abs (random))) (flymake-get-temp-dir)))))
    
(push '(".+\\.java$" flymake-java-ecj-init flymake-java-ecj-cleanup) flymake-allowed-file-name-masks)

(provide 'aj-flymake-java)

;; EOC

;; Start flymake from credmp

;; (defun flymake-java-ecj-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'jde-ecj-create-temp-file))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     ;; Change your ecj.jar location here
;;     (list "java" (list "-jar" "/Users/anton/.emacs.d/java/ecj.jar" "-Xemacs" "-d" "/dev/null"
;;                        "-source" "1.6" "-target" "1.6" "-proceedOnError"
;;                        "-warn:+over-ann,uselessTypeCheck" ;;,allJavadoc
;;                        "-sourcepath" (car jde-sourcepath) "-classpath" 
;;                        (jde-build-classpath jde-global-classpath) local-file))))

;; (defun flymake-java-ecj-cleanup ()
;;   "Cleanup after `flymake-java-ecj-init' -- delete temp file and dirs."
;;   (flymake-safe-delete-file flymake-temp-source-file-name)
;;   (when flymake-temp-source-file-name
;;     (flymake-safe-delete-directory (file-name-directory flymake-temp-source-file-name))))

;; (defun jde-ecj-create-temp-file (file-name prefix)
;;   "Create the file FILE-NAME in a unique directory in the temp directory."
;;   (file-truename (expand-file-name (file-name-nondirectory file-name)
;;                                    (expand-file-name  (int-to-string (random)) (flymake-get-temp-dir)))))
 
;; (push '(".+\\.java$" flymake-java-ecj-init flymake-java-ecj-cleanup) flymake-allowed-file-name-masks)
 
;; (push '("\\(.*?\\):\\([0-9]+\\): error: \\(.*?\\)\n" 1 2 nil 2 3 (6 compilation-error-face)) compilation-error-regexp-alist)
 
;; (push '("\\(.*?\\):\\([0-9]+\\): warning: \\(.*?\\)\n" 1 2 nil 1 3 (6 compilation-warning-face)) compilation-error-regexp-alist)

;; ;; From http://www.credmp.org/2007/07/20/on-the-fly-syntax-checking-java-in-emacs/
;; (defun aj-flymake-display-err-minibuf () 
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no             (flymake-current-line-no))
;;          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count               (length line-err-info-list))
;;          )
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)
;;           )
;;         )
;;       (setq count (1- count)))))

;; End flymake from credmp
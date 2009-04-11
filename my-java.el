;; Java
;; Time-stamp: "2008-11-08 14:24:39 anton

;; Flymake JDE

(require 'my-flymake-java)
;; Start eclipse compiler server
;; ================================
;; (require 'jde-eclipse-compiler-server)
;; (set-variable 'jde-ecj-command-line-args '("-d" "none" "-1.6"))
;; (set-variable 'jde-compiler '(("eclipse java compiler server" "/Users/anton/.emacs.d/java/ecj.jar")))
;; (push '(".+\\.java$" jde-ecj-flymake-init jde-ecj-flymake-cleanup) flymake-allowed-file-name-masks)
;; ==============================
;; End eclipse compiler server

;; JDE
(setenv "JAVA_HOME" "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home")

(custom-set-variables
 '(jde-jdk-registry (quote (("1.6" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6"))))
 '(jde-jdk (quote ("1.6"))))

(set-variable 'jde-jdk-doc-url "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/docs/api/allclasses-noframe.html")
(set-variable 'jde-complete-function 'jde-complete-minibuf)
(set-variable 'jde-build-function '(jde-ant-build))
(set-variable 'jde-ant-read-target t)
(set-variable 'jde-ant-enable-find t)
(set-variable 'jde-ant-complete-target t)

(set-variable 'jde-sourcepath '("./src" ".")) ;; Used in eg find Class at symbol

(set-variable 'jde-global-classpath '("./bin/main" "./bin/test" "./bin"))

(defun my-jde-mode-hook ()
  (set-variable 'senator-minor-mode-hook nil)
  (setq jde-enable-abbrev-mode nil)
  (setq jde-gen-cflow-enable nil)
  (local-set-key (kbd "C-<return>") 'jde-build)
  
  (local-set-key "'" 'skeleton-pair-insert-maybe)
  (local-set-key "\"" 'skeleton-pair-insert-maybe)
  (local-set-key "[" 'skeleton-pair-insert-maybe)
  (local-set-key "(" 'skeleton-pair-insert-maybe)
  (local-set-key "{" 'skeleton-pair-insert-maybe)
  (set-variable 'skeleton-pair t)
  (setq fill-column 80)
  (setq c-basic-offset 4);; Tab indent 4 spaces
  ;;(c-set-offset 'inline-open 0)
  (abbrev-mode nil)
  (flymake-mode t)
  (toggle-truncate-lines nil))
(add-hook 'jde-mode-hook 'my-jde-mode-hook)

(defun my-ant-find-build-file (dir)
  "Find the next Ant build file upwards in the directory tree from DIR.
Returns nil if it cannot find a project file in DIR or an
ascendant directory.  The parameter dir should be an empty string
if check should be performed on current dir.
  TODO - name build.xml is hardcoded"
  (let ((file (find "build.xml" (directory-files dir) :test 'string=)))
    (if file
        (setq file (expand-file-name file dir))
      (if (not (jde-root-dir-p dir))
          (setq file (jde-ant-find-build-file (concat dir "../")))))
    file))

(defun my-get-classpath()
  "To use in prj.el jde project files: (set-variable
'jde-global-classpath (get-cp)) will search for build.xml with
ant -find build.xml. Special target in build.xml must be defined:

<target name=\"print-classpath\">
    <property name=\"classpath\" refid=\"project.classpath\"/>
    <echo message=\"-classpath-${classpath}-classpath-\"/>
</target>

Where project.classpath is the id of the tag path where classpath
is defined.
"
  ;; (message (concat "get-cp, dir is:  "(pwd)))
  ;; (message (concat "get-cp, buildfile is:  " (my-ant-find-build-file "")))
  (let* ((pattern "-classpath-")
         (out-string (shell-command-to-string "ant -q -find build.xml print-classpath"))
         (point-start (+ (length pattern) (string-match pattern out-string)))
         (point-end (string-match pattern out-string point-start))
         (class-string (substring out-string point-start point-end)))
    (split-string  class-string ":")))
  
;; Other java
(defun java-compile()
  "comiles current buffer with javac"
  (interactive)
  (compile (concat "javac " (buffer-name))))
(defalias 'javac 'java-compile)

(defun java-compile-all()
  "comiles current buffer with javac"
  (interactive)
  (compile "javac *.java"))
(defalias 'javac-all 'java-compile-all)

(defun java-run()
  "TODO: interactive args.
Runs current buffer with java"
  (interactive)
  (shell-command
   (concat "java "
           (first (split-string (buffer-name)
                                ".java")))))

(defun insert-java-template()
  "inserts standard java-class structure"
  (interactive)
  (java-mode)
  (insert (concat "public class " (car (split-string (buffer-name) ".java")) " { \n"
                  "public "(car (split-string (buffer-name) ".java")) "() {\n"
                  "}\n"
                  "}\n"))
  (mark-whole-buffer)
  (indent-region (region-beginning) (region-end) nil)
;;(jdok-generate-javadoc-template)
  (goto-line 1)
  (insert (concat "/*\n"
                  " * @(#)" (buffer-name) "\n"
                  " * Time-stamp: \"" (format-time-string "%c") "\"\n"
                  " */\n\n")))

(provide 'my-java)
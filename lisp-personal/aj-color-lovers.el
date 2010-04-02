;; http://www.colourlovers.com/api/palettes/random

(defun aj-print-color-lovers (url)
  "Get and print colors from `url'"
  (interactive)
  (aj-parse-palettes (aj-color-lovers-url-retrieve url)))

(defun aj-get-color-lovers-palettes (url)
  "Retun a list of palettes"
  (xml-get-children (aj-color-lovers-url-retrieve url) 'palette))
;;(aj-get-color-lovers-palettes "http://www.colourlovers.com/api/palette/228150")

(defun aj-get-color-lovers-palettes-colors (url)
  "Retun a list with a list of colors for each palette found in url"
  ;;(dolist (palette (xml-get-children (aj-color-lovers-url-retrieve url) 'palette))
  (mapcar (lambda (palette)
            (let ((colors (xml-node-children (assq 'colors palette)))
                  result)
              ;;(print colors)
              (setq result '())
              (dolist (hex colors)
                (when (listp hex)
                  (message (concat  "Found " "#" (downcase (car (xml-node-children hex)))))
                  (setq result (append result (list (concat  "#" (downcase (car (xml-node-children hex)))))))))
              result))
          (xml-get-children (aj-color-lovers-url-retrieve url) 'palette)))

;;(aj-get-color-lovers-palettes-colors "http://www.colourlovers.com/api/palette/228150")

(defun aj-color-lovers-url-retrieve (url)
  "Returns buffer with content from `url'"
  (let ((tmp (url-retrieve-synchronously url)))
    ;;(message tmp)
    (with-temp-buffer
      (url-insert tmp)
      (car (xml-parse-region (point-min) (point-max))))))

(defun aj-parse-palettes (palettes &optional buffer-name)
  "Parse and print a list of palettes"
  (let* ((node-list (xml-get-children palettes 'palette)))
    (with-output-to-temp-buffer (or buffer-name "*Color-lovers*")
      (save-excursion
        (set-buffer standard-output)
        (setq truncate-lines t)
        (if temp-buffer-show-function
            (aj-print-color-list node-list)
          (add-hook 'temp-buffer-show-hook
                    (lambda () (aj-print-color-list node-list)) nil t))))))

(defun aj-print-color-list (node-list)
  "Print a list of colors"
  (dolist (palette node-list)
    (insert (concat  "==== " (car (xml-node-children (assq 'title palette)))) " ====\n")
    (insert (concat  "userName: " (car (xml-node-children (assq 'userName palette)))) "\n")
    (insert (concat  "url: " (car (xml-node-children (assq 'url palette)))) "\n")
    (insert (concat  "id: " (car (xml-node-children (assq 'id palette)))) "\n")

    ;; Parse <colors>
    (let ((colors (xml-node-children (assq 'colors palette)))
          color)
      (dolist (hex colors)
        (when (listp hex)
          (setq color (concat  "#" (downcase (car (xml-node-children hex)))))
          (put-text-property
           (prog1 (point)
             (insert (concat  "hex: " color "\n")))
           (point) 'face (list ':background color)))))
    (insert "\n")
    (goto-char (point-min))))

;;(aj-print-color-lovers "http://www.colourlovers.com/api/palette/228150")
;;(aj-print-color-lovers "http://www.colourlovers.com/api/palettes/top")

(defun aj-quad (seq)
  "Quads all numbers in `seq' (1 2 3) -> (1 4 9)"
  (mapcar '(lambda (x) (expt x 2)) seq))
;;(aj-quad '(1 2 3))
;;(aj-quad '(2 3 4 5))
;;(aj-quad (list 2 3 4 5))

(defun aj-delta (seq1 seq2)
  (mapcar* '- seq1 seq2))
;; (aj-delta '(1 2 3) '(3 2 1))

(defun aj-sum (seq)
  "Dumb sums of all numbers in `seq'"
  (let ((result 0))
    (dolist (n seq)
      (setq result (+ result n)))
    result))
;; (aj-sum (list 1 2 3))
;; (apply '+ (list 1 2 3))

(defun aj-color-256-bit (color)
  (mapcar (lambda (c) (lsh c -8))
          (if (stringp color)
              (color-values color)
            color)))

;; (aj-color-256-bit "white") ;-> (255 255 255)
;; (aj-color-256-bit "gray") ;-> (190 190 190)
;; (aj-color-256-bit (color-values "white"))

(defun aj-color-to-hex (color)
  (interactive)
  (apply 'format "#%02x%02x%02x"
         (aj-color-256-bit color)))

;; (aj-color-to-hex "white")
;; (aj-color-to-hex (color-values "green"))

(defun aj-euclidean-distance (seq1 seq2)
  (when (and (sequencep seq1) (sequencep seq2)
             (= (length seq1) (length seq2)))
    (sqrt (aj-sum (aj-quad (aj-delta seq1 seq2))))))
;; (aj-euclidean-distance (list 0 0 0) (list 3 4 0))
;; (aj-euclidean-distance (aj-color-256-bit "snow") (aj-color-256-bit "ghost white"))
;; (sort (list 1 2 3) '+)

(defun aj-color-comp (color-name)
  (let ((max-color (car (color-values "white"))))
    (mapcar '(lambda (x) (abs (- x max-color))) (color-values color-name))))

;; (aj-color-comp "red")
;; (list-colors-display (list "green" (aj-color-to-hex (aj-color-comp "green"))))
;; (list-colors-display (list "red" (aj-color-to-hex (aj-color-comp "red"))))
;; (list-colors-display (list "#3322ff" (aj-color-to-hex (aj-color-comp "#3322ff"))))
;; (list-colors-display (list "#38665e" (aj-color-to-hex (aj-color-comp "#38665e"))))

;; red -> green and blue (255 0 0) (0 255 0) (0 0 255)
;; (255 50 0)
;; (0 255 50)
;; (50 0 255)
;; (setq color-name "red")
(defun aj-color-triad (color-name)
  "Returns two opposing colors red -> blue and green"
  (let* ((c1 (append (cdr (color-values color-name)) (list (car (color-values color-name)))))
        (c2 (append (cdr c1) (list (car c1)))))
    (list c1 c2)))

;; (aj-color-triad "blue")
;; (list-colors-display (cons "green" (mapcar 'aj-color-to-hex (aj-color-triad "green"))))
;; (list-colors-display (cons "red" (mapcar 'aj-color-to-hex (aj-color-triad "red"))))
;; (list-colors-display (cons "#332233" (mapcar 'aj-color-to-hex (aj-color-triad "#332233"))))
;; (list-colors-display (cons "#8566ff" (mapcar 'aj-color-to-hex (aj-color-triad "#8566ff"))))

;; 10 20 30
;; --------
;; 30 20 10
;; 20 30 10
;; 20 10 30


(defun aj-color-tetriad (color-name)
  "Returns two opposing colors red -> blue and green"
  (let* ((c1 (append (cdr (color-values color-name)) (list (car (color-values color-name)))))
        (c2 (append (cdr c1) (list (car c1)))))
    (list c1 c2)))

;; (defun aj-delta-list (list1 list2)
;;   (when (and (listp list1)
;;              (listp list2)
;;              (= (length list1) (length list2)))
;;     (loop for i in list1
;;           collect (- i (pop list2))
;;           )))


;; Set org-level-* face [1-8]

;;(setq lst (car (aj-get-color-lovers-palettes-colors "http://www.colourlovers.com/api/palette/84625")))
(defun aj-set-org-level-faces (lst)
  (let ((i 0))
    (dolist (level org-level-faces)
      (set-face-foreground level (nth i lst))
      (setq i (% (+ i 1) (length lst)))
      )))
;;(aj-set-org-level-faces cls)

;; (require 'hexrgb)
(defun aj-set-org-level-faces-fade-from-type-face ()
  (interactive)
  (let ((face-hsv (hexrgb-hex-to-hsv (face-foreground font-lock-keyword-face))))
    (dolist (level org-level-faces)
      (print level)
      (print face-hsv)
      (print "================")
      ;; Set face foreground
      (set-face-foreground level (apply 'hexrgb-hsv-to-hex face-hsv))

      ;; Change face-hsv
      (setq face-hsv (list (mod (+ 0.1 (nth 0 face-hsv)) 1) ;; Hue
                           (mod (+ -0.05 (nth 1 face-hsv)) 1) ;; Saturation
                           (mod (+ -0.005 (nth 2 face-hsv)) 1))))))
;; (aj-set-org-level-faces-fade-from-type-face)

(defun aj-set-org-level-faces-from-current-theme ()
(interactive)
  (let ((i 0)
        (faces (list
                font-lock-type-face
                font-lock-keyword-face
                font-lock-builtin-face
                font-lock-function-name-face
                font-lock-string-face
                font-lock-constant-face
                font-lock-comment-delimiter-face
                )))
    (dolist (level org-level-faces)
      (set-face-foreground level (face-foreground (nth i faces)))
      (setq i (% (+ i 1) (length faces)))
      )))
(aj-set-org-level-faces-from-current-theme)
;;(face-background 'default)

(provide 'aj-color-lovers)
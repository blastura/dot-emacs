;;; less-mode.el 

;; Copyright (C) 2002 - 2015 Anton Johansson <anton.johansson@gmail.com>

;; Command lessc is required @see : http://lesscss.org/
;; To install lessc do : sudo gem install less

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; Homepage: http://antonj.se
;; Created: 28 Oct 2002
;; Last modified: 15 Feb 2005
;; Version: 0.3.3
;; Keywords: mode css less

;;;###autoload
(require 'derived)

;;;###autoload
(define-derived-mode less-mode css-mode "Less"
  "Major mode for editing Less files."
  (add-hook 'local-write-file-hooks 'less-parse)
)

(defun less-parse()
  (save-excursion
    (shell-command (concat "lessc " (buffer-name) "&") nil "*Less errors*"))
  nil) ;; Return nil to not interrupt saving process

(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

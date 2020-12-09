;;;###autoload
(defun graphic-p ()
  "判断当前环境是否为图形环境"
  (if (display-graphic-p)
	  t))

;; 切换透明
;;;###autoload
(defun +evan/toggle-transparency ()
  "把frame-parameter在(92 . 92)和(100 . 100)之间转换"
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
	(set-frame-parameter
	 nil 'alpha
	 (if (eql (cond ((numberp alpha) alpha)
					((numberp (cdr alpha)) (cdr alpha))
					;; Also handle undocumented (<active> <inactive>) form.
					((numberp (cadr alpha)) (cadr alpha)))
			  100)
		 '(92 . 92) '(100 . 100)))))

(provide '+autoload)


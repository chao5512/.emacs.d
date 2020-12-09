;; 图形化插件特殊设置
;; (add-hook 'after-make-frame-functions
;; 		  (lambda (new-frame)
;; 			(select-frame new-frame)
;; 			(dolist (elisp-code graphic-only-plugins-setting)
;; 			  (eval elisp-code))))

(message "graphic-p: %s" (graphic-p))
(when (graphic-p)
  (dolist (elisp-code graphic-only-plugins-setting)
			  (eval elisp-code)))

(provide 'init-graphic)

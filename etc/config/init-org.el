(require 'org-capture)
(require 'org-tempo)

(use-package 
  org 
  :ensure t
  :bind
  ;;("C-c c" . 'org-capture)
  ;;("C-c a" . 'org-agenda)
  :config
  ;;('org-mode . 'toggle-truncate-lines)	 
  (org-indent-mode t)

;; 设置org-babel支持运行的代码
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))


;;(set-face-attribute 'org-table nil :font (font-spec :name evan/font-name
;;                                                    :size evan/font-size
;;													;; :style "Regular"
;;													))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 美化org										  ;;
;; (use-package 									  ;;
;;   org-bullets									  ;;
;;   :ensure t										  ;;
;;   :hook ('org-mode . 'org-bullets-mode)			  ;;
;;   :custom										  ;;
;;   (org-bullets-bullet-list '("☰" "☷" "✿" "☭")))	  ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'init-org)

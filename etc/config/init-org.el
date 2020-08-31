(require 'org-capture)

(use-package 
  org 
  :ensure t
  ;; ('org-mode . 'toggle-truncate-lines)	 
  :bind
  ("C-c c" . 'org-capture)
  ("C-c a" . 'org-agenda)
  :custom
  (org-todo-keywords '((sequence "[学习](s!/@)" "[待办](t!/@)" "[等待](w!))" "|" "[完成](d!/@)" "[取消](c!@)")
                       (sequence "[BUG](b!/@)" "[新事件](i@)" "[已知问题](k!/@)" "[修改中](W!/@)" "|" "[已修复](f!)")))
  (org-todo-keyword-faces '(("[学习]" . (:foreground "white" :background "#2ECC71" :weight bold))
                            ("[待办]" . (:foreground "white" :background "#F1C40F" :weight bold))
                            ("[等待]" . (:foreground "white" :background "#3498DB" :weight bold))
                            ("[完成]" . (:foreground "white" :background "#566573 " :weight bold))
                            ("[取消]" . (:foreground "white" :background "#566573" :weight bold))
                            ("[BUG]" . (:foreground "white" :background "#E74C3C" :weight bold))
                            ("[新事件]" . (:foreground "white" :background "#D35400" :weight bold))
                            ("[已知问题]" . (:foreground "white" :background "#17A589" :weight bold))
                            ("[修改中]" . (:foreground "white" :background "#BB8FCE" :weight bold))
                            ("[已修复]" . (:foreground "white" :background "#566573" :weight bold))))
  :config
  (defun evan/capture-word ()
	(interactive)
	(setq-local capture-word-item nil)
	(setq evan/capture-word-data nil)
	(let* ((word (youdao-dictionary--request (if (not (thing-at-point 'word))
												 nil
											   (thing-at-point 'word))))
		   (basic (youdao-dictionary--explains word))
		   (eng (assoc-default 'query word)))
	  (dotimes (i (map-length basic))
		(let* ((explain (map-elt basic i)) ;; 所有说明
			   ;; 词性
			   (type (progn (string-match "[a-zA-Z]+" explain)
							(concat (match-string 0 explain) ".")))
			   ;; 中文翻译
			   (chinese (progn (string-match "[\u4e00-\u9fa5；，]+" explain)
							   (match-string 0 explain))))
		  (push (concat "|" eng "|" type "|" chinese "|") capture-word-item))))
	(setq evan/capture-word-data (ivy-read "请选择要插入的词性: " capture-word-item))
	(setq evan/capture-word-data (remove "" (split-string evan/capture-word-data "|")))
	(if (null evan/capture-word-data)
		(message "光标下的单词无法捕获!")
	  (org-capture 1 "f")))

  (defun evan/capture-get-word (number)
	(cond ((eq number 1) (nth 0 evan/capture-word-data))
		  ((eq number 2) (nth 1 evan/capture-word-data))
		  ((eq number 3) (nth 2 evan/capture-word-data))))
  
  (setq org-capture-templates nil)
  (push "~/Documents/org/capture/task.org" org-agenda-files)
  ;; (setq org-time-stamp-formats '("<%Y-%m-%d 周%u %H:%M>"))
  (add-to-list 'org-capture-templates
               '("t" "任务清单"))
  (add-to-list 'org-capture-templates '("tw" "工作任务" entry (file+headline "~/Documents/org/capture/task.org" "Work")
                                        "* [待办] %^{任务名} - %U\n  %a\n  %?" :clock-in t :clock-keep t))
  (add-to-list 'org-capture-templates '("ts" "学习任务" entry (file+headline "~/Documents/org/capture/task.org" "Study")
                                        "* [学习] %^{学习项目} - %U\n  %a\n  %?" :clock-in t :clock-keep t))
  (add-to-list 'org-capture-templates '("j" "我的日志" entry (file+headline"~/Documents/site/org/diary.org" "日志")
                                        "* %U - %^{标题}\n  %?"))
  (add-to-list 'org-capture-templates '("i" "我的闪念" entry (file+headline "~/Documents/site/org/idea.org" "闪念")
                                        "* %U - %^{标题} %^g\n  %?\n"))
  (add-to-list 'org-capture-templates '("k" "我的百科" entry (file+headline "~/Documents/site/org/wiki.org" "WIKI")
                                        "* %^{标题} %t %^g\n  %?\n"))
  (add-to-list 'org-capture-templates '("w" "我的单词" table-line (file+headline "~/Documents/org/capture/word.org" "Words")
                                        " | %U | %^{en_US} | %^{词性} | %^{zh_CN} |"))
  (add-to-list 'org-capture-templates '("f" "单词速导" table-line (file+headline "~/Documents/org/capture/word.org" "Words")
                                        "| %U | %(evan/capture-get-word 1) | %(evan/capture-get-word 2) | %(evan/capture-get-word 3) |"))
  (add-to-list 'org-capture-templates '("l" "超链接" entry (file+headline "~/Documents/org/capture/link.org" "Links")
                                        "* %^{简介} %t %^g\n  %^L\n  %?\n"))
;; 设置org-babel支持运行的代码
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))


(set-face-attribute 'org-table nil :font (font-spec :name evan/font-name
                                                    :size evan/font-size
													;; :style "Regular"
													))

;; 美化org
(use-package 
  org-bullets
  :ensure t
  :hook ('org-mode . 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "✿" "☭"))
  (org-indent-mode))

(provide 'init-org)

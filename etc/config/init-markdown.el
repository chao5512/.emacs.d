;;;===========================================
;;;					模块介绍
;;; MARKDOWN支持，主要是修改了MARKDOWN表格字体
;;;===========================================

;; MODULE: USER INTERFACE 

;; AUTHOR: EvanMeek the_lty_mail@foxmail.com

;; CODE:
(use-package
  markdown-mode+
  :ensure t
  :hook (markdown-mode . (lambda () (require 'markdown-mode+)))
  :config
  (if (fontp (font-spec :name evan/font-name
						:style evan/font-style
						:size evan/font-size))
	  (progn
		(set-face-attribute 'markdown-table-face nil
							:font (font-spec :name evan/font-name
											 :style evan/font-style
											 :size evan/font-size))
		(set-face-attribute 'markdown-url-face nil
							:font (font-spec :name evan/font-name
											 :style evan/font-style
											 :size evan/font-size))
		(set-face-attribute 'markdown-markup-face nil
							:font (font-spec :name evan/font-name
											 :style evan/font-style
											 :size evan/font-size)))
	(message "无法找到%s字体，你可以更换其他字体或安装它让这条消息消失." evan/font-name)))

;; markdown start
 (use-package markdown-mode
   :ensure t
   :mode (("README\\.md\\'" . gfm-mode)
          ("\\.md\\'" . markdown-mode)
          ("\\.markdown\\'" . markdown-mode))
   :init (setq markdown-command "pandoc"))

(provide 'init-markdown)

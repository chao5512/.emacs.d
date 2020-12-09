;;;===========================================
;;;					模块介绍
;;; 用户交互界面模块
;;;===========================================

;; MODULE: USER INTERFACE 

;; AUTHOR: EvanMeek the_lty_mail@foxmail.com

;; CODE:

(setq evan/font-name "Fira Code"
	  evan/font-style "Regular"
	  evan/font-size 22)

;; 设置光标颜色
;; (set-cursor-color "green2")
;; 设置光标样式
(setq-default cursor-type 'bar)
;; 去除默认启动界面
(setq inhibit-startup-message nil)
;; 设置英文字体
(push '(if (fontp (font-spec
				   ;; :name "Fira Code Nerd Font"
				   ;; :style "Retina"
				   :name evan/font-name
				   :style evan/font-style
				   ;; :name "Sarasa Mono SC"
				   ;; :style "Regular"
				   :size evan/font-size)) 
		   (set-face-attribute 'default nil 
							   :font (font-spec
									  :name evan/font-name
									  :style evan/font-style
									  :size evan/font-size)) 
		 (message "无法找到%s字体，你可以更换其他字体或安装它让这条消息消失." evan/font-name)) graphic-only-plugins-setting)

;; 高亮当前行
(global-hl-line-mode 1)

;; 切换buffer焦点时高亮动画
(use-package
  beacon
  :ensure t
  :hook (after-init . beacon-mode))

;; 主题包
 (use-package 
   doom-themes 
   :ensure t
   :defer
   :config (load-theme 'doom-solarized-light t))
   ;;)
;; (use-package
;;   spacemacs-common
;;   :ensure spacemacs-theme
;;   :defer)

;; (use-package base16-theme
;;   :ensure t
;;   :defer)

(use-package modus-operandi-theme
  :ensure t)

(use-package modus-vivendi-theme
  :ensure t)


;; 自动切换主题
(use-package
  circadian
  :ensure t
  :config
  ;; 经纬度，可以在https://www.latlong.net/获取，默认是广州的
  (setq calendar-latitude 39.918163
		calendar-longitude 116.403618)
  ;; sunrise 白天用的主题 sunset 晚上用的主题
  (setq circadian-themes '((:sunrise . doom-solarized-light)
						   (:sunset . doom-soarized-dark)))
  (circadian-setup))


;; 根据时间切换高亮当前行颜色
;; (if (and (> (car (circadian-now-time)) (car (circadian-sunrise)))
;; 		 (< (car (circadian-now-time)) (car (circadian-sunset))))
;; 	(set-face-background 'hl-line "light gray")
;;   (set-face-background 'hl-line "gray17"))

(push '(progn
		 ;; 图标支持
		 (use-package 
		   all-the-icons 
		   :ensure t)
		 ;; dired模式图标支持
		 (use-package 
		   all-the-icons-dired 
		   :ensure t 
		   :hook ('dired-mode . 'all-the-icons-dired-mode))
		 ;; 表情符号
		 (use-package 
		   emojify
		   :ensure t
		   :custom (emojify-emojis-dir "~/.emacs.d/var/emojis")
		   :hook telega-mode)
		 ;; 浮动窗口支持
		 (use-package 
		   posframe 
		   :ensure t)) graphic-only-plugins-setting)

;; 竖线
(use-package 
  page-break-lines 
  :ensure t 
  :config (turn-on-page-break-lines-mode))

;; 启动界面
(use-package dashboard 
  :ensure t 
  :config (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text") 
                                    (bookmarks . "book")))
  ;; 设置标题
  (setq dashboard-banner-logo-title
        "hello chao                  ")
  ;; 设置banner
  (setq dashboard-startup-banner "~/.emacs.d/var/banner/evan-emacs-banner.png") 
  (setq dashboard-center-content t) 
  (setq dashboard-set-heading-icons t) 
  ;; (setq dashboard-set-file-icons t) 
  (setq dashboard-set-navigator t))


;; modeline样式
(use-package 
  doom-modeline
  :ensure t 
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 10)
  (doom-modeline-bar-width 5)
  (doom-modeline-buffer-file-name-style 'file-name)
  :config
  (custom-set-faces '(mode-line ((t 
                                  (:family evan/font-name
                                           :style evan/font-style
                                           :height 125)))) 
                    '(mode-line-inactive ((t 
                                           (:family evan/font-name
                                                    :style evan/font-size
                                                    :height 125))))))
;; 彩虹括号
(use-package 
  rainbow-delimiters 
  :ensure t 
  :config
  ;; 设置每一级括号的颜色
  (set-face-foreground 'rainbow-delimiters-depth-1-face "chartreuse3") 
  (set-face-foreground 'rainbow-delimiters-depth-2-face "DodgerBlue1") 
  (set-face-foreground 'rainbow-delimiters-depth-3-face "DarkOrange2")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "deep pink") 
  (set-face-foreground 'rainbow-delimiters-depth-5-face "medium orchid") 
  (set-face-foreground 'rainbow-delimiters-depth-6-face "turquoise") 
  (set-face-foreground 'rainbow-delimiters-depth-7-face "lime green") 
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gold") 
  (set-face-foreground 'rainbow-delimiters-depth-9-face "cyan") 
  (set-face-bold 'rainbow-delimiters-depth-1-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-2-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-3-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-4-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-5-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-6-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-7-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-8-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-9-face "t") 
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
;; 让info帮助信息中关键字有高亮
(use-package 
  info-colors 
  :ensure t 
  :hook ('Info-selection-hook . 'info-colors-fontify-node))

;; 缩进线
(use-package
  indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

;; 彩虹猫进度条
(use-package nyan-mode
  :ensure t
  :hook (after-init . nyan-mode))

;; 为上层提供 init-ui 模块
(provide 'init-ui)

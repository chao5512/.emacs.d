
(push '(if (file-exists-p "~/.emacs.d/site-lisp/emacs-application-framework") 
		   (use-package eaf
			 :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
			 
			 :custom
			 (eaf-find-alternate-file-in-dired t)
			 ;;(eaf-proxy-type "socks5")
			 ;;(eaf-proxy-host "127.0.0.1")
			 ;;(eaf-proxy-port "1080")
			 (browse-url-browser-function 'eaf-open-browser)
			 
			 :config
			 ;; eaf markdown 预览所需要的
			 (use-package grip-mode
			   :ensure t
			   :after eaf)
			 (defalias 'browse-web #'eaf-open-browser)
			 (setq eaf-grip-token "886f1f1c4aa14fbdc62e7611d471aaceeae7f415")
			 (eaf-setq eaf-pdf-dark-mode "true")
			 (eaf-setq eaf-browser-dark-mode "true") 
			 (eaf-setq eaf-mindmap-dark-mode "true")
			 (eaf-setq eaf-browser-enable-adblocker "true")
			 (eaf-setq eaf-browser-search-engines (list "duckduckgo" "https://duckduckgo.com/?q=%s"))
			 (when (and
					(> (car (circadian-now-time)) (car (circadian-sunrise)))
					(< (car (circadian-now-time)) (car (circadian-sunset))))
			   (progn
				 (eaf-setq eaf-pdf-dark-mode "false")
				 (eaf-setq eaf-browser-dark-mode "false") 
				 (eaf-setq eaf-mindmap-dark-mode "false")))
			 (eaf-setq eaf-browser-default-zoom "1.2")
			 (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding) 
			 (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding) 
			 (eaf-bind-key take_photo "p" eaf-camera-keybinding))
		 (message
		  "你需要下载emacs-application-framework到~/.emacs.d/site-lisp/emacs-application-framework.才能启用EAF")) graphic-only-plugins-setting)

;; 括号匹配，不再使用这个，转为使用smartparens
(use-package 
  awesome-pair
  :disabled 
  :load-path "~/.emacs.d/site-lisp/awesome-pair" 
  :config (dolist (hook (list 'c-mode-common-hook 'c-mode-hook 'c++-mode-hook 'java-mode-hook 'haskell-mode-hook 'emacs-lisp-mode-hook 'lisp-interaction-mode-hook 'lisp-mode-hook 'maxima-mode-hook 'ielm-mode-hook 'sh-mode-hook 'makefile-gmake-mode-hook 'php-mode-hook 'python-mode-hook 'js-mode-hook 'go-mode-hook 'qml-mode-hook 'jade-mode-hook 'css-mode-hook 'ruby-mode-hook 'coffee-mode-hook 'rust-mode-hook 'qmake-mode-hook 'lua-mode-hook 'swift-mode-hook 'minibuffer-inactive-mode-hook)) 
            (add-hook hook '(lambda () 
                              (awesome-pair-mode 1)))) 
  :bind (:map awesome-pair-mode-map
              ("(" . #'awesome-pair-open-round) 
              ("(" . #'awesome-pair-open-round) 
              ("[" . #'awesome-pair-open-bracket) 
              ("{" . #'awesome-pair-open-curly) 
              ("" . #'awesome-pair-close-round) 
              ("]" . #'awesome-pair-close-bracket) 
              ("}" . #'awesome-pair-close-curly) 
              ("=" . #'awesome-pair-equal) 
              ("%" . #'awesome-pair-match-paren) 
              ("\"" . #'awesome-pair-double-quote) 
              ("SPC" . #'awesome-pair-space) 
              ("M-o" . #'awesome-pair-backward-delete) 
              ("C-d" . #'awesome-pair-forward-delete) 
              ("C-k" . #'awesome-pair-kill) 
              ("M-\"" . #'awesome-pair-wrap-double-quote) 
              ("M-[" . #'awesome-pair-wrap-bracket) 
              ("M-{" . #'awesome-pair-wrap-curly) 
              ("M-(" . #'awesome-pair-wrap-round) 
              ("M-)" . #'awesome-pair-unwrap) 
              ("M-p" . #'awesome-pair-jump-right) 
              ("M-n" . #'awesome-pair-jump-left) 
              ("M-:" . #'awesome-pair-jump-out-pair-and-newline)
              ))
;; 括号匹配
(use-package 
  smartparens 
  :ensure t 
  :hook ('prog-mode . 'smartparens-global-mode))

;; 英语拼写助手，默认不开启
(use-package 
  company-english-helper
  :load-path "~/.emacs.d/site-lisp/company-english-helper" 
  :config (define-key leader-key (kbd "t e") 'toggle-company-english-helper))

;; Emacs下telegram的客户端，默认不开启
(use-package 
  telega
  :ensure nil
  :commands telega 
  :init (setq telega-proxies 
              '((:server "localhost" 
                         :port 1088
                         :enable t 
                         :type (:@type "proxyTypeSocks5"
                                       )
                         ))) 
  (setq telega-chat-fill-column 65) 
  (setq telega-emoji-use-images nil) 
  :config
  (set-fontset-font t 'unicode (font-spec :family "Symbola") nil 'prepend) 
  (with-eval-after-load 'company (add-hook 'telega-chat-mode-hook (lambda () 
                                                                    (make-local-variable 'company-backends) 
                                                                    (dolist (it '(telega-company-botcmd telega-company-emoji)) 
                                                                      (push it company-backends))))) 
  (with-eval-after-load 'all-the-icons (add-to-list 'all-the-icons-mode-icon-alist '(telega-root-mode all-the-icons-fileicon "telegram" 
                                                                                                      :heigt 1.0 
                                                                                                      :v-adjust -0.2 
                                                                                                      :face all-the-icons-yellow)) 
                        (add-to-list 'all-the-icons-mode-icon-alist '(telega-chat-mode all-the-icons-fileicon "telegram" 
                                                                                       :heigt 1.0 
                                                                                       :v-adjust -0.2 
                                                                                       :face all-the-icons-blue))) 
  (telega-notifications-mode 1) 
  (telega-mode-line-mode 1))

;; Emacs下最好用的终端仿真器，需要编译库，默认不开启
(use-package 
  vterm
  :ensure nil
  :defer 2 
  :bind (:map leader-key
              ("o t" . 'vterm)))

;; 有道词典，非常有用
(use-package 
  youdao-dictionary 
  :defer 2 
  :ensure t 
  :config (setq url-automatic-caching t) 
  (which-key-add-key-based-replacements "C-x y" "有道翻译") 
  :bind (("C-x y t" . 'youdao-dictionary-search-at-point+) 
         ("C-x y g" . 'youdao-dictionary-search-at-point-posframe) 
         ("C-x y p" . 'youdao-dictionary-play-voice-at-point) 
         ("C-x y r" . 'youdao-dictionary-search-and-replace) 
         ("C-x y i" . 'youdao-dictionary-search-from-input)))

;; Emacs下的音乐播放器，自带一个函数将~/Music下的所有音乐导入进Bongo再自动播放(bongo-init)
(use-package 
  bongo
  :ensure t
  ;; :hook (after-init . bongo)
  :custom
  (bongo-mode-line-icon-size 10)
  :config
  (setq bongo-header-line-mode nil)
  (setq bongo-mode-line-indicator-mode nil)
  (setq bongo-global-lastfm-mode nil)
  (defun bongo-init () 
            (interactive) 
            (let ((buffer (current-buffer))) 
              (bongo) 
              (setq bongo-insert-whole-directory-trees "ask") 
              (bongo-insert-file "~/Music") 
              (bongo-insert-enqueue-region (point-min) 
                                           (point-max)) 
              (bongo-play-random) 
              (switch-to-buffer buffer)))
  :bind (:map leader-key
              ("b RET" . 'bongo-dwim) 
              ("b i" . 'bongo-init) 
              ("b x" . 'bongo-kill-region) 
              ("b d" . 'bongo-kill-line) 
              ("b _" . 'bongo-undo) 
              ("b SPC" . 'bongo-pause/resume) 
              ("b TAB" . 'bongo-toggle-collapsed) 
              ("b h" . 'bongo-seek-backward-10) 
              ("b l" . 'bongo-seek-forward-10) 
              ("b a" . 'bongo-insert-enqueue) 
              ("b n" . 'bongo-play-next) 
              ("b p" . 'bongo-play-previous) 
              ("b r" . 'bongo-play-random) 
              ("b s" . 'bongo-sprinkle)))
;; Emacs下的pdf查看工具，默认非图形化不开启
(push '(use-package 
		 pdf-tools 
		 :ensure t 
		 :hook ('doc-view-mode 'pdf-view-mode)
		 :bind (:map pdf-view-mode-map
					 ("j" . #'pdf-view-next-line-or-next-page)
					 ("k" . #'pdf-view-previous-line-or-previous-page)
					 ("l" . #'image-forward-hscroll)
					 ("h" . #'image-backward-hscroll))) graphic-only-plugins-setting)


;; 窗口管理器
(use-package 
  windmove 
  :ensure t 
  :init (windmove-default-keybindings) 
  :config 
  :bind (:map leader-key
              ("w f" . #'windmove-right) 
              ("w b" . #'windmove-left) 
              ("w p" . #'windmove-up) 
              ("w n" . #'windmove-down) 
              ("w F" . #'window-move-right) 
              ("w B" . #'window-move-left) 
              ("w P" . #'window-move-up) 
              ("w N" . #'window-move-down)
              ("w h" . #'enlarge-window-horizontally)
              ("w l" . #'shrink-window-horizontally)
              ("w j" . #'enlarge-window)
              ("w k" . #'shrink-window)))
;; 折叠和收缩代码
(use-package 
  hideshow 
  :ensure t 
  :diminish hs-minor-mode 
  :bind (:map prog-mode-map
              ("C-c TAB" . hs-toggle-hiding) 
              ("C-c p +" . hs-show-all)
              ) 
  :hook (prog-mode . hs-minor-mode))

;; 一个可以临时安装使用插件的插件
(use-package 
  try 
  :ensure t)

;; 谷歌翻译，
(use-package 
  google-translate
  :disabled
  :config (setq google-translate--tkk-url "http://translate.google.cn/" google-translate-base-url "http://translate.google.cn/translate\_a/single" google-translate-listen-url "https://translate.google.cn/translate\_tts" google-translate-default-target-language "zh-CN" google-translate-default-source-language "en"))

;; 工作区
(use-package 
  perspeen
  :diminish 
  :ensure t 
  :init
  ;; (setq perspeen-use-tab t)
  (setq perspeen-keymap-prefix [C-tab]) 
  :config (perspeen-mode))

;; 撤销树
(use-package 
  undo-tree 
  :ensure t 
  :hook (after-init . global-undo-tree-mode) 
  :init (setq undo-tree-visualizer-timestamps t undo-tree-enable-undo-in-region nil undo-tree-auto-save-history nil)

  ;; HACK: keep the diff window
  (with-no-warnings (make-variable-buffer-local 'undo-tree-visualizer-diff) 
                    (setq-default undo-tree-visualizer-diff t)))
;; 项目管理
(use-package 
  projectile 
  :ensure t)

;; 快速查询你的问题
(use-package 
  howdoyou 
  :ensure t 
  :hook (after-init . howdoyou-mode))

;; emacs内置网页浏览器
(use-package 
  eww 
  :ensure t 
  :custom (eww-search-prefix "https://google.com/search?q="))

;; 看英语文档神器
(use-package english-teacher
  :load-path "~/.emacs.d/site-lisp/english-teacher"
  :custom
  (english-teacher-backend 'baidu)
  (english-teacher-show-result-function 'english-teacher-eldoc-show-result-function)
  :hook ((Info-mode
		  elfeed-show-mode
		  eww-mode
		  Man-mode
		  Woman-mode
		  help-mode) . english-teacher-follow-mode))
(use-package sudo-edit
  :ensure t)

(use-package dired-posframe
  :ensure t
  :custom
  (dired-posframe-size-limit (* 10 1024 1024))
  :bind((:map dired-mode-map)
		("C-*" . dired-posframe-show)))

(use-package rotate
  :ensure t)

;;(use-package netease-cloud-music
;;:load-path "~/.emacs.d/site-lisp/netease-cloud-music.el")
(provide 'init-tools)




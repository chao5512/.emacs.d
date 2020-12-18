;; 性能测试
;; (load-file "~/.emacs.d/site-lisp/benchmark-init/benchmark.el")

(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 1))
(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
(run-with-idle-timer 5 nil (lambda () 
                             (setq gc-cons-threshold gc-cons-threshold-original) 
                             (setq file-name-handler-alist file-name-handler-alist-original) 
                             (makunbound 'gc-cons-threshold-original) 
                             (makunbound 'file-name-handler-alist-original)
                             ;; (message "gc-cons-threshold and file-name-handler-alist restored")
                             (message
                              "自动优化完毕!\t如果要关闭这条消息可以在~/.emacs.d/init.el里注释掉.")))

;; 定义一个递归添加dir及其子目录到load-path的函数
(defun add-subdirs-to-load-path(dir) 
  "Recursive add directories to `load-path`."
  (let ((default-directory (file-name-as-directory dir))) 
    (add-to-list 'load-path dir) 
    (normal-top-level-add-subdirs-to-load-path)))

;; 把etc目录及其子目录添加到load-path,在添加时暂时将gc阀值调大,并且去掉所有的io
(let ((gc-cons-threshold most-positive-fixnum) 
      (file-name-handler-alist nil)) 
  (add-subdirs-to-load-path "~/.emacs.d/etc/"))

;; 图形界面插件的设置
(setq graphic-only-plugins-setting ())

(require 'init-config)
;; 透明效果
(when (graphic-p) 
  (+evan/toggle-transparency) 
  (+evan/toggle-transparency) 
  (message "透明已开启，想要关闭可以调用命令(+evan/toggle-transparency)"))

(if (graphic-p) 
    (message "检测到当前环境为图形环境，可以正常使用。")
  (message "检测到当前环境为字符环境，部分插件未启用。"))

;; (org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#FDF6E3" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#556b72"])
 '(custom-safe-themes
   '("5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "d548ac4bb4c8c0ba8f22476f5afcea11b7f1754065eefb118e1324f8a74883fb" "5642b25b6df4d6b63787cbc3d3ef07ca4cb7b0a7a00740ce8e9867c00e57632f" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "711efe8b1233f2cf52f338fd7f15ce11c836d0b6240a18fffffc2cbd5bfe61b0" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" default))
 '(fci-rule-color "#D6D6D6")
 '(jdee-db-active-breakpoint-face-colors (cons "#FFFBF0" "#268bd2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#FFFBF0" "#859900"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#FFFBF0" "#E1DBCD"))
 '(objed-cursor-color "#dc322f")
 '(org-startup-indented t)
 '(package-selected-packages
   '(evil org-download flucui-themes all-the-icons-ivy-rich geiser lua-mode simple-httpd htmlize modern-cpp-font-lock ccls lsp-java python-black live-py-mode treemacs-persp treemacs-magit treemacs-projectile counsel-projectile magit markdown-mode+ org-bullets youdao-dictionary yasnippet-snippets which-key web-mode use-package undo-tree try sudo-edit smartparens rotate rime rainbow-delimiters quickrun projectile perspeen pdf-tools nyan-mode modus-vivendi-theme modus-operandi-theme major-mode-hydra lsp-ui lsp-python-ms js2-mode info-colors indent-guide hungry-delete howdoyou grip-mode flycheck emojify doom-themes doom-modeline dired-posframe dashboard dap-mode counsel company-box circadian bongo beacon amx all-the-icons-dired))
 '(pdf-view-midnight-colors (cons "#556b72" "#FDF6E3"))
 '(rustic-ansi-faces
   ["#FDF6E3" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#556b72"])
 '(vc-annotate-background "#FDF6E3")
 '(vc-annotate-color-map
   (list
	(cons 20 "#859900")
	(cons 40 "#959300")
	(cons 60 "#a58e00")
	(cons 80 "#b58900")
	(cons 100 "#bc7407")
	(cons 120 "#c35f0e")
	(cons 140 "#cb4b16")
	(cons 160 "#cd4439")
	(cons 180 "#d03d5d")
	(cons 200 "#d33682")
	(cons 220 "#d63466")
	(cons 240 "#d9334a")
	(cons 260 "#dc322f")
	(cons 280 "#dd5c56")
	(cons 300 "#de867e")
	(cons 320 "#dfb0a5")
	(cons 340 "#D6D6D6")
	(cons 360 "#D6D6D6")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "magenta"))))
 '(mode-line ((t (:family evan/font-name :style evan/font-style :height 125))))
 '(mode-line-inactive ((t (:family evan/font-name :style evan/font-size :height 125)))))

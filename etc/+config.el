(defun window-move (way) 
  "移动窗口.(Move window.)
WAY是方向，可选值为p,n,f,b，分别对应上下左右
(WAY is the direction, the optional values are p, n, f, b, which correspond to the up, down, left and right)" 
  (interactive "s方向(p-n-f-b): ") 
  (let ((old-window-buffer (window-buffer)) 
        (old-window (get-buffer-window))) 
    (pcase way ("p" (windmove-up)) 
           ("n" (windmove-down)) 
           ("f" (windmove-right)) 
           ("b" (windmove-left))) 
    (setq new-window-buffer (get-buffer-window)) 
    (if (not (eql old-window-buffer new-window-buffer)) 
        (progn (set-window-buffer old-window (window-buffer)) 
               (set-window-buffer (get-buffer-window) old-window-buffer)))))

(defun window-move-right() 
  (interactive) 
  (let ((old-window-buffer (window-buffer)) 
        (old-window (get-buffer-window))) 
    (if (windmove-right) 
        (progn (set-window-buffer old-window (window-buffer)) 
               (set-window-buffer (get-buffer-window) old-window-buffer)))))

(defun window-move-left() 
  (interactive) 
  (let ((old-window-buffer (window-buffer)) 
        (old-window (get-buffer-window))) 
    (if (windmove-left) 
        (progn (set-window-buffer old-window (window-buffer)) 
               (set-window-buffer (get-buffer-window) old-window-buffer)))))

(defun window-move-up() 
  (interactive) 
  (let ((old-window-buffer (window-buffer)) 
        (old-window (get-buffer-window))) 
    (if (windmove-up) 
        (progn (set-window-buffer old-window (window-buffer)) 
               (set-window-buffer (get-buffer-window) old-window-buffer)))))

(defun window-move-down() 
  (interactive) 
  (let ((old-window-buffer (window-buffer)) 
        (old-window (get-buffer-window))) 
    (if (windmove-down) 
        (progn (set-window-buffer old-window (window-buffer)) 
               (set-window-buffer (get-buffer-window) old-window-buffer)))))


;; 打开emacs配置文件夹
(defun open-init-dired ()
  "打开emacs配置文件夹"
  (interactive) 
  (dired "~/.emacs.d/"))



(push '(defun open-with-chrome () 
		 (interactive) 
		 (browse-url-chrome (buffer-file-name)))
	  garbage-collection-messages)

;; 切换代理
(defun +evan/toggle-proxy () 
  (interactive) 
  (if (null url-proxy-services) 
      (progn 
        (setq url-proxy-services
              '(("http" . "127.0.0.1:8000") 
                                   ("https" ."127.0.0.1:8000"))) 
        (message "代理已开启.")) 
    (setq url-proxy-services nil)
    (message "代理已关闭.")))

(provide '+config)

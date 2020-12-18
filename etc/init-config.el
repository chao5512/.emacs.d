;; 延迟加载的两个方法
(require '+autoload)
;; 一些基础函数定义 比如窗口移动
(require '+config)
;; package 相关配置
(require 'init-package)
;; 一些基础配置
(require 'init-basic)
;; ui
(require 'init-ui)
;; key map
(require 'init-keybind)
(require 'init-tools)
(require 'init-complete)
(require 'init-prog)
(require 'init-org)
(require 'init-markdown)
(require 'init-dired)
(require 'init-version-control)
(require 'init-ivy)
(require 'init-treemacs)
(require 'init-python)
(require 'init-java)
(require 'init-cc)
(require 'init-blog)
(require 'init-lua)
(require 'init-scheme)

(require 'init-graphic)
(require 'init-evil)
(require 'init-GTD)
(provide 'init-config)

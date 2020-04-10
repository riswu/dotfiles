;; hide the tool bar
(tool-bar-mode -1)

;; hide the scroll bar
(scroll-bar-mode -1)

;; make the title bar transparent
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; make the window transparent
(set-frame-parameter nil 'alpha 80)

;; make the window maximized
(set-frame-parameter nil 'fullscreen 'maximized)

;; doom-themes
(use-package doom-themes
  :demand
  :ensure t
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-org-config)
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t))

;; doom-modeline
(use-package doom-modeline
  :demand
  :ensure t
  :config
  (doom-modeline-mode t)
  :custom
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil))

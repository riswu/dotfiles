;; package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq-default gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)

;; common.el
(load-file (locate-user-emacs-file "common.el"))

;; cli.el
(when (not window-system)
  (load-file (locate-user-emacs-file "cli.el")))

;; gui.el
(when window-system
  (load-file (locate-user-emacs-file "gui.el")))

;; custom.el
(setq-default custom-file (locate-user-emacs-file "custom.el"))
(load-file custom-file)

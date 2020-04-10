;; inhibit the startup screen
(setq-default inhibit-startup-screen t)

;; the message of *scratch*
(setq-default initial-scratch-message "")

;; backup files
(setq-default backup-directory-alist
              (cons (cons ".*" (locate-user-emacs-file "backups/"))
                    backup-directory-alist))

;; auto saved files
(setq-default auto-save-file-name-transforms
              `((".*" ,(locate-user-emacs-file "backups/") t)))

;; prefer to use utf-8
(prefer-coding-system 'utf-8)

;; soft tabs
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; C-h
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; M-h
(global-set-key (kbd "M-h") 'backward-kill-word)

;; scroll
(setq-default scroll-conservatively 101)

;; delete whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; insert a newline on the last line
(setq-default require-final-newline t)

;; automatically revert the buffers
(global-auto-revert-mode t)

;; automatically insert the closing parenthesis
(electric-pair-mode t)

;; highlight corresponding parenthesis
(show-paren-mode t)

;; highlight the region
(transient-mark-mode t)

;; highlight the current line
(global-hl-line-mode t)

;; display line numbers
(use-package display-line-numbers
  :demand
  :ensure t
  :init
  (global-display-line-numbers-mode t)
  :config
  (defun display-line-numbers--turn-on ()
    (unless (or (minibufferp)
                (member major-mode '(dired-mode))
                (string-match "*" (buffer-name))
                (and (daemonp) (null (frame-parameter nil 'client))))
      (display-line-numbers-mode)))
  :custom
  (display-line-numbers-width-start t)
  (display-line-numbers-grow-only t))

;; undo-tree
(use-package undo-tree
  :demand
  :ensure t
  :init
  (global-undo-tree-mode t)
  :config
  (add-hook 'undo-tree-visualizer-mode-hook 'my-undo-tree-visualizer-mode-hook)
  :preface
  (defun my-undo-tree-visualizer-mode-hook ()
    (setq-local global-hl-line-mode nil))
  :bind
  (:map
   undo-tree-map
   ("C-M-/" . redo)
   ("C-M-_" . redo)))

;; ivy
(use-package ivy
  :demand
  :ensure t
  :init
  (ivy-mode t)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "%d/%d ")
  (ivy-format-function 'ivy-format-function-line)
  (ivy-fixed-height-minibuffer t)
  (ivy-height 20)
  :bind
  (:map
   ivy-mode-map
   ("C-c C-r" . ivy-resume)))

;; counsel
(use-package counsel
  :demand
  :ensure t
  :requires (ivy)
  :init
  (counsel-mode t)
  :bind
  (:map
   counsel-mode-map
   ("C-s" . swiper)))

;; company
(use-package company
  :demand
  :ensure t
  :init
  (global-company-mode t)
  :config
  (my-edit-category-table-for-company-dabbrev)
  :preface
  (defun my-edit-category-table-for-company-dabbrev (&optional table)
    (define-category ?s "word constituents for company-dabbrev" table)
    (let ((i 0))
      (while (< i 128)
        (if (equal ?w (char-syntax i))
            (modify-category-entry i ?s table)
          (modify-category-entry i ?s table t))
        (setq-local i (1+ i)))))
  :custom
  (company-dabbrev-char-regexp "\\cs")
  (company-minimum-prefix-length 3)
  (company-selection-wrap-around t)
  (company-dabbrev-downcase nil)
  :bind
  (:map
   company-mode-map
   ("C-M-i" . company-complete)
   :map
   company-active-map
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   :map
   company-search-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)))

;; flycheck
(use-package flycheck
  :demand
  :ensure t
  :init
  (global-flycheck-mode)
  :bind
  (:map
   flycheck-mode-map
   ("C-M-n" . flycheck-next-error)
   ("C-M-p" . flycheck-previous-error)))

;; yasnippet
(use-package yasnippet
  :demand
  :ensure t
  :init
  (yas-global-mode t))

;; lsp-mode
(use-package lsp-mode
  :demand
  :ensure t
  :hook
  (prog-mode . lsp)
  :config
  (setenv "PATH" (concat (getenv "PATH") (substitute-in-file-name ":$HOME/.rbenv/shims")))
  (add-to-list 'exec-path (substitute-in-file-name "$HOME/.rbenv/shims"))
  (setenv "PATH" (concat (getenv "PATH") (substitute-in-file-name ":$HOME/.nodebrew/current/bin")))
  (add-to-list 'exec-path (substitute-in-file-name "$HOME/.nodebrew/current/bin"))
  :custom
  (lsp-prefer-flymake nil)
  (lsp-enable-snippet t))

;; lsp-ui
(use-package lsp-ui
  :demand
  :ensure t
  :requires (lsp-mode)
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable t)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  ;; (lsp-ui-sideline-enable t)
  ;; (lsp-ui-sideline-ignore-duplicate t)
  ;; (lsp-ui-sideline-show-symbol t)
  ;; (lsp-ui-sideline-show-hover t)
  ;; (lsp-ui-sideline-show-diagnostics nil)
  ;; (lsp-ui-sideline-show-code-actions nil)
  ;; lsp-ui-imenu
  ;; (lsp-ui-imenu-enable t)
  ;; (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-fontify 'on-demand)
  :hook
  (lsp-mode . lsp-ui-mode)
  :bind
  (:map
   lsp-ui-mode-map
   ("M-." . lsp-ui-peek-find-definitions)
   ("M-?" . lsp-ui-peek-find-references)))

;; company-lsp
(use-package company-lsp
  :demand
  :ensure t
  :requires (company lsp-mode lsp-ui yasnippet)
  :init
  (push 'company-lsp company-backends)
  :custom
  (company-lsp-cache-candidates nil)
  (company-lsp-async t)
  (company-lsp-enable-recompletion t)
  (company-lsp-enable-snippet t))

;; web-mode
(use-package web-mode
  :demand
  :ensure t
  :mode
  ("\\.htm[l]?\\'"
   "\\.js[x]?\\'"
   "\\.ts[x]?\\'"
   "\\.vue\\'"
   "\\.jsp\\'"
   "\\.gsp\\'"
   "\\.json\\'"
   "\\.php\\'")
  :config
  (add-hook 'web-mode-hook 'my-web-mode-hook)
  :preface
  (defun my-web-mode-hook ()
    (setq-local web-mode-markup-indent-offset 2)
    (setq-local web-mode-css-indent-offset 2)
    (setq-local web-mode-code-indent-offset 2)
    (setq-local web-mode-script-padding 2)
    (setq-local web-mode-style-padding 2)
    (setq-local web-mode-block-padding 2))
  :custom
  (web-mode-content-types-alist
   '(("jsx" . "\\.js[x]?\\'")))
  (web-mode-comment-formats
   '(("javascript" . "//")
     ("jsx" . "//")
     ("php" . "//"))))

;; scss-mode
(use-package scss-mode
  :demand
  :ensure t
  :custom
  (css-indent-offset 2))

;; scala-mode
(use-package scala-mode
  :demand
  :ensure t)

;; haskell-mode
(use-package haskell-mode
  :demand
  :ensure t)

;; go-mode
(use-package go-mode
  :demand
  :ensure t)

;; ruby-mode
(use-package ruby-mode
  :demand
  :ensure t
  :custom
  (ruby-insert-encoding-magic-comment nil))

;; cc-mode
(use-package cc-mode
  :demand
  :ensure t
  :config
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
  (add-hook 'java-mode-hook 'my-java-mode-hook)
  :preface
  (defun my-c-mode-common-hook ()
    (setq-local c-basic-offset 2)
    (c-set-offset 'substatement-open 0)
    (c-set-offset 'arglist-intro '+)
    (c-set-offset 'arglist-cont-nonempty '+)
    (c-set-offset 'arglist-close 0)
    (c-set-offset 'inexpr-class 0)
    (c-set-offset 'inlambda 0))
  (defun my-java-mode-hook () nil))

;; emacs-lisp-mode
(defun my-emacs-lisp-mode-hook () nil)
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

;; sh-mode
(defun my-sh-mode-hook ()
  (setq-local sh-basic-offset 2)
  (setq-local sh-indentation 2))
(add-hook 'sh-mode-hook 'my-sh-mode-hook)

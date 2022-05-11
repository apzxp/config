(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bc02fd532a4853aba217ddb88b4966c39b331566ea0212aa8b2dfd0e3bbd73ed" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(if (display-graphic-p)(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 90) ; chars
              (height . 35) ; lines
              (left . 50)
              (top . 50)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 90)
              (height . 35)
              (left . 50)))))

    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 80) ; chars
              (height . 45) ; lines
              (left . 50)
              (top . 50)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 80)
              (height . 45)
              (left . 50)))))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; Define global goto-address-mode (make links in buffers clickable)
(define-globalized-minor-mode global-goto-address-mode goto-address-mode
  (lambda () (goto-address-mode 1)))
;; Turn on globalized minor mode
(global-goto-address-mode 1)


(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(blink-cursor-mode 0)
(setq mode-line-compact t)

(setq-default indent-tabs-mode nil)

(setq make-backup-files nil) ;; turn off ~ - ~ files
(setq auto-save-default nil) ;; turnf off #-# files

(defalias 'yes-or-no-p 'y-or-n-p) ;; use y/n instead of yes/no

(setq-default cursor-type 'bar) ;; use bar instead of block cursor

;; (global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(setq-default word-wrap t)
(electric-pair-mode t)
(show-paren-mode t) ;; show matching parenthesis and brackets
(global-hl-line-mode t) ;; highlight current line

;; Fonts
(cond
 ((string-equal system-type "windows-nt") ;;Microsoft Windows
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas-14" t t)
    )
  )
 ((string-equal system-type "darwin") ;;MacOS
  (when (member "Iosevka" (font-family-list))
    (set-frame-font "Iosevka-14" t t)
    )
  )
 ((string-equal system-type "gnu/linux") ;; Linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono-14" t t)
    )
  )
 )

;; Input method and key binding configuration.
(setq alternative-input-methods
      '(("russian-computer" . [?\C-\\])))

(setq default-input-method
      (caar alternative-input-methods))

(defun toggle-alternative-input-method (method &optional arg interactive)
  (if arg (toggle-input-method arg interactive)
    (let ((previous-input-method current-input-method))
      (when current-input-method (deactivate-input-method))
      (unless (and previous-input-method (string= previous-input-method method))
        (activate-input-method method)))))

(defun reload-alternative-input-methods ()
  (dolist (config alternative-input-methods)
    (let ((method (car config)))
      (global-set-key (cdr config)
                      `(lambda (&optional arg interactive)
                         ,(concat "Behaves similar to `toggle-input-method', but uses \""
                                  method "\" instead of `default-input-method'")
                         (interactive "P\np")
                         (toggle-alternative-input-method ,method arg interactive))))))

(reload-alternative-input-methods)

(setenv "PATH" (concat "/usr/local/bin" path-separator (getenv "PATH")))

;; use variable-width font for some modes
(progn
  (defun use-variable-width-font ()
    "Set current buffer to use variable-width font."
    (variable-pitch-mode 1))
  (add-hook 'emacs-lisp-mode-hook 'use-variable-width-font)
  (add-hook 'text-mode-hook 'use-variable-width-font)) 

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'which-key)
(straight-use-package 'selectrum)
(straight-use-package 'xah-fly-keys)

(which-key-mode t)
(selectrum-mode t)

;; (package-initialize)

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; (eval-and-compile
;;   (setq use-package-always-ensure t
;;         use-package-expand-minimally t))

;; (use-package which-key
;;   :ensure t
;;   :config (which-key-mode t))
;; (use-package selectrum
;;   :ensure t
;;   :config (selectrum-mode t))
;; (use-package xah-fly-keys
;;   :ensure t)

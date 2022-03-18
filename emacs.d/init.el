(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(tsdh-light)))
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

(add-to-list 'load-path "~/.emacs.d/packages/evil")
(add-to-list 'load-path "~/.emacs.d/packages/xah-fly-keys")
(require 'evil)
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "qwerty")
(xah-fly-keys 1)
;; (evil-mode t)

;; Define global goto-address-mode (make links in buffers clickable)
(define-globalized-minor-mode global-goto-address-mode goto-address-mode
  (lambda () (goto-address-mode 1)))
;; Turn on globalized minor mode
(global-goto-address-mode 1)

(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default indent-tabs-mode nil)

(setq make-backup-files nil) ;; turn off ~ - ~ files
(setq auto-save-default nil) ;; turnf off #-# files

(defalias 'yes-or-no-p 'y-or-n-p) ;; use y/n instead of yes/no

(setq-default cursor-type 'bar) ;; use bar instead of block cursor
(global-display-line-numbers-mode t)
(setq-default word-wrap t)
(electric-pair-mode 1)
(show-paren-mode t) ;; show matching parenthesis and brackets
(global-hl-line-mode t) ;; highlight current line

;; (cua-mode t) ;; use C-x, C-c, C-v to cut, copy and paste (respectively)

;; Make cua-mode work with evil-mode
;; (define-key evil-insert-state-map (kbd "C-c") 'cua-copy-region)
;; (define-key evil-insert-state-map (kbd "C-v") 'cua-paste)
;; (define-key evil-insert-state-map (kbd "C-x") 'cua-cut-region)
;; Similar to vims'  undo/redo keybindings
;; (define-key evil-insert-state-map (kbd "C-z") 'undo-tree-undo)
;; (define-key evil-insert-state-map (kbd "C-y") 'undo-tree-redo)

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
  (if arg
      (toggle-input-method arg interactive)
    (let ((previous-input-method current-input-method))
      (when current-input-method
        (deactivate-input-method))
      (unless (and previous-input-method
                   (string= previous-input-method method))
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

;; use variable-width font for some modes
;; (progn
;;   (defun use-variable-width-font ()
;;     "Set current buffer to use variable-width font."
;;     (variable-pitch-mode 1))
;;   (add-hook 'emacs-lisp-mode-hook 'use-variable-width-font)
;;   (add-hook 'text-mode-hook 'use-variable-width-font))

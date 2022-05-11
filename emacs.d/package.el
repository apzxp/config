;; (require 'package)
;; ; list the packages you want
;; (setq package-list '(which-key selectrum xah-fly-keys))

;; (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

;; ; list the repositories containing them
;; ;; (setq package-archives '(("elpa" . "http://tromey.com/elpa/")
;; ;;                          ("gnu" . "http://elpa.gnu.org/packages/")
;; ;;                          ("marmalade" . "http://marmalade-repo.org/packages/")))

;; ; activate all the packages (in particular autoloads)
;; (package-initialize)

;; ; fetch the list of packages available 
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; ; install the missing packages
;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install package)))
;; first, declare repositories
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

;; Init the package facility
(require 'package)
(package-initialize)
;; (package-refresh-contents) ;; this line is commented 
;; since refreshing packages is time-consuming and should be done on demand

;; Declare packages
(setq my-packages
      '(cider
        projectile
        clojure-mode
        expand-region
        helm
        jinja2-mode
        magit
        markdown-mode
        paredit
        wrap-region
        yaml-mode
        json-mode))

;; Iterate on packages and install missing ones
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; set up local lisp directory

;; enable server mode - must make sure that ~/.emacs.d/server is not
;; owned by Administrator it only works if it is owned exclusively by
;; the current user.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(server-start)

(defvar mswindows-p (string-match "windows" (symbol-name system-type)))

(setq load-path (cons "~/emacs-local" load-path))
(setq load-path (cons "~/emacs-local/org/lisp" load-path))
(setq load-path (cons "~/emacs-local/org/contrib/lisp" load-path))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.text" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.gv$" . graphviz-dot-mode))
(add-to-list 'auto-mode-alist '("\\.targets" . xml-mode))


;; Add personal Info directory to info search list
(add-hook 'Info-mode-hook
	  (lambda ()
	    (add-to-list 'Info-default-directory-list "~/emacs-local/info/")
	    ))


(require 'org-install)
;;(require 'coffee-mode)

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "--pylab=auto -i")

;; (setenv "PYTHONUNBUFFERED" "1")

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


;; handy functions

(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end)))


;(set-default-font "Consolas:pixelsize=11")

;; Key mappings

(define-key global-map "\M-Q" 'unfill-paragraph)

;; Was C-j but the enter key is what I click most, and
;; newline and indent is what I most oftent want to happen
;; (define-key global-map (kbd "RET") 'newline-and-indent)

;; (define-key global-map (kbd "RET")
;;   'reindent-then-newline-and-indent)


;;; Customized settings which break when I try to set themes.
;;; Org-mode
;; '(org-startup-indented t)
;; '(org-log-done (quote time))


;;;; customizations which keep disapearing - buggy theme support
;; '(blink-cursor-mode nil)
;; '(calendar-week-start-day 1)
;; '(column-number-mode t)
;; '(display-time-mode t)
;; '(inhibit-startup-screen t)
;; '(ispell-program-name "c:/program files (x86)/aspell/bin/aspell")
;; '(markdown-command "markdown.pl | smartypants.pl")
;; '(menu-bar-mode nil)
;; '(scroll-bar-mode nil)
;; '(show-paren-mode t)
;; '(show-paren-style (quote expression))
;; '(text-mode-hook (quote (turn-on-flyspell turn-on-auto-fill text-mode-hook-identify)))
;; '(tool-bar-mode nil)

;;;;;;; Custom faces
;;  '(default ((t (:height 85 :width normal :foundry "outline" :family "Consolas"))))
;;  '(cursor ((t (:background "limegreen"))))


;(require 'tramp)
;(setq tramp-default-method "ssh")

;; Set up file paths so that emacs can find the GnuWin32 binaries.
;; This might affect how the emacs shell works also, but that is a
;; small price to pay for getting ispell and zip file editing working.
(setenv "PATH" (concat (getenv "PATH") ";c:/gnuwin32/bin"))
(setq exec-path (append exec-path '("c:/gnuwin32/bin")))

(setenv "PATH" (concat (getenv "PATH") ";c:/program files (x86)/markdown"))
(setq exec-path (append exec-path '("c:/program files (x86)/markdown")))

(setenv "PATH" (concat (getenv "PATH") ";c:/python34"))
(setq exec-path (append exec-path '("c:/python34")))

(setenv "PATH" (concat (getenv "PATH") ";c:/python34/scripts"))
(setq exec-path (append exec-path '("c:/python34/scripts")))

(setenv "PATH" (concat (getenv "PATH") ";c:/program files (x86)/graphviz2.39/bin"))
(setq exec-path (append exec-path '("c:/program files (x86)/graphviz2.39/bin")))


;;(setq exec-path (append exec-path '("~/emacs-local/darkroom-mode")))

;; Org Mode configuration

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
; not needed when global-font-lock-mode is on
;; (add-hook 'org-mode-hook 'turn-on-font-lock) 
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; flyspell mode by default
;;(add-hook 'text-mode-hook (lambda () (flyspell-mode t)))


;;(if (not (display-graphic-p)
	 
;; Not sure if this actually works :-)
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                     clojure-mode    scheme-mode
                                     haskell-mode    ruby-mode
                                     rspec-mode      python-mode
                                     c-mode          c++-mode
                                     objc-mode       latex-mode
                                     plain-tex-mode  javascript-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

;;(setq show-paren-style 'expression)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("~/emacs-local/info/")))
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(blink-cursor-mode nil)
 '(calendar-today-marker (quote calendar-today))
 '(calendar-week-start-day 1)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("63d0eed57edea24150f91840148d2681843c9a937132791c7d1635f69ce15d08" default)))
 '(display-time-mode t)
 '(fci-rule-color "#383838")
 '(graphviz-dot-auto-indent-on-semi nil)
 '(graphviz-dot-dot-program "dot")
 '(graphviz-dot-indent-width 2)
 '(graphviz-dot-view-command "dotty %s")
 '(inhibit-startup-screen t)
 '(ispell-program-name "c:/program files (x86)/aspell/bin/aspell")
 '(markdown-command "markdown.pl | smartypants.pl")
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
    ("c:/Users/danielsi/Documents/Work/Projects/RPP/Meetings/RPP_Meeting.org")))
 '(package-selected-packages (quote (powershell)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(text-mode-hook
   (quote
    (turn-on-flyspell turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 85 :foundry "outline" :family "Consolas"))))
 '(cursor ((t (:background "limegreen")))))

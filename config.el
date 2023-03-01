;;; example-config.el -- Example Crafted Emacs user customization file -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Crafted Emacs supports user customization through a `config.el' file
;; similar to this one.  You can copy this file as `config.el' to your
;; Crafted Emacs configuration directory as an example.
;;
;; In your configuration you can set any Emacs configuration variable, face
;; attributes, themes, etc as you normally would.
;;
;; See the README.org file in this repository for additional information.

;;; Code:
;; At the moment, Crafted Emacs offers the following modules.
;; Comment out everything you don't want to use.
;; At the very least, you should decide whether or not you want to use
;; evil-mode, as it will greatly change how you interact with Emacs.
;; So, if you prefer Vim-style keybindings over vanilla Emacs keybindings
;; remove the comment in the line about `crafted-evil' below.
(require 'crafted-defaults)    ; Sensible default settings for Emacs
(require 'crafted-updates)     ; Tools to upgrade Crafted Emacs
(require 'crafted-completion)  ; selection framework based on `vertico`
(require 'crafted-ui)          ; Better UI experience (modeline etc.)
;(require 'crafted-windows)     ; Window management configuration
(require 'crafted-editing)     ; Whitspace trimming, auto parens etc.
;(require 'crafted-evil)        ; An `evil-mode` configuration
(require 'crafted-org)         ; org-appear, clickable hyperlinks etc.
(require 'crafted-project)     ; built-in alternative to projectile
(require 'crafted-speedbar)    ; built-in file-tree
(require 'crafted-screencast)  ; show current command and binding in modeline
(require 'crafted-compile)     ; automatically compile some emacs lisp files
(require 'crafted-osx)         ; OSX specific config

;; Set the default face. The default face is the basis for most other
;; faces used in Emacs. A "face" is a configuration including font,
;; font size, foreground and background colors and other attributes.
;; The fixed-pitch and fixed-pitch-serif faces are monospace faces
;; generally used as the default face for code. The variable-pitch
;; face is used when `variable-pitch-mode' is turned on, generally
;; whenever a non-monospace face is preferred.
(add-hook 'emacs-startup-hook
          (lambda ()
            (custom-set-faces
             `(default ((t (:font "IBM Plex Mono"))))
             `(fixed-pitch ((t (:inherit (default)))))
             `(fixed-pitch-serif ((t (:inherit (default)))))
             `(variable-pitch ((t (:font "IBM Plex Sans")))))))

;; Themes are color customization packages which coordinate the
;; various colors, and in some cases, font-sizes for various aspects
;; of text editing within Emacs, toolbars, tabbars and
;; modeline. Several themes are built-in to Emacs, by default,
;; Crafted Emacs uses the `deeper-blue' theme. Here is an example of
;; loading a different theme from the venerable Doom Emacs project.


;;(crafted-package-install-package 'doom-themes)
;;(progn
  (disable-theme 'deeper-blue)          ; first turn off the deeper-blue theme
;;  (load-theme 'doom-vibrant t))       ; load the doom-vibrant theme

(load-theme 'modus-vivendi t)

;; To not load `custom.el' after `config.el', uncomment this line.
;; (setq crafted-load-custom-file nil)

;;; example-config.el ends here

;; You will most likely need to adjust this font size for your system!
(custom-set-variables
 '(crafted-ui-default-font
   '(:font "IBM Plex Mono" :height 185)))

;; Main typeface
(set-face-attribute 'default nil :family "IBM Plex Mono" :height 185)

;; Proportionately spaced typeface
(set-face-attribute 'variable-pitch nil :family "IBM Plex Sans" :height 1.0)

;; Monospaced typeface
(set-face-attribute 'fixed-pitch nil :family "IBM Plex Mono" :height 1.5)

(tool-bar-mode -1)          ; Disable the toolbar
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 0)        ; Give some breathing room

(visual-line-mode 1)



(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups


(crafted-package-install-package 'mode-line-bell)
(mode-line-bell-mode)

(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq org-agenda-files
      '("~/org/gtd.org"
        "~/org/ascend.org"))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "FINAL CHECK(f)" "|" "DONE(d!)")
                  (sequence  "WAITING(w)" "|" "CANCELLED(c)")
                  (sequence "|" "INVOICED(i)" "PAID(p)")))

(setq org-tag-alist '(("WORK" . ?w)
                      ("HOME" . ?h)
                      ("MISC" . ?m)
                      ("ASCEND" . ?a)
                      ("UC" . ?u)
                      ("MORNING" . ?m)))

;; (setq org-default-notes-file (concat org-directory "~/org/gtd.org"))

(setq org-capture-templates
      '(("t" "todo" entry
         (file+headline "~/org/gtd.org" "Inbox")
         "* TODO %^{TODO Title} %? %^{Select TODO type|EDIT|PROOF|TRANSCRIPT|LESSON|WRITING} %^g \n SCHEDULED: %^t DEADLINE: %^T \n :PROPERTY: \n  :QTY: %^{Quantity} \n :RATE: %^{Rate} %^{Select currency|JPY|USD|*} \n :CONTACT: %^{Contact person} \n :PAYMENT: %^t \n :END:")))

(setq-default left-margin-width 5 right-margin-width 5) ; Define new widths.
(set-window-buffer nil (current-buffer)) ; Use them now.
(add-to-list 'default-frame-alist '(left-fringe . 0))
(add-to-list 'default-frame-alist '(right-fringe . 0))


;; Dashboard

(require 'dashboard)
(dashboard-setup-startup-hook)

;; ;; Set the title
(setq dashboard-banner-logo-title "Welcome to Crafted Emacs Dashboard")
;; ;; Set the banner
(setq dashboard-startup-banner 'logo)
;; ;; Value can be
;; ;; 'official which displays the official emacs logo
;; ;; 'logo which displays an alternative emacs logo
;; ;; 1, 2 or 3 which displays one of the text banners
;; ;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

;; ;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; ;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts t)


;; visual-fill-column-widthn
(global-visual-line-mode t)

;;; tab completion with corfu override
(define-key corfu-map (kbd "TAB") 'corfu-insert)
(define-key corfu-map (kbd "RET") nil)

;;; override bracket closing

(electric-pair-mode -1) ; auto-insert matching bracket

;; add keys

(global-set-key (kbd "M-<delete>") 'kill-word)
(global-set-key (kbd "M-<up>") 'previous-logical-line)
(global-set-key (kbd "M-<down>") 'next-logical-line)

;; add general leader SPC
(crafted-package-install-package 'general)
(require 'general)

(general-define-key
 "s-SPC" (general-key "C-c"))

(general-define-key
 "C-SPC" (general-key "C-x"))

(general-define-key
 "M-SPC" (general-key "M-x"))

(global-set-key (kbd "C-c f") 'find-file)
(global-set-key (kbd "C-c w") 'write-file)
(global-set-key (kbd "C-c 1") 'count-words)
(global-set-key (kbd "C-c 2") 'ispell)
(global-set-key (kbd "C-c 3") 'flush-lines)


(global-set-key (kbd "s-o") 'other-window)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; recent mode
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-c r") 'recentf-open-files)

;; magit setup

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(crafted-package-install-package 'which-key)
(require 'which-key)
(which-key-mode)

;; spelling
(setq ispell-program-name "aspell")

(crafted-package-install-package 'markdown-mode)


(provide 'config)
;;; config.el ends here

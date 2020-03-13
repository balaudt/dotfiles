(eval-and-compile
  (setq gc-cons-threshold 402653184
        gc-cons-percentage 0.6))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ; which directory to put backups file
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ;transform backups file name
      fill-column 80   ; toggle wrapping text at the 80th character
      scroll-conservatively 101         ;
      ispell-program-name "aspell")

(setq inhibit-startup-screen t
      browse-url-browser-function 'browse-url-default-macosx-browser)

                                        ;(setq debug-on-error t)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq-default indent-tabs-mode nil)
(global-hl-line-mode 1)
(global-display-line-numbers-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)
(winner-mode 1)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(set-default-font "MesloLGS NF 12")
(setq column-number-mode t)

(defun zi-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

                                        ;TODO Should switch persp automatically on projectile-switch-project
(defun zi-projectile-switch-persp ()
  "Switches to a perspective with the project name on projectile switch project"
  (let (pname (projectile-project-name))
    (message (concat "test-hook" this-command pname))))

;;;We’re going to set the load-path ourselves and avoid calling (package-initilize) (for performance reasons) so we need to set package--init-file-ensured to true to tell package.el to not automatically call it on our behalf. Additionally we’re setting package-enable-at-startup to nil so that packages will not automatically be loaded for us since use-package will be handling that.
(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir "~/.emacs.d/elpa"
        package--init-file-ensured t
        package-enable-at-startup nil)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t))

  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))


(eval-when-compile
  (require 'package)
  ;; tells emacs not to load any packages before starting up
  ;; the following lines tell emacs where on the internet to look up
  ;; for new packages.
  (setq package-archives '(("melpa"     . "https://melpa.org/packages/")
                           ("elpa"      . "https://elpa.gnu.org/packages/")
                           ("repo-org"  . "https://orgmode.org/elpa/")))
  ;; (package-initialize)
  (unless package--initialized (package-initialize t))

  ;; Bootstrap `use-package'
  (unless (package-installed-p 'use-package) ; unless it is already installed
    (package-refresh-contents) ; updage packages archive
    (package-install 'use-package)) ; and install the most recent version of use-package

  (require 'use-package)
  (setq use-package-always-ensure t))

(use-package dired+
  :load-path "~/.emacs.d/packages/dired"
  :config
  (diredp-toggle-find-file-reuse-dir 1))

(use-package which-key
  :config (which-key-mode 1))

(use-package restart-emacs)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package general
  :after (which-key restart-emacs)
  :config
  (general-override-mode 1)
  (general-create-definer tyrant-def
    :states '(normal visual insert motion emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")
  (tyrant-def

    ""     nil
    "c"   (general-simulate-key "C-c")
    "h"   (general-simulate-key "C-h")
    "u"   (general-simulate-key "C-u")
    "x"   (general-simulate-key "C-x")

    "lp"  'list-packages
    "'"   'eshell

    ;; Applications
    "a"	  '(:ignore t :which-key "applications")
    "ac"  'calc-dispatch
    "ap"  'list-processes
    "aP"  'proced
    "au"  'undo-tree-visualize

    ;; Buffer operations
    "b"   '(:ignore t :which-key "buffer")
    "bd"  'kill-this-buffer
    "bq"  'kill-buffer-and-window
    "bu"  'revert-buffer
    "bh"  (lambda () (interactive) (switch-to-buffer "*dashboard*"))
    "bs"  (lambda () (interactive) (switch-to-buffer "*scratch*"))

    ;; File operations
    "f"   '(:ignore t :which-key "files")
    "fc"  'write-file
    "fe"  '(:ignore t :which-key "init")
    "fj"  'dired-jump
    "fl"  'find-file-literally
    "fy"  'zi-copy-file-name-to-clipboard

    ;; Quit operations
    "q"	  '(:ignore t :which-key "quit emacs")
    "qq"  'kill-emacs
    "qz"  'delete-frame
    "qr"  'restart-emacs

    ;; Toggle operations
    "t"   '(:ignore t :which-key "toggle")
    "tl"  'toggle-truncate-lines
    "tm"  'evil-visual-mark-mode
    ))

(use-package crux
  :general (tyrant-def
             "br" 'crux-rename-file-and-buffer
             "bo" 'crux-kill-other-buffers
             "fed" 'crux-find-user-init-file
             "fes" 'crux-find-shell-init-file))

(use-package suggest
  :general (tyrant-def "as" 'suggest))

(use-package neotree
  :general (tyrant-def "ft" 'neotree-toggle))

(use-package format-all
  :general (tyrant-def "mf" 'format-all-buffer))

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort)
  (setq company-backends
        '(company-bbdb
          (company-files
           company-capf
           company-yasnippet)
          (company-dabbrev-code
           company-gtags
           company-etags)
          company-dabbrev)))
;; Enable company-ispell for text-mode
(defun text-mode-hook-setup ()
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-ispell))
(add-hook 'text-mode-hook 'text-mode-hook-setup)

(use-package solarized-theme
  :hook (after-init . load-solarized-light)
  :config
  (defun load-solarized-light ()
    "Load the `solarized-light' theme."
    (interactive)
    (load-theme 'solarized-light)))

(use-package magit
  :commands (magit-status)
  :config
  (setq magit-repository-directories '(("~/dev" . 2)))
  :general
  (tyrant-def
    "g"   '(:ignore t :which-key "git")
    "gs"  'magit-status
    "gfh" 'magit-log-buffer-file
    "gm"  'magit-dispatch-popup
    "gS"  'magit-stage-file
    "gU"  'magit-unstage-file
    "gb"  'magit-blame
    "gd"  'magit-diff-buffer-file))

(use-package persp-mode
  :init (setq persp-autokill-buffer-on-remove 'kill-weak)
  :config (persp-mode 1))

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode 1)
  (add-hook 'projectile-after-switch-project-hook 'zi-projectile-switch-persp))

;; Evil packages
(use-package evil
  :hook (after-init . evil-mode)
  :init (setq evil-want-keybinding nil
              evil-want-C-u-scroll t
              evil-disable-insert-state-bindings t)
  :config
  (evil-set-initial-state 'shell-mode 'normal)
  (evil-set-initial-state 'doc-view-mode 'normal)
  (evil-set-initial-state 'package-menu-mode 'normal)
  (evil-set-initial-state 'biblio-selection-mode 'motion)
  (setq doc-view-continuous t)
  :general
  (tyrant-def
    "w"   (general-simulate-key "C-w")
    "bN"  'evil-buffer-new
    "fS"  'evil-write-all
    "fd"  'evil-save-and-close))
(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))
(use-package evil-visualstar
  :after evil
  :config
  (setq evilmi-always-simple-jump t)
  (global-evil-visualstar-mode 1))
(use-package evil-magit
  :hook (magit-mode . evil-magit-init))
(use-package evil-collection
  :after evil
  :preface (setq evil-collection-company-use-tng nil)
  :config (evil-collection-init))
(use-package evil-matchit
  :after evil)
(use-package evil-visual-mark-mode
  :after evil)

;; completion packages - ivy, counsel, swiper
(use-package ivy
  :hook (after-init . ivy-mode)
  :config (setq ivy-count-format "(%d/%d) "
                ivy-initial-inputs-alist nil
                ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  :general
  (tyrant-def "bb"  'ivy-switch-buffer))
(use-package counsel
  :after (ivy)
  :bind (([f12] . 'counsel-imenu))
  :general
  (tyrant-def
    "SPC" 'counsel-M-x
    "ff"  'counsel-find-file
    "fr"  'counsel-recentf
    "fs"  'counsel-imenu
    "fL"  'counsel-locate))
(use-package counsel-projectile
  :after (projectile ivy)
  :general
  (tyrant-def
    "p"   '(:ignore t :which-key "projectile")
    "pp"  'counsel-projectile-switch-project
    "pf"  'counsel-projectile-find-file
    "pg"  'counsel-projectile-find-file-dwim
    "pd"  'counsel-projectile-find-dir
    "pb"  'counsel-projectile-switch-to-buffer
    "ps"  'counsel-projectile-rg))

(use-package dumb-jump
  :general
  (tyrant-def
    "n"   '(:ignore t :which-key "navigate")
    "no"  'dumb-jump-go-other-window
    "nj"  'dumb-jump-go
    "nb"  'dumb-jump-back
    "ni"  'dumb-jump-go-prompt
    "nx"  'dumb-jump-go-prefer-external
    "nz"  'dumb-jump-go-prefer-external-other-window)
  :config (setq dumb-jump-selector 'ivy))

;; TODO When single char jumps are frequently used, start using 2-char jumps
(use-package avy
  :general
  (tyrant-def
    "j"   '(:ignore t :which-key "jump")
    "jj"  'avy-goto-line-below
    "jk"  'avy-goto-line-above
    "jw"  'avy-goto-word-1-below
    "jb"  'avy-goto-word-1-above
    "jf"  'avy-goto-char
    "j("  'avy-goto-open-paren
    "j)"  'avy-goto-close-paren
    "jp"  'avy-pop-mark))

;;org mode stuff
(use-package org
  :defer t
  :mode ("\\.org\\'" . org-mode)
  :ensure org-plus-contrib
  :init
  :general
  (tyrant-def org-mode-map
    "me"   'org-export-dispatch
    "mt"   'org-hide-block-toggle)
  :config
  (setq org-highlight-latex-and-related '(entities script latex)
        org-tags-column 90
        org-use-sub-superscripts '{}
        org-export-with-sub-superscripts '{}))
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))
(use-package org-journal
  :config
  (setq org-journal-file-type 'monthly
        org-journal-dir "~/Documents/journal"))
(use-package evil-org
  :init
  (setq evil-org-key-theme '(textobjects insert navigation additional shift todo heading calendar))
  :after org
  :config
  (setq evil-org-use-additional-insert t)
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
(use-package htmlize)

(use-package auctex)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" default)))
 '(package-selected-packages
   (quote
    (org-bullets org-plus-contrib which-key use-package suggest solarized-theme restart-emacs rainbow-delimiters persp-mode neotree general format-all evil-visualstar evil-surround evil-magit evil-collection dumb-jump dashboard crux counsel-projectile company avy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)

;; -*- lexical-binding: t; -*-

; this was my starting point
; and then https://github.com/valignatev/dotemacs/blob/master/init.el
; https://arne.me/blog/emacs-from-scratch-part-one-foundations#remove-ui-elements
(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI
(load-theme 'wombat)

;; (use-package emacs
;;   :init
;;   (set-face-attribute 'default nil :height 140))
;; bigger - bit nicer
;; (set-face-attribute 'default nil :height 200))

;; Above set global sizing
(use-package emacs
  :init
  ;; Increase text size in all prog-mode buffers
  (add-hook 'prog-mode-hook 
            (lambda () (text-scale-increase 2))))

(use-package emacs
  :init
  (set-face-attribute 'default nil 
                      :font "JetBrainsMono Nerd Font"
                      :height 140)  ; 140 = 14pt, adjust as needed
  (set-face-attribute 'fixed-pitch nil 
                      :font "JetBrainsMono Nerd Font"
                      :height 140)
  (set-face-attribute 'variable-pitch nil 
                      :font "JetBrainsMono Nerd Font"
                      :height 140))

; TODO: May not need this at all
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

; straight.el package manager
; https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

;; To force access to config even if configuration fails
(global-set-key (kbd "C-c e") (lambda () (interactive) (find-file user-init-file)))
(global-set-key (kbd "M-;") 'eval-expression)


; make the title bar native/hidden
;(use-package emacs
;  :init
;  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;  (add-to-list 'default-frame-alist '(ns-appearance . light))
;  (setq ns-use-proxy-icon  nil)
;  (setq frame-title-format nil))

(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message "")))

; confirm dialogs y instead of yes
(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

; make everything utf-8
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

; use spaces, but configur tab width
(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

; fix mac mappings
(use-package emacs
  :init
	(when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control)))

; apparently this fixes an issue when typing square brackets on emacs - i've never had an issue
;(use-package emacs
;  :init
;  (when (eq system-type 'darwin)
;    (setq mac-command-modifier 'super)
;    (setq mac-option-modifier nil)
;    (setq mac-control-modifier nil)))


; cmd-c/p copy and paste
(use-package emacs
  :init
  (cua-mode 1)
  (setq cua-keep-region-after-copy t))

;; VIM stuff
(use-package evil
  :straight t
  :demand
  :init
  ;; Required by evil-collection
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ; fix the fact C-u doesn't scroll by default
  (setq evil-want-C-u-scroll t)
  ;; Set up undo system BEFORE evil-mode is loaded
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Enable visual line mode globally
  (global-visual-line-mode 1)
  ;; Make evil use visual line movements
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; fat fingers
  (evil-ex-define-cmd "W" 'evil-write)
  (evil-ex-define-cmd "Wa" 'evil-write-all)
  (evil-ex-define-cmd "WA" 'evil-write-all)
  (evil-ex-define-cmd "Q" 'evil-quit)
  (evil-ex-define-cmd "QA" 'evil-quit-all)
  (evil-ex-define-cmd "Qa" 'evil-quit-all))

; enable vim motions for EVERYTING where opss
(use-package evil-collection
  :after evil
  :straight t
  :demand 
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

; make esc actually quit stuff like vim
(use-package emacs
  :init
	(global-set-key (kbd "<escape>") 'keyboard-escape-quit))

;; comments
(use-package evil-commentary
  :straight t
  :after evil
  :config
  (evil-commentary-mode))

; relative line numbers
(use-package emacs
  :init
  (defun ab/enable-line-numbers ()
    "Enable relative line numbers"
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers 'relative))
  (add-hook 'prog-mode-hook #'ab/enable-line-numbers))

(use-package which-key
  :straight t
  :demand
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode))

; custom keybinding mappings
(use-package general
  :straight t
  :demand
  :config
  (general-evil-setup)

  (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (leader-keys

    "r" '(restart-emacs :which-key "restart emacs")
    "i" '((lambda () (interactive) (find-file user-init-file)) :which-key "open init file")
    "." '(find-file :which-key "find file")

    ;; Buffer
    "b" '(:ignore t :which-key "buffer")
    "b <escape>" '(keyboard-escape-quit :which-key t)
    "bd"  'kill-current-buffer))

(use-package emacs
  :general
  (:states 'visual
   "SPC y" '(clipboard-kill-ring-save :which-key "copy to clipboard"))
  
  :config
  ;; Ensure Emacs uses system clipboard
  (setq select-enable-clipboard t)
  (setq select-enable-primary t))

(use-package command-log-mode :straight t)

;; fuzzy finding
;; Vertico - vertical completion UI
(use-package vertico
  :straight t
  :demand
  :init
  (vertico-mode)
  :config
  (setq vertico-cycle t))

;; Marginalia - rich annotations in the minibuffer
(use-package marginalia
  :straight t
  :demand
  :init
  (marginalia-mode))

;; Orderless - flexible matching (space-separated search terms)
(use-package orderless
  :straight t
  :demand
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Consult - enhanced search and navigation commands
(use-package consult
  :straight t
  :demand
  :general
  (leader-keys
    "/" '(consult-line :which-key "search buffer")
    "b b" '(consult-buffer :which-key "switch buffer")
    "p s" '(consult-ripgrep :which-key "search in project")
    "s s" '(consult-imenu :which-key "jump to symbol"))
  :config
  ;; Use ripgrep for consult-find if available
  (setq consult-find-args "find . -not ( -path */.git/* -prune )")
  ;; Configure preview
  (setq consult-preview-key 'any))

;; Embark - contextual actions
(use-package embark
  :straight t
  :general
  (general-define-key
   "C-." 'embark-act
   "C-;" 'embark-dwim)
  (leader-keys
    "a" '(embark-act :which-key "embark act")))

;; Embark + Consult integration
(use-package embark-consult
  :straight t
  :after (embark consult))

(use-package treemacs
  :straight t
  :general
  (leader-keys
    ;; "p n" '(treemacs :which-key "toggle file tree")
    "p n" '(treemacs-select-window :which-key "toggle file tree")
    "p N" '(treemacs-select-window :which-key "focus file tree"))
  :config
  (setq treemacs-width 35)
  (setq treemacs-follow-mode t)
  (setq treemacs-filewatch-mode t))

;; Treemacs + Evil integration
(use-package treemacs-evil
  :straight t
  :after (treemacs evil))

;; ;; Treemacs + Projectile integration
;; (use-package treemacs-projectile
;;   :straight t
;;   :after (treemacs projectile)
;;   :general
;;   (leader-keys
;;     "p n" '(treemacs-projectile :which-key "treemacs project")))

;; Treemacs + Magit integration (optional but nice)
(use-package treemacs-magit
  :straight t
  :after (treemacs magit))

;; (like Doom's compilation)
(use-package compile
  :straight t
  :general
  (leader-keys
    "c" '(:ignore t :which-key "compile")
    "c c" '(compile :which-key "compile")
    "c r" '(recompile :which-key "recompile"))
  :config
  (setq compilation-scroll-output t) ; Auto scroll to bottom
  (setq compilation-always-kill t))

(use-package nerd-icons :straight t)

;; Dired improvements
(use-package dired
  :commands dired
  :general
  (leader-keys
    "d" '(dired-jump :which-key "dired"))
  :config
  (setq dired-listing-switches "-alh --group-directories-first")
  (setq dired-dwim-target t)) ; Smart copy/move between dired windows

;; Better dired with icons
(use-package all-the-icons-dired
  :straight t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

;magit
(use-package magit
  :straight t
  :general
  (leader-keys
    "g" '(:ignore t :which-key "git")
    "g <escape>" '(keyboard-escape-quit :which-key t)
    "g g" '(magit-status :which-key "status")
    "g l" '(magit-log :which-key "log")
    "g b" '(magit-blame :which-key "blame"))
  (general-nmap
    "<escape>" #'transient-quit-one))

; gutter diffs
(use-package diff-hl
  :straight t
  :init
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode))

(use-package vterm :straight t)
(use-package vterm-toggle
  :straight t
  :general
  (leader-keys
    "'" '(vterm-toggle :which-key "terminal")))

; fix read only issue when pasting
(with-eval-after-load 'vterm
  (evil-define-key 'insert vterm-mode-map (kbd "C-S-v") 'vterm-yank)
  (evil-define-key 'insert vterm-mode-map (kbd "s-v") 'vterm-yank)  ; Cmd-v
  
  ;; Or if you want evil's 'p' to work in normal mode
  (evil-define-key 'normal vterm-mode-map (kbd "p") 
    (lambda () 
      (interactive) 
      (vterm-goto-char (point))
      (call-interactively 'vterm-yank))))

; garbage collection configuration - more work when idle
(use-package gcmh
  :straight t
  :demand
  :config
  (gcmh-mode 1))

; load path from shell
(use-package exec-path-from-shell
  :straight t
  :init
  (exec-path-from-shell-initialize))

; save backups here rather than right next to original file
(use-package emacs
  :config
  (setq backup-directory-alist `(("." . "~/.saves"))))

;
; lsp support stuff
;
; completions client

;; Rust
(use-package rust-ts-mode
  :mode "\\.rs\\'"
  :hook (rust-ts-mode . eglot-ensure)
  :custom
  (rust-format-on-save t)
  :bind (:map rust-ts-mode-map
              ("C-c r b" . treesit-beginning-of-defun)
              ("C-c r e" . treesit-end-of-defun)))

(use-package go-ts-mode
  :mode "\\.go\\'"
  :hook (go-ts-mode . eglot-ensure)
  :hook (go-ts-mode . (lambda ()
                        (setq tab-width 4)
                        (add-hook 'before-save-hook #'eglot-format-buffer nil t)))
  :custom
  (go-ts-mode-indent-offset 4)
  :bind (:map go-ts-mode-map
              ("C-c r b" . treesit-beginning-of-defun)
              ("C-c r e" . treesit-end-of-defun)))

(use-package typescript-ts-mode
  :mode "\\.ts\\'"
  :mode "\\.tsx\\'"
  :hook (typescript-ts-mode . eglot-ensure)
  :hook (tsx-ts-mode . eglot-ensure)
  :custom
  (typescript-ts-mode-indent-offset 2)
  :bind (:map typescript-ts-mode-map
              ("C-c r b" . treesit-beginning-of-defun)
              ("C-c r e" . treesit-end-of-defun)))

(use-package eglot
  :straight t
  :hook ((rust-ts-mode . eglot-ensure)
         (go-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure))
  :general
  (:keymaps 'eglot-mode-map
   :states 'normal
   "gd" 'xref-find-definitions
   "gD" 'xref-find-references
   "gi" 'eglot-find-implementation
   "gr" 'xref-find-references
   "K" 'eldoc-doc-buffer
   "gu" 'xref-find-references
   "gt" 'flymake-show-buffer-diagnostics)  

  (leader-keys
    :keymaps 'eglot-mode-map
    "r n" '(eglot-rename :which-key "rename")
    "c a" '(eglot-code-actions :which-key "code actions")
    "l" '(:ignore t :which-key "lsp")
    "l <escape>" '(keyboard-escape-quit :which-key t)
    "l d" '(xref-find-definitions :which-key "goto definition")
    "l D" '(xref-find-references :which-key "find references")
    "l f" '(eglot-format :which-key "format")
    "l t" '(flymake-show-buffer-diagnostics :which-key "diagnostics")))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t
  :hook (prog-mode . copilot-mode)
  :config
  (setq warning-suppress-types '((copilot)))
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  
  :general
  (leader-keys
    "t c" '(copilot-mode :which-key "toggle copilot")))

(use-package company
  :straight t
  :init
  (global-company-mode))

(use-package treesit-auto
  :straight t
  :custom
  (treesit-auto-install 'prompt)
  :config
  ;; Perf changes - don't check every language
  (setq treesit-auto-langs '(rust typescript))
  (treesit-auto-add-to-auto-mode-alist)
  (global-treesit-auto-mode))


(use-package perspective
  :straight t
  :demand
  :custom
  (persp-suppress-no-prefix-key-warning t)
  :general
  (leader-keys
    "TAB" '(:ignore t :which-key "workspace")
    "TAB TAB" '(persp-switch :which-key "switch workspace")
    "TAB n" '(persp-next :which-key "next workspace")
    "TAB p" '(persp-prev :which-key "previous workspace")
    "TAB d" '(persp-kill :which-key "delete workspace")
    "TAB r" '(persp-rename :which-key "rename workspace")
    "TAB c" '(persp-switch :which-key "create/switch workspace")
    "TAB s" '(persp-state-save :which-key "save workspaces")
    "TAB l" '(persp-state-load :which-key "load workspaces")
    "TAB b" '(persp-switch-to-buffer :which-key "switch to buffer in workspace")
    "TAB k" '(persp-remove-buffer :which-key "remove buffer from workspace")
    "TAB a" '(persp-add-buffer :which-key "add buffer to workspace"))
  ;; Bind S-1 through S-9 to switch workspaces
  :bind (("s-1" . (lambda () (interactive) (persp-switch-by-number 1)))
         ("s-2" . (lambda () (interactive) (persp-switch-by-number 2)))
         ("s-3" . (lambda () (interactive) (persp-switch-by-number 3)))
         ("s-4" . (lambda () (interactive) (persp-switch-by-number 4)))
         ("s-5" . (lambda () (interactive) (persp-switch-by-number 5)))
         ("s-6" . (lambda () (interactive) (persp-switch-by-number 6)))
         ("s-7" . (lambda () (interactive) (persp-switch-by-number 7)))
         ("s-8" . (lambda () (interactive) (persp-switch-by-number 8)))
         ("s-9" . (lambda () (interactive) (persp-switch-by-number 9))))
  :init
  (persp-mode)
  :config
  ;; Auto-save workspaces
  (setq persp-state-default-file (expand-file-name ".persp-state" user-emacs-directory))
  (add-hook 'kill-emacs-hook #'persp-state-save))

(use-package project
  :config
  (setq project-switch-commands
        '((project-find-file "Find file")
          (consult-ripgrep "Ripgrep")
          (project-dired "Dired"))))

(use-package project
  :general
  (leader-keys
    "p" '(:ignore t :which-key "projects")
    "p f" '(project-find-file :which-key "find file")
    "p p" '(project-switch-project :which-key "switch project")
    "p d" '(project-dired :which-key "project dired")
    "p a" '(project-remember-projects-under :which-key "add projects"))
  :config
  (setq project-switch-commands 'project-find-file))

(use-package emacs
  :general
  (leader-keys
    "s" '(:ignore t :which-key "search")
    "s <escape>" '(keyboard-escape-quit :which-key t)
    "s o" '(my/search-online :which-key "search online"))
  
  (:states 'visual
   "SPC s o" 'my/search-online)
  
  :config
    (defun my/get-region-or-symbol ()
    "Get selected text, symbol at point, or prompt for input"
    (cond
    ((use-region-p)
        (buffer-substring-no-properties (region-beginning) (region-end)))
    ((thing-at-point 'symbol t)
        (thing-at-point 'symbol t))
    (t
        (read-string "Search for: "))))

    (defun my/search-online ()
    "Search selected text with choice of engine"
    (interactive)
    (let* ((query (my/get-region-or-symbol))
            (engines '(("Google" . "https://www.google.com/search?q=")
                    ("Claude" . "https://claude.ai/new?q=")
                    ("Crates.io" . "https://crates.io/search?q=")
                    ("Rust Docs" . "https://docs.rs/releases/search?query=")
                    ("GitHub" . "https://github.com/search?q=")
                    ("DuckDuckGo" . "https://duckduckgo.com/?q=")
                    ("StackOverflow" . "https://stackoverflow.com/search?q=")
                    ("Go Packages" . "https://pkg.go.dev/search?q=")))
            (choice (completing-read "Search with: " 
                                    (mapcar #'car engines)))
            (url-base (cdr (assoc choice engines))))
        (browse-url (concat url-base (url-hexify-string query))))))

(message "Loading personal config!")
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;; Old config here: https://github.com/jwtly10/config/blob/66a2fee88558dac768626f21b3f331540b8cb654/.config/doom/init.el
;;

;; ***************
;; Base settings
;; ***************

;; Fonts
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
;; (setq doom-font (font-spec :family "Iosevka NFM" :size 18))
;; (setq doom-font (font-spec :family "FiraCode Nerd Font" :size 18))
;; (setq doom-font (font-spec :family "GoMono Nerd Font" :size 15))

;; THEMES
;; (setq doom-theme 'doom-zenburn)
(setq doom-theme 'modus-vivendi)

;; Hide toolbar
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

;; For UI scaling (Cmd-=)
(setq doom-font-increment 1.1)  ; 10% increase/decrease
;; For buffer text scaling (Ctrl-=)
(setq text-scale-mode-step 1.1) ; 10% increase/decrease

(setq display-line-numbers-type t)
(setq display-line-numbers t)

;; ~ Is a git directory for dot files, so ignogre this project to prevent projectile from indexing it
(add-to-list 'projectile-ignored-projects (expand-file-name "~"))

;; To use use the mouse for selections
(setq mouse-drag-and-drop-region t)
(xterm-mouse-mode 1)
;; (setq select-enable-clipboard t)
(setq select-enable-clipboard t)

;; show relative path in mode line
(setq-default mode-line-buffer-identification
              '(:eval (format "%s"
                              (if (buffer-file-name)
                                  (file-relative-name (buffer-file-name) (project-root (project-current)))
                                (buffer-name)))))

(setq fill-column 80)

;; ***************
;; EVIL (vim) settings
;; ***************

(map! :n "gx" #'goto-address-at-point)

;; Bad practise. Shouldn't be doing it
(map! "C-h" nil
      "C-j" nil
      "C-k" nil
      "C-l" nil)

;; Replace highlighted when pasting
(delete-selection-mode 1)

;; Prevent 'o' from remaining in the comment mode from the prev line

(setq +evil-want-o/O-to-continue-comments nil)
(setq +default-want-RET-continue-comments t)

;; Fix for holding shift for too long
(evil-ex-define-cmd "W" 'evil-write)
(evil-ex-define-cmd "Wa" 'evil-write-all)
(evil-ex-define-cmd "WA" 'evil-write-all)
(evil-ex-define-cmd "Q" 'evil-quit)
(evil-ex-define-cmd "QA" 'evil-quit-all)
(evil-ex-define-cmd "Qa" 'evil-quit-all)

;; ***************
;; Remaps
;; ***************

(map! "s-!" #'shell-command)

(map! :leader
      :desc "Toggle Treemacs"
      "p n" #'treemacs)

(map! :map compilation-mode-map
      "C-k" nil
      :map compilation-minor-mode-map
      "C-k" nil)

;; ***************
;; LSP
;; ***************

;; Detailed LSP logging
;; (setq lsp-log-io t)
;; (setq lsp-print-performance t)

;; support for mql
(add-to-list 'auto-mode-alist '("\\.mq[45h]?\\'" . c++-mode))

;; make compile scroll to the bottom
;; done mainly because rust warnings can get pretty long
;; and you cant see the output
(after! compile
  (setq compilation-scroll-output t))

(add-hook 'markdown-mode-hook #'lsp)

;; Don't show warnings
(setq warning-minimum-level :error)

;; Use goimports instead of gofmt
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; Corfu LSP maps
(after! corfu
  (define-key corfu-map [return] #'corfu-insert)
  (define-key corfu-map (kbd "RET") #'corfu-insert))

(after! corfu
  (setq corfu-preselect 'first))

;; we can use SPC c x for fuzzy project diagnostics
;; (map! :n "gt" #'lsp-ui-flycheck-list)
;; since emacs lsp diags is slightly different - removing this to prevent overlap
;; (map! :after evil
;;       :nv "g t" nil)
;; show the error message under cursor
(map! :n "gt" #'flycheck-copy-errors-as-kill)
(map! :after lsp-mode
      :n "gr" #'lsp-find-references)
(map! :after lsp-mode
      :n "gi" #'lsp-find-implementation
      )

(after! lsp-mode
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t))

;; html auto close
(after! web-mode
  (setq web-mode-enable-auto-closing t))
(after! web-mode
  (setq web-mode-enable-auto-pairing t))

;; Copilot
;;(use-package! copilot
;;:hook (prog-mode . copilot-mode)
;;:bind (:map copilot-completion-map
;;("<tab>" . 'copilot-accept-completion)
;;("TAB" . 'copilot-accept-completion)
;;("C-TAB" . 'copilot-accept-completion-by-word)
;;("C-<tab>" . 'copilot-accept-completion-by-word)))

;; Rust
(after! lsp-rust
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-rust-analyzer-check-on-save t))

;; ***************
;; ORG
;; ***************

(setq org-directory "~/Library/Mobile Documents/com~apple~CloudDocs/org")
(setq org-agenda-files '("~/Library/Mobile Documents/com~apple~CloudDocs/org/personal"
                         "~/Library/Mobile Documents/com~apple~CloudDocs/org/work"
                         "~/Library/Mobile Documents/com~apple~CloudDocs/org/projects"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((http . t)
   ))

;; ***************
;; CUSTOM FUNCTIONS
;; ***************

(defun open-claude-chat ()
  "Open a new Claude chat in the default browser"
  (interactive)
  (browse-url "https://claude.ai/new"))

(map! :leader
      :desc "New Claude chat"
      "o c" #'open-claude-chat)

;;; ============================================================
;;; Settings
;;; ============================================================
;;; --------------------
;;; Center
;;; --------------------
;;; emacs-server
(server-start)
;;; Load-Path
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(add-to-list 'load-path "~/.emacs.d/auto-install")
;;; --------------------
;;; Display
;;; --------------------
;; no splash
(setq inhibit-splash-screen t)
;; fullscreen
(set-frame-parameter nil 'fullscreen 'maximized)
;; no menu bar
(menu-bar-mode -1)
;; no tool bar
;; (tool-bar-mode -1)
;; no startup screen
(setq inhibit-startup-screen t)
;; show paren
(show-paren-mode 1)
;; show line
; (global-hl-line-mode)
;; show mark
(setq transient-mark-mode t)
;; ls -al で ^[ を表示しない
; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;; --------------------
;;; Key
;;; --------------------
;; C-h に BackSpace を割り当て
(global-set-key "\C-h" 'delete-backward-char)
;;; --------------------
;;; Other
;;; --------------------
;; frame title の format
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))
;; diff 関係
(setq diff-switches "-u")
;; 外部アプリケーションとクリップボードを連携する
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)
;;; Cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;;; auto complete
(require 'auto-complete)
(global-auto-complete-mode t)
;;; jedi
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;;; powerline
(require 'powerline)
(set-face-attribute 'mode-line nil
		    :foreground "#fff"
		    :background "#FF0066"
		    :box nil)

(set-face-attribute 'powerline-active1 nil
		    :foreground "#fff"
		    :background "#FF6699"
		    :inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
		    :foreground "#000"
		    :background "#ffaeb9"
		    :inherit 'mode-line)
(powerline-default-theme)

;;; linum: 行表示
(require 'linum)
(global-linum-mode t)
;;; modes
(require 'markdown-mode)
(require 'twittering-mode)
(require 'go-mode-load)
(add-hook 'go-mode-hook
          '(lambda()
            (setq c-basic-offset 4)
	    (setq tab-width 4)
            (setq indent-tabs-mode t)
            (local-set-key (kbd "M-.") 'godef-jump)
            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
            (local-set-key (kbd "C-c i") 'go-goto-imports)
            (local-set-key (kbd "C-c d") 'godoc)
	    ))

(add-hook 'before-save-hook 'gofmt-before-save)
;; (require 'go-autocomplete)

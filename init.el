;;; init.el --- My init.el.

;;; Commentary:

;;; Code:
;; emacs-server
(server-start)
;; Load-Path
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(add-to-list 'load-path "~/.emacs.d/auto-install")

;;; Display
;; no splash
(setq inhibit-splash-screen t)
;; fullscreen
(set-frame-parameter nil 'fullscreen 'maximized)
;; no menu bar
(menu-bar-mode -1)
;; no tool bar
;; (tool-bar-mode 0)
;; no startup screen
(setq inhibit-startup-screen t)
;; show paren
(show-paren-mode 1)
;; show line
; (global-hl-line-mode)
;; insert line
(setq require-final-newline t)
;; show mark
(setq transient-mark-mode t)
;; ls -al で ^[ を表示しない
; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; whitespace
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
			 trailing       ; 行末
			 tabs           ; タブ
			 spaces         ; スペース
			 empty          ; 先頭/末尾の空行
			 space-mark     ; 表示のマッピング
			 tab-mark
			 ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
	;; WARNING: the mapping below has a problem.
	;; When a TAB occupies exactly one column, it will display the
	;; character ?\xBB at that column followed by a TAB which goes to
	;; the next TAB column.
	;; If this is a problem for you, please, comment the line below.
	(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
		    :background my/bg-color
		    :foreground "DeepPink"
		    :underline t)
(set-face-attribute 'whitespace-tab nil
		    :background my/bg-color
		    :foreground "LightSkyBlue"
		    :underline t)
(set-face-attribute 'whitespace-space nil
		    :background my/bg-color
		    :foreground "GreenYellow"
		    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
		                        :background my/bg-color)


;;; Key
;; C-h に BackSpace を割り当て
(global-set-key "\C-h" 'delete-backward-char)
;; C-j で改行時インデント
(global-set-key "\C-j" 'newline-and-indent)

;;; Other
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
;;; git
(require 'git-gutter)
(global-git-gutter-mode t)
(git-gutter:linum-setup)
(add-hook 'ruby-mode-hook 'git-gutter-mode)
(add-hook 'python-mode-hook 'git-gutter-mode)
(custom-set-variables
 '(git-gutter:window-width 2)
 '(git-gutter:modified-sign "☁")
 '(git-gutter:added-sign "☀")
 '(git-gutter:deleted-sign "☂"))
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
(require 'ruby-mode)
(require 'rspec-mode)
(require 'slim-mode)
;;; rspec settings
(add-hook 'ruby-mode-hook
          '(lambda()
	     (local-set-key (kbd "C-c s") 'rspec-verify-all)
	     ))
(add-hook 'rspec-mode-hook
          '(lambda()
	     (local-set-key (kbd "C-c s") 'rspec-verify-all)
	     ))
;;; rubocop
;; (require 'rubocop)
;; (add-hock 'ruby-mode-hook
;; 	  '(lambda()
;; 	     (setq flycheck-checker 'rubocop)
;; 	     (flycheck-mode 1)))
;; 保存時にmagic commentを追加しないようにする
(defadvice enh-ruby-mode-set-encoding (around stop-enh-ruby-mode-set-encoding)
  "If enh-ruby-not-insert-magic-comment is true, stops enh-ruby-mode-set-encoding."
  (if (and (boundp 'enh-ruby-not-insert-magic-comment)
           (not enh-ruby-not-insert-magic-comment))
       ad-do-it))
(ad-activate 'enh-ruby-mode-set-encoding)
(setq-default enh-ruby-not-insert-magic-comment t)
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))

(setenv "LANG" "ja_JP.UTF-8")
(setenv "LC_ALL" "ja_JP.UTF-8")

;;; php
(require 'php-mode)
(add-hook 'php-mode-user-hook
	  '(lambda ()
	     (setq tab-width 4)
	     (setq c-basic-offset 4)
	     (setq indent-tabs-mode nil)))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;; golang
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
(provide 'init)
;;; init.el ends here

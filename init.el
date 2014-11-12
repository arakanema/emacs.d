;;; init.el Masahiro Arakane scince Nov12, 2014
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; package list ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ample-theme        20141103.816 installed             Calm Dark Theme for Emacs
;  async              20141001.151 installed             Asynchronous processing in Emacs
;  git-commit-mode    20141014.... installed             Major mode for editing git commit messages
;  git-rebase-mode    20140928.... installed             Major mode for editing git rebase files
;  helm               20141111.... installed             Helm is an Emacs incremental and narrowing framework
;  magit              20141104.647 installed             control Git from Emacs
;  multiple-cursors   20141026.503 installed             Multiple cursors for Emacs.
;  org                20141110     installed             Outline-based notes management and organizer
;  powerline          20140516.... installed             Rewrite of Powerline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; パッケージリポジトリ
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;;; load-thema
(load-theme 'wombat t)
(load-theme 'ample t)
;;; バックアップファイルの作成をしない
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq vc-make-backup-files nil)
;; インデント
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;;; C-hでバックスペース
(keyboard-translate ?\C-h ?\C-?)
;;; 行番号
(global-linum-mode t)
;;; ウィンドウ移動
(define-key global-map (kbd "C-M-n") 'next-multiframe-window)
(define-key global-map (kbd "C-M-p") 'previous-multiframe-window)
;;; 画像ファイルを表示
(auto-image-file-mode t)
;;; メニューバー, ツールバー
(menu-bar-mode 0)
(tool-bar-mode 0)
;;; 対応する括弧をハイライト
(show-paren-mode t)
;;; 背景を半透明にする
(setq default-frame-alist
      (append (list
               '(alpha . (90 85))
               ) default-frame-alist))

;;;;;;;;;;;;;;;;;;;
;;; for packages ;;
;;;;;;;;;;;;;;;;;;;

;;; helm
(when (require 'helm-config nil t)
  (helm-mode 1))

;;; powerline
(when (require 'powerline nil t)
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
  (powerline-default-theme))

;;; org-mode
(require 'org-install)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
(setq org-agenda-files (list (expand-file-name "~/orgfiles")))
;(setq org-directory "~/orgfiles/")
;(setq org-default-notes-file "notes.org")
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(add-hook 'org-mode-hook 'turn-on-font-lock)

;;; multiple-cursors
(when (require 'multipe-cursors nil t)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))


;;;;;;;;;;;;;;
;;; for Mac ;;
;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (let* ((size 13)
  (jpfont "Hiragino Maru Gothic ProN")
  (asciifont "Monaco")
  (h (* size 10)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font t 'katakana-jisx0201 jpfont)
    (set-fontset-font t 'japanese-jisx0208 jpfont)
    (set-fontset-font t 'japanese-jisx0212 jpfont)
    (set-fontset-font t 'japanese-jisx0213-1 jpfont)
    (set-fontset-font t 'japanese-jisx0213-2 jpfont)
    (set-fontset-font t '(#x0080 . #x024F) asciifont))
  (setq face-font-rescale-alist
    '(("^-apple-hiragino.*" . 1.2)
    (".*-Hiragino Maru Gothic ProN-.*" . 1.2)
    (".*osaka-bold.*" . 1.2)
    (".*osaka-medium.*" . 1.2)
    (".*courier-bold-.*-mac-roman" . 1.0)
    (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
    (".*monaco-bold-.*-mac-roman" . 0.9)
    ("-cdac$" . 1.3)))
  )

;;;;;;;;;;;;;;;;;;
;;; for Windows ;;
;;;;;;;;;;;;;;;;;;
(when (memq window-system '(win32))
  (setq default-file-name-coding-system 'shift_jis)
  (set-face-attribute 'default nil :family "Consolas" :height 100)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo"))
  (setq face-font-rescale-alist '(("Meiryo" . 1.)))
  ;;; IMEの設定
  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[Aa]")
  (setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))
  (w32-ime-initialize)
  ;; IMEのON/OFFでカーソルの色を変える
  (set-cursor-color "black")
  (add-hook 'input-method-activate-hook
            (lambda() (set-cursor-color "darkred")))
  (add-hook 'input-method-inactivate-hook
            (lambda() (set-cursor-color "black")))
  ;; バッファ切り替え時にIME状態を引き継ぐ
  (setq w32-ime-buffer-switch-p nil)
  )


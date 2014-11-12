;;; init.el Masahiro Arakane scince Nov12, 2014
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;; パッケージリポジトリ
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;;; バックアップファイルの作成をしない
(setq-default make-backup-files nil)
;; インデント
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;;; C-hでバックスペース
(keyboard-translate ?\C-h ?\C-?)
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
;;; Windows
(setq default-file-name-coding-system 'shift_jis)
(set-face-attribute 'default nil :family "Consolas" :height 100)
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo"))
(setq face-font-rescale-alist '(("Meiryo" . 1.08)))


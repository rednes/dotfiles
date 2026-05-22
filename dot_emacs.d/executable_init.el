;; el-getの設定
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle auto-complete)
(el-get-bundle editorconfig)
(el-get-bundle web-mode)
(el-get-bundle yaml-mode)
(el-get-bundle typescript-mode)
(el-get-bundle flycheck)
(el-get-bundle markdown-mode)


;; ロードパス
(add-to-list 'load-path "~/.emacs.d/elisp")

;;; 行数表示
(line-number-mode t)
;;; 文字数表示
(column-number-mode t)
;;; 括弧の対応を色付
(show-paren-mode t)
;;; 色を付ける
(global-font-lock-mode t)
;;; フレーム間をshift+矢印で移動
(windmove-default-keybindings)

;;; *.~ とかのバックアップファイルを特定のフォルダに作成
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
                backup-directory-alist))

;;; .#* とかの自動保存ファイルを特定のフォルダに作成
(setq auto-save-default t)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;;; 自動保存ファイルのリストファイルを特定のフォルダに作成
(setq auto-save-list-file-prefix t)
(setq auto-save-list-file-prefix "~/.emacs.d/backup/.saves-")

;; 複数ウィンドウを開かないようにする
(setq ns-pop-up-frames nil)

;; タブの無効化
(setq-default indent-tabs-mode nil)

;; 全角スペースに緑の色づけ。全角スペースは罠だよ =(
;; タブに青の色づけ。
;; 行末空白にピンクの色づけ。
(defface my-face-b-1 '((t (:background "green"))) nil)
(defface my-face-b-2 '((t (:background "blue"))) nil)
(defface my-face-b-3 '((t (:background "pink"))) nil) 
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-b-3 'my-face-b-3)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-b-3 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; Ctrl h をBackSpaceにする
(global-set-key "\C-h" 'delete-backward-char)

;; Ctrl h をBackSpaceにしたばっかりに、ヘルプが使えなくなったんでCtrl x Ctrl hに割り当て。
(global-set-key "\C-x\C-hf" 'describe-function)
(global-set-key "\C-x\C-hk" 'describe-key)
(global-set-key "\C-x\C-hw" 'where-is)
(global-set-key "\C-x\C-hv" 'describe-variable)
(global-set-key "\C-x\C-hb" 'describe-bindings)
(global-set-key "\C-x\C-ha" 'command-aprpos)
(global-set-key "\C-x\C-hh" 'help-for-help)
(global-set-key "\C-x\C-hc" 'describe-key-briefly)

;; Ctrl c r を comment-or-uncomment-regionのショートカットにする
(global-set-key "\C-cr" 'comment-or-uncomment-region)

;; Ctrl x g を magit-statusのショートカットにする
(global-set-key (kbd "C-x g") 'magit-status)

;; editorconfigの起動
(editorconfig-mode 1)

;; json-modeの設定
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; auto-completeの設定
(global-auto-complete-mode t)
(setq ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat") 

(define-key ac-complete-mode-map "\C-\M-n" 'ac-next)
(define-key ac-complete-mode-map "\C-\M-p" 'ac-previous)

;; yaml-modeの設定
(add-to-list 'auto-mode-alist '("¥¥.yml$" . yaml-mode))

;; flycheckの設定
(add-hook 'after-init-hook #'global-flycheck-mode)

;; MacのEmacsだった場合
(when (eq system-type 'darwin)
  ;; CommandとOptionを入れ替える
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super)))


;; ターミナル外のEmacsだった場合
(when (memq window-system '(ns))
  (global-set-key [s-mouse-1] 'browse-url-at-mouse)
  (let* ((size 12)
         (jpfont "Hiragino Maru Gothic ProN")
         (asciifont "Monaco")
         (h (* size 12)))
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
  ;; C-x 5 2 で新しいフレームを作ったときに同じフォントを使う
  (setq frame-inherited-parameters '(font tool-bar-lines))
  ;; emacs-server
  (server-start)
  ;; メニューバーの消去
  (tool-bar-mode -1)
  ;; 起動時のウィンドウサイズ、色など
  (if (boundp 'window-system)
      (setq default-frame-alist
            (append (list
                     '(foreground-color . "black")
                     '(background-color . "white")
                     '(top . 20) ;ウィンドウの表示位置(Y座標)
                     '(left . 400) ;ウィンドウの表示位置(X座標）
                     '(width . 120) ;ウィンドウ幅
                     '(height . 45) ;ウィンドウ高
                     )
                    default-frame-alist)
            )
    )
  (setq initial-frame-alist default-frame-alist)
  ;; Emacsのフレームを透明に
  (modify-all-frames-parameters
   (list (cons 'alpha  '(80 60 70 50)))))

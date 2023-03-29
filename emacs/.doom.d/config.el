;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Marco Ribeiro"
      user-mail-address "marrbr@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "MonoLisa" :size 14))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-tomorrow-night)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/notes")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

(setq browse-url-browser-function 'browse-url-chrome) ; google's browser

(setq org-babel-clojure-backend 'cider)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)

(add-hook 'prog-mode-hook 'evil-lion-mode)

(setq deft-directory "~/Notes"
      deft-extensions '("org" "txt")
      deft-recursive t)

(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "en_US,pt_BR")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,pt_BR"))

;; Functions
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(after! org
  (map! :map org-mode-map
        :n "m-j" #'org-metadown
        :n "m-k" #'org-metaup))

(setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

;; Keybindings
(with-eval-after-load 'evil-maps
  (map!
   :niv "C-M-k"  #'move-line-up
   :niv "C-M-j"  #'move-line-down
   :n "z l"      #'hs-hide-level
   :ne "M-/"     #'comment-or-uncomment-region
   :ne "SPC s z" #'counsel-fzf
   ;;:ne "SPC s x" #'counsel-projectile-rg
   :ne "SPC s x" #'consult-ripgrep
   :ne "SPC c p" #'prettier-js
   :ne "SPC m X" #'(org-hugo-export-wim-to-md :all-subtrees)
   :nvie "C-h"   #'evil-window-left
   :nvie "C-j"   #'evil-window-down
   :nvie "C-k"   #'evil-window-up
   :nvie "C-l"   #'evil-window-right))

(setenv "NODE_PATH"
   (concat
    (getenv "HOME") "/org/node_modules"  ":"
    (getenv "NODE_PATH")
  )
)

(defun affe-orderless-regexp-compiler (input _type)
  (setq input (orderless-pattern-compiler input))
  (cons input (lambda (str) (orderless--highlight input str))))
(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)
;; (setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/.cargo/env" ))

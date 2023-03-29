(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/config/atividades.org" "/home/marco/org/code-js.org" "/home/marco/org/corrais-parcelas.org" "/home/marco/org/cursos.org" "/home/marco/org/emacs.org" "/home/marco/org/english-expressions.org" "/home/marco/org/english.org" "/home/marco/org/fastai.org" "/home/marco/org/future-continuous.org" "/home/marco/org/future-perfect-continuous.org" "/home/marco/org/future-perfect-simple.org" "/home/marco/org/future-simple-or-present-simple.org" "/home/marco/org/future-simple.org" "/home/marco/org/hadoop.org" "/home/marco/org/leetcode.org" "/home/marco/org/machine_learning.org" "/home/marco/org/mixed-future-tenses.org" "/home/marco/org/past-continuous.org" "/home/marco/org/past-participle.org" "/home/marco/org/past-perfect-continuous-or-past-simple.org" "/home/marco/org/past-perfect-continuous.org" "/home/marco/org/past-perfect-or-past-simple.org" "/home/marco/org/past-perfect-simple.org" "/home/marco/org/past-simple-be.org" "/home/marco/org/past-simple-mixed.org" "/home/marco/org/past-simple-or-continuous.org" "/home/marco/org/past-simple-or-present-perfect.org" "/home/marco/org/past-simple.org" "/home/marco/org/present-continuous.org" "/home/marco/org/present-perfect-continuous.org" "/home/marco/org/present-perfect-simple-or-continuous.org" "/home/marco/org/present-perfect.org" "/home/marco/org/present-simple-or-present-continuous.org" "/home/marco/org/present-simple.org" "/home/marco/org/summaries.org" "/home/marco/org/todo.org" "/home/marco/org/tonge.org" "/home/marco/org/training.org" "/home/marco/org/vim.org"))
 '(package-selected-packages '(ob-rust)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "./org_imgs/")
  (org-download-heading-lvl 0)
  (org-download-timestamp "org_%Y%m%d-%H%M%S_")
  ;;(org-image-actual-width 900)
  (org-download-screenshot-method "xclip -selection clipboard -t image/png -o > '%s'")
  :bind
  ("C-M-y" . org-download-screenshot)
  :config
  (require 'org-download))


(defun consult-ripgrep-single-file ()
    "Call `consult-ripgrep' for the current buffer (a single file)."
    (interactive)
    (let ((consult-project-function (lambda (x) nil))
          (consult-ripgrep-args
           (concat "rg "
                   "--null "
                   "--line-buffered "
                   "--color=never "
                   "--line-number "
                   "--smart-case "
                   "--no-heading "
                   "--max-columns=1000 "
                   "--max-columns-preview "
                   "--with-filename "
                   (shell-quote-argument buffer-file-name))))
      (consult-ripgrep)))


(defun consult-git-ripgrep (&optional dir initial)
  "Search for regexp with rg in DIR with INITIAL input.

See `consult-grep' for more details."
  (interactive "P")
  (consult--grep "Ripgrep" #'consult--git-grep-builder dir initial))


(defun bms/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
 (interactive)
 (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))
(global-set-key (kbd "C-c rr") 'bms/org-roam-rg-search)

;;
;; init file
;;

(setq inhibit-splash-screen t)
(menu-bar-mode -1)

(transient-mark-mode 1)

;; Nice window movement
(windmove-default-keybindings)

(require 'org)
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
(global-set-key "\C-ca" 'org-agenda)
;; (global-set-key (kbd "C-c [") 'org-

;; Leader-like behavior

;;(global-set-key (kbd "; ;") ";")
;;(global-set-key (kbd ";-j") "C-n")

(global-unset-key (kbd "C-x r r"))
(global-set-key (kbd "C-x r r") '(eval user-init-file))
(global-unset-key (kbd "C-x v r"))
(global-set-key (kbd "C-x v r") '(find-file ~/.emacs))

;; (global-set-key (kbd "C-x r r") (load user-init-file))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("/Users/leo/org/1.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(menu-bar-mode -1)
(show-paren-mode 't)
(ido-mode 't)

(setq inhibit-splash-screen 't)

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; Installed by package-install.el
(when (load (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;; Thanks to: http://blog.bookworm.at/2007/03/pretty-print-xml-with-emacs.html
(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. The function inserts linebreaks
to separate tags that have nothing but whitespace between them.  It
then indents the markup by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) (insert "\n"))
    (indent-region begin end nil)))

;; Emacs backup file handling
(setq backup-directory-alist `(("." . ".emacs-backup")))
 
;;; Thanks to: http://blog.zenspider.com/2007/09/emacs-is-ber.html
(defadvice find-file-at-point (around goto-line compile activate)
  (let ((line (and (looking-at ".*:\\([0-9]+\\)")
                   (string-to-number (match-string 1)))))
    ad-do-it
    (and line (goto-line line))))

;;; Thanks to: http://www.xsteve.at/prg/emacs/power-user-tips.html
(require 'ffap)
(setq ffap-bindings '((global-set-key "\C-xF" 'find-file-at-point))) ; Don't break ido-mode
(ffap-bindings)

;;; Thanks to http://trey-jackson.blogspot.com/2008/01/emacs-tip-11-uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;;; Thanks to http://www.joegrossberg.com/archives/000182.html
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ r" 'recentf-open-files)

;; Shell color
;; See http://www.emacswiki.org/emacs/AnsiColor
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Paredit for Clojure and the Slime REPL
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
(setq clojure-enable-paredit t)

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "C-c 0") 'paredit-forward-slurp-sexp)
	  (define-key paredit-mode-map (kbd "C-c )") 'paredit-forward-barf-sexp)
	  (define-key paredit-mode-map (kbd "C-c 9") 'paredit-backward-slurp-sexp)
	  (define-key paredit-mode-map (kbd "C-c (") 'paredit-backward-barf-sexp)
	  (define-key paredit-mode-map (kbd "M-R") 'paredit-raise-sexp)
	  (define-key paredit-mode-map (kbd "M-r") nil)))
					; So as to not conflict with
					; slime-repl-previous-matching-input

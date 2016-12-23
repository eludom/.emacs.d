
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(message "init.el ran")

; George Jones' ~/.emacs.d/init.el

(setq debug-on-error t) ;; uncomment when there are problems


; use install-package to instll latest org-plus-contrib
;
; then
;
; Load current melpa version of org, not system version

(dolist (word  (directory-files (expand-file-name "~/.emacs.d/elpa/") t "^org-plus-contrib-*"))
  ; may not get the right/latest version if there are multiple versions in ~/.emacs.d/elpa/
  (if (file-exists-p word)
      (progn
	(setq elisp-dir word)
	(add-to-list 'load-path word)
	(message (format "addeded to load path: %s"  elisp-dir)))))
 
;(add-to-list 'load-path "~/.emacs.d/elpa/org-plus-contrib-20161102/")
;(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/notmuch")

;; Load the rest of the packages
;(package-initialize nil)
;(setq package-enable-at-startup nil)

; pull in my main .org init file.  This is where most of the fun is.
(org-babel-load-file "~/.emacs.d/george.org")

; because junk I don't want to share in git keeps showing up here
(setq custom-file "~/elisp-secret/emacs-custom.el")
; Create path to custom-file if it does not exist
;unless (file-exists-p custom-file)
;  (let ((dir (file-name-directory custom-file)))
;    (unless (file-exists-p dir)
;              (make-directory dir))))
; Create empty custom file if it does not exist
(when (not (file-exists-p custom-file))
  (with-temp-buffer (write-file custom-file)))
(load custom-file)

(message "init.el finished.")
(put 'downcase-region 'disabled nil)

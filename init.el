(message "init.el ran")

; George Jones' ~/.emacs.d/init.el

(setq debug-on-error t) ;; uncomment when there are problems

; https://www.emacswiki.org/emacs/ELPA

;   it could be easier just to move package-initialize to another point
;   during startup so you can (require) ELPA packages; 

(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

; Make sure we use the right version of org-mode:
;
; This has to happen here (not in george.org loaded later in this file)
; to make sure we load the latest verson of org, not the system/default
; version.

(dolist (word  (directory-files (expand-file-name "~/.emacs.d/elpa/") t "^org-plus-contrib-*"))
  ; may not get the right/latest version if there are multiple versions in ~/.emacs.d/elpa/
  (if (file-exists-p word)
      (progn
	(setq elisp-dir word)
	(add-to-list 'load-path word)
	(message (format "addeded to load path: %s"  elisp-dir)))))


; pull in my main .org init file.  This is where most of the fun is.
(org-babel-load-file "~/.emacs.d/george.org")

; because junk I don't want to share in git keeps showing up here
(setq custom-file "~/elisp-secret/emacs-custom.el")

; Create empty custom file if it does not exist
(when (not (file-exists-p custom-file))
  (with-temp-buffer (write-file custom-file)))
(load custom-file)

(message "init.el finished.")
(put 'downcase-region 'disabled nil)

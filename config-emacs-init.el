(message "init.el ran")

; George Jones' ~/.emacs.d/init.el

(setq debug-on-error t) ;; uncomment when there are problems

; https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name


(require 'package)

; Where do we get packages?
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

; which packages do we want
(setq package-list '(better-shell cyberpunk-theme guide-key helm helm-core magit  notmuch ob-ipython  org-plus-contrib htmlize password-store popup popwin twittering-mode which-key with-editor xah-fly-keys))

; Old (pre 2019-10-26) list
;(setq package-list '(annotate better-shell cyberpunk-theme guide-key helm helm-core magit git-commit ql magit-popup notmuch ob-ipython dash-functional org-plus-contrib org2blog htmlize metaweblog ox-hugo org password-store f dash popup popwin s treepy twittering-mode which-key with-editor async xah-fly-keys xah-lookup xml-rpc))


; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

(setq load-prefer-newer t)

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


; Load xah-fly-keys early 'case its my fingers default now
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "qwerty")
(xah-fly-keys 1)
(global-set-key (kbd "<home>") 'xah-fly-insert-mode-activate)


; Make sure we use the right version of org-mode:
;
; This has to happen here (not in george.org loaded later in this file)
; to make sure we load the latest verson of org, not the system/default
; version.


;(add-to-list 'load-path "/home/gmj/public/ob-ipython")

; pull in my main .org init file.  This is where most of the fun is.
(org-babel-load-file "~/.emacs.d/george.org")

; because junk I don't want to share in git keeps showing up here
(setq custom-file "~/elisp-secret/emacs-custom.el")

; Create empty custom file if it does not exist
(when (not (file-exists-p custom-file))
  (with-temp-buffer (write-file custom-file)))
(load custom-file)

(put 'downcase-region 'disabled nil)

(message "init.el finished.")


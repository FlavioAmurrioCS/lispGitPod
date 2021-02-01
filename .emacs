;;;;;;; THE SIMPLE EMACS FILE FOR YOU TO CHECK OUT
;;;;;;; Hopefully you will find this useful.



;;;;; SLIME STUFF

;;; Change where emacs looks for its libraries (like SLIME)
(setq load-path (cons "~/slime" load-path))

;;; Turn on SLIME
(require 'slime-autoloads)

;;; Tell EMACS and SLIME to use SBCL as the inferior lisp process
;;; when doing Lisp coding
(setq inferior-lisp-program "~/.roswell/impls/x86-64/linux/sbcl-bin/2.0.11/bin/sbcl")

;;; [I like to do this] Set it up so that if you press KEYPAD ENTER
;;; (or shift-RETURN), Lisp expressions are automatically sent to the compiler.
(global-set-key [kp-enter] 'slime-eval-defun)
(global-set-key (kbd "M-RET") 'slime-eval-defun)



;;;;; STUFF THAT WILL MAKE EMACS NICER TO USE

;;; Normally Lisp requires you to literally type "yes" or "no" to
;;; verify things.  This changes it to "y" or "n"
(fset 'yes-or-no-p 'y-or-n-p)

;;; Set the tab width to 4 and force Emacs to use spaces rather than tabs
(setq tab-width 4)
(setq indent-tabs-mode nil)

;;; Turn on fonts and coloring
(global-font-lock-mode t)

;;; Get rid of GUI tooltips and "menus" in the terminal window (but not the GUI)
(tooltip-mode -1)
(setq tooltip-use-echo-area t)
(when (not (display-graphic-p))
  (menu-bar-mode -1))

;;; Allow the minibuffer (the status line at the bottom of the window) to be
;;; as big as it needs
(setq minibuffer-max-depth nil)

;;; Get rid of the startup messag
(setq inhibit-startup-message t)  ;; old emacs
(setq inhibit-startup-echo-area-message "flavor") ;; new emacs

;;; Turn on line numbering
(line-number-mode t)
(slime)

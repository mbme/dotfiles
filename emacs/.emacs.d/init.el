;;; init.el --- mbme main emacs config file
;;; Commentary:
;; Part of code is from
;; * Emacs Prelude https://github.com/bbatsov/prelude
;; * Emacs Graphene https://github.com/rdallasgray/graphene
;; * Spacemacs https://github.com/syl20bnr/spacemacs
;; * Ohai https://github.com/bodil/ohai-emacs
;;; Code:



;; ---------------------------------------- VARS



(defvar mb-is-mac-os (eq system-type 'darwin))
(defvar mb-is-linux (eq system-type 'gnu/linux))

;; base configs dir
(defvar mb-dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; dir for temp files
(defvar mb-save-path (expand-file-name "save-files/" mb-dotfiles-dir))


;; (defvar mb-font "inconsolata:spacing=100")
;; (defvar mb-font "source code pro:spacing=100")
;; (defvar mb-font "ubuntu mono:spacing=100")
;; (defvar mb-font "droid sans mono:spacing=100")
;; (defvar mb-font "meslo lg s dz:spacing=100")
;; (defvar mb-font "liberation mono:spacing=100")
;; (defvar mb-font "roboto:spacing=100")
;; (defvar mb-font "roboto condensed:spacing=100")

(defvar mb-font (if mb-is-mac-os "menlo-13" "dejavu sans mono-12"))

(defvar mb-tab-size        4)
(defvar mb-web-indent-size 2)
(defvar mb-encoding        'utf-8)

;; general colors
(defvar mb-color1  "#f2f1f0")
(defvar mb-color2  "#b58900")
(defvar mb-color3  "#586e75")
(defvar mb-color4  "#465a61")
(defvar mb-color5  "#93a1a1")
(defvar mb-color6  "#073642")
(defvar mb-color7  "#E74C3C")
(defvar mb-color8  "#8aa234")
(defvar mb-color9  "#FF851B")
(defvar mb-color10 "#3498DB")
(defvar mb-color11 "#9B59B6")
(defvar mb-color12 "#e3e3d3")
(defvar mb-color13 "#EEE8D5")

;; status bar colors for evil states
(defvar  mb-evil-insert-face    mb-color8)
(defvar  mb-evil-normal-face    mb-color7)
(defvar  mb-evil-visual-face    mb-color2)
(defvar  mb-evil-emacs-face     mb-color11)
(defvar  mb-evil-replace-face   mb-color6)
(defvar  mb-evil-operator-face  mb-color10)

;; load local settings if file exists
(load (expand-file-name "local.el" mb-dotfiles-dir) t)



;; ---------------------------------------- INIT



(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-verbose t)

;; Diminish: cleanup mode line
(require 'diminish)

(require 'bind-key)

;; create temp files dir if it does not exists
(unless (file-exists-p mb-save-path)
  (make-directory mb-save-path))



;; ---------------------------------------- CONFIG



;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode)   (menu-bar-mode   -1))
(if (fboundp 'tool-bar-mode)   (tool-bar-mode   -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq-default
 frame-title-format '(buffer-file-name "%f" ("%b"))
 ;; no beep and blinking
 visible-bell       nil
 ring-bell-function 'ignore

 ;; scroll one line at a time (less "jumpy" than defaults)
 mouse-wheel-scroll-amount '(2 ((shift) . 2))
 ;; don't accelerate scrolling
 mouse-wheel-progressive-speed nil
 ;; scroll window under mouse
 mouse-wheel-follow-mouse 't
 ;; keyboard scroll one line at a time
 scroll-step 1

 ;; display column numbers in status line
 column-number-mode t
 ;; display line numbers in status line
 line-number-mode t
 ;; max line number to show
 line-number-display-limit 999999
 ;; max line width after which you will see ??? instead of line number
 line-number-display-limit-width 999999

 ;; draw underline lower
 x-underline-at-descent-line t

 ;; Show keystrokes in progress
 echo-keystrokes 0.1

 ;; hide empty lines after buffer end
 indicate-empty-lines nil

 font-lock-maximum-decoration t
 color-theme-is-global t

 ;; Don't defer screen updates when performing operations.
 redisplay-dont-pause t

 ;; do not break line even if its too long
 truncate-lines t
 truncate-partial-width-windows t)

(tooltip-mode -1)
(blink-cursor-mode t)

;; take the short answer, y/n is yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; do not ask if I want to execute `eval' from dir-locals
(setq enable-local-eval t)
;; do not ask if I want to set variables from dir-locals
(setq enable-local-variables :all)

;; make urls in comments/strings clickable
(add-hook 'find-file-hooks 'goto-address-prog-mode)

;; Font
(setq-default default-font mb-font)
;; set font for all windows
(add-to-list 'default-frame-alist `(font . ,mb-font))


;; Enable disabled features
(put 'downcase-region           'disabled nil)
(put 'upcase-region             'disabled nil)
(put 'narrow-to-region          'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq-default
 ;; disable startup screen
 inhibit-startup-screen t
 ;; remove message from scratch
 initial-scratch-message nil
 ;; start scratch in text mode (usefull to get a faster Emacs load time
 ;; because it avoids autoloads of elisp modes)
 initial-major-mode 'text-mode

 ;; reduce the frequency of garbage collection by making it happen on
 ;; each 30MB of allocated data (the default is on every 0.76MB)
 gc-cons-threshold 30000000

 ;; prevent creating backup files
 make-backup-files nil
 ;; prevent creating .save files
 auto-save-list-file-name nil
 ;; prevent auto saving
 auto-save-default nil
 create-lockfiles nil

 enable-recursive-minibuffers t

 ;; Always rescan buffer for imenu
 imenu-auto-rescan t

 ;; Add ukrainian input method
 default-input-method "ukrainian-computer"

 ;; set default mode for unknown files
 major-mode 'text-mode

 ;; compilation mode
 compilation-scroll-output t
 compilation-ask-about-save nil
 compilation-save-buffers-predicate '(lambda () nil)

 ;; move files to trash when deleting
 delete-by-moving-to-trash t)

;; Encoding
(set-language-environment     mb-encoding)
(set-default-coding-systems   mb-encoding)
(setq locale-coding-system    mb-encoding)
(set-terminal-coding-system   mb-encoding)
(set-keyboard-coding-system   mb-encoding)
(set-selection-coding-system  mb-encoding)
(prefer-coding-system         mb-encoding)

;; dir to save info about interrupted sessions
(setq auto-save-list-file-prefix mb-save-path)

;; Transparently open compressed files
(auto-compression-mode t)

;; Automatically update unmodified buffers whose files have changed.
(global-auto-revert-mode t)

;; Tabs: use only spaces for indent
(setq-default
 indent-tabs-mode  nil
 tab-always-indent nil

 tab-width          mb-tab-size
 c-basic-offset     mb-tab-size
 py-indent-offset   mb-tab-size)

(setq-default
 ;; Sentences do not need double spaces to end
 sentence-end-double-space nil

 ;; lines should be 80 characters wide, not 72
 fill-column 80)

;; copy-paste (work with both terminal (S-INS) and X11 apps.):
(when (and mb-is-linux (> (display-color-cells) 16)) ;if linux and not in CLI
  ;;copy-paste should work (default in emacs24)
  (setq x-select-enable-clipboard t
        ;; with other X-clients
        interprogram-paste-function 'x-cut-buffer-or-selection-value))




;; ---------------------------------------- UTILS




(defun mb/prev-buffer ()
  "Switch to previous buffer."
  (interactive)
  (mode-line-other-buffer))

(defun mb/untabify-buffer ()
  "Replace tabs with spaces in buffer."
  (interactive)
  (untabify (point-min) (point-max))
  (message "mb: untabify buffer"))

(defun mb/indent-buffer ()
  "Reindent buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun mb/cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (mb/indent-buffer)
  (whitespace-cleanup)
  (message "mb: cleanup and indent buffer"))

(defun mb/rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "mb: Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun mb/delete-current-buffer-file ()
  "Remove file connected to current buffer and kill buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "mb: File '%s' successfully removed" filename)))))

(defun mb/launch-application (application-name &rest args)
  "Asynchronously start application APPLICATION-NAME with ARGS.
It wouldn't be associated with the buffer."
  (interactive)
  (apply 'start-process
         (-concat (list application-name nil application-name) args))
  (message "mb: started %s %S" application-name args))

(defun mb/terminal (&rest args)
  "Launches terminal emulator with ARGS."
  (interactive)
  (let ((commands (if mb-is-mac-os
                      (-concat (list "open" "-a" "Terminal" default-directory) args)
                    (-concat (list "termite") args))))
    (apply 'mb/launch-application commands)))

(defun mb/projectile-base-term (&rest args)
  "Launches terminal in projectile root with ARGS."
  (interactive)
  (message default-directory)
  (let ((default-directory (projectile-project-root)))
    (apply 'mb/terminal args)))

(defun mb/company-complete-common-or-selection ()
  "Complete common part if there is one, or insert selected candidate."
  (interactive)
  (when (company-manual-begin)
    (let ((tick (buffer-chars-modified-tick)))
      (call-interactively 'company-complete-common)
      (when (eq tick (buffer-chars-modified-tick))
        (call-interactively 'company-complete-selection)))))


(defun mb/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (right-char)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))


(defun mb/revert-buffer ()
  "Revert active buffer without asking."
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Reverted buffer " (buffer-name))))

(defun mb/narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens.  Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

(defun mb/sort-columns ()
  "Align selected columns using `column'."
  (interactive)
  (let (beg end column-command)
    (setq column-command (if mb-is-linux "column -o \" \" -t" "column -t"))
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (shell-command-on-region beg end column-command (current-buffer) t nil)))

(defun mb/run-command (command)
  "Save and run COMMAND in current project if defined."
  (interactive)
  (when command
    (save-buffer)
    (mb/projectile-base-term "-e" command "--hold")))

(defun mb/display-ansi-colors ()
  "Replace ANSI escape chars with real colors in current buffer."
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;; @see https://stackoverflow.com/questions/20863386/idomenu-not-working-in-javascript-mode
;; @see https://github.com/redguardtoo/emacs.d/blob/master/lisp/init-javascript.el
(defun mb/imenu-js-make-index ()
  "Create imenu for javascript file."
  (imenu--generic-function '(("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                             ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                             ("Class"    "class[ \t]+\\([a-zA-Z0-9_$.]+\\([ \t]+extends[ \t]+[a-zA-Z0-9_$.]+\\)?\\)[ \t]*{" 1)
                             ("Method" "[ \t{]\\([a-zA-Z0-9_$.]+\\):[ \t]*function[ \t]*(" 1)
                             ("Method"   "^[ \t]+\\([a-zA-Z0-9_$]+\\)[ \t]*([a-zA-Z0-9_$, {}:=]*)[ \t]*{" 1)
                             )))

;; FIXME check for unsaved changes before running this
(defun mb/eslint-fix-file ()
  "Fix some issues in current file using `eslint --fix'."
  (interactive)
  (message "mb: eslint --fix this file")
  (when (buffer-modified-p)
    (save-buffer))
  (shell-command (concat "eslint --fix " (buffer-file-name)))
  ;; revert buffer to see changes in FS
  (revert-buffer t t))


(defun mb/advice-add-to-evil-jump-list (origin-fun &rest args)
  "Save current pos to evil jump list before executing ORIGIN-FUN with ARGS."
  (evil-set-jump)
  (apply origin-fun args))

(defun mb/advice-ensure-evil-insert-state (origin-fun &rest args)
  "Ensure that evil is in insert state before executing ORIGIN-FUN with ARGS."
  (evil-insert-state)
  (apply origin-fun args))

;; @see https://emacs.stackexchange.com/questions/653/how-can-i-find-out-in-which-keymap-a-key-is-bound
(defun mb/key-binding-at-point (key)
  "Find keymap by KEY."
  (mapcar (lambda (keymap) (when (keymapp keymap)
                             (lookup-key keymap key)))
          (list
           ;; More likely
           (get-text-property (point) 'keymap)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'keymap))
                   (overlays-at (point)))
           ;; Less likely
           (get-text-property (point) 'local-map)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'local-map))
                   (overlays-at (point))))))

(defun mb/locate-key-binding (key)
  "Determine in which keymap KEY is defined."
  (interactive "kPress key: ")
  (let ((ret
         (list
          (mb/key-binding-at-point key)
          (minor-mode-key-binding key)
          (local-key-binding key)
          (global-key-binding key))))
    (when (called-interactively-p 'any)
      (message "At Point: %s\nMinor-mode: %s\nLocal: %s\nGlobal: %s"
               (or (nth 0 ret) "")
               (or (mapconcat (lambda (x) (format "%s: %s" (car x) (cdr x)))
                              (nth 1 ret) "\n             ")
                   "")
               (or (nth 2 ret) "")
               (or (nth 3 ret) "")))
    ret))


(defun mb/ensure-bin-tool-exists (name)
  "Check if bin tool `NAME' exists and show warning if it doesn't."
  (if (executable-find name)
      (message "MB: found required bin tool %s" name)
    (warn "MB: executable %s not found!" name)))



;; ---------------------------------------- PLUGINS



;; Fix PATH on Mac
(use-package exec-path-from-shell
  :ensure t

  :if mb-is-mac-os

  :config
  (exec-path-from-shell-initialize)
  ;; Use GNU ls as `gls' from `coreutils' if available.  Add `(setq
  ;; dired-use-ls-dired nil)' to your config to suppress the Dired warning when
  ;; not using GNU ls.  We must look for `gls' after `exec-path-from-shell' was
  ;; initialized to make sure that `gls' is in `exec-path'
  (let ((gls (executable-find "gls")))
    (when gls
      (setq insert-directory-program gls
            dired-listing-switches "-aBhl --group-directories-first"))))



;; Dash.el modern list library (helpers)
(use-package dash
  :ensure t
  :config (dash-enable-font-lock))



;; s.el strings manipulation library
(use-package s
  :ensure t)



;; Solarized theme
(use-package solarized-theme
  :ensure t
  :config
  ;; selection (region) colors
  (set-face-attribute 'region nil
                      :background mb-color12
                      :foreground mb-color6)

  (load-theme 'solarized-light t))



;; Undo-tree: save/show undo tree
;; also required by evil
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff       t))



;; Evil: vim mode

;; enable subword mode CamelCase movement in evil
(define-category ?U "Uppercase")
(define-category ?u "Lowercase")
(modify-category-entry (cons ?A ?Z) ?U)
(modify-category-entry (cons ?a ?z) ?u)
(make-variable-buffer-local 'evil-cjk-word-separating-categories)
(add-hook 'subword-mode-hook
          '(lambda ()
             (if subword-mode
                 (push '(?u . ?U) evil-cjk-word-separating-categories)
               (setq evil-cjk-word-separating-categories (default-value 'evil-cjk-word-separating-categories)))))

(use-package evil
  :ensure t
  ;; this must be set before loading evil
  :init
  ;; use C-u as scroll-up
  (defvar evil-want-C-u-scroll t)
  (defvar evil-want-Y-yank-to-eol t)
  (defvar evil-want-C-i-jump t)

  :config
  ;; vim leader feature
  (use-package evil-leader
    :ensure t
    :config
    (setq evil-leader/in-all-states     t
          evil-leader/non-normal-prefix "M-")
    (global-set-key (kbd "M-<SPC>") evil-leader--default-map)
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode))

  ;; emulates surround.vim
  (use-package evil-surround
    :ensure t
    :config (global-evil-surround-mode 1))

  ;; search for selected text with * and #
  (use-package evil-visualstar
    :ensure t
    :config (global-evil-visualstar-mode 1))

  ;; match braces/tags with %
  (use-package evil-matchit
    :ensure t
    :config
    (global-evil-matchit-mode 1)
    (advice-add 'evilmi-jump-items :around #'mb/advice-add-to-evil-jump-list))

  ;; exchange with objects
  (use-package evil-exchange
    :ensure t
    :config (evil-exchange-install))

  ;; comment/uncomment
  (use-package evil-nerd-commenter
    :ensure t
    :config
    (evil-leader/set-key
      "ci" 'evilnc-comment-or-uncomment-lines
      "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
      "cc" 'evilnc-copy-and-comment-lines
      "cp" 'evilnc-comment-or-uncomment-paragraphs
      "cr" 'comment-or-uncomment-region
      "cv" 'evilnc-toggle-invert-comment-line-by-line))

  (setq
   evil-shift-width mb-tab-size
   ;; more granular undo
   evil-want-fine-undo t
   evil-flash-delay 10
   ;; Don't wait for any other keys after escape is pressed.
   evil-esc-delay 0
   ;; h/l do not wrap around to next lines
   evil-cross-lines nil
   evil-want-visual-char-semi-exclusive t
   ;; do not move cursor back 1 position when exiting insert mode
   evil-move-cursor-back nil
   ;; search for whole words not only for part
   evil-symbol-word-search 'symbol)

  ;; Exit to normal state after save
  (add-hook 'after-save-hook 'evil-normal-state)


  ;; cursor colors for evil states
  (setq  evil-emacs-state-cursor     (list  mb-evil-emacs-face     'box)
         evil-normal-state-cursor    (list  mb-evil-normal-face    'hollow)
         evil-visual-state-cursor    (list  mb-evil-visual-face    'box)
         evil-insert-state-cursor    (list  mb-evil-insert-face    'bar)
         evil-replace-state-cursor   (list  mb-evil-replace-face   'hollow)
         evil-operator-state-cursor  (list  mb-evil-operator-face  'hollow))

  (cl-loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                                   (pylookup-mode . emacs)
                                   (comint-mode . normal)
                                   (shell-mode . insert)
                                   (term-mode . emacs)
                                   (help-mode . emacs)
                                   (grep-mode . emacs)
                                   (bc-menu-mode . emacs)
                                   (rdictcc-buffer-mode . emacs))
           do (evil-set-initial-state mode state))

  (evil-mode 1)

  ;; Use escape to quit, and not as a meta-key.
  (define-key evil-normal-state-map           [escape] 'keyboard-quit)
  (define-key evil-visual-state-map           [escape] 'keyboard-quit)
  (define-key minibuffer-local-map            [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map         [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map    [escape] 'minibuffer-keyboard-quit)

  (define-key evil-insert-state-map [escape] 'evil-normal-state)

  (evil-add-hjkl-bindings package-menu-mode-map 'emacs
    "H" 'package-menu-quick-help)

  ;; disable man look up
  (define-key evil-motion-state-map "K" nil)

  ;; insert tabs only in emacs state
  (define-key evil-motion-state-map (kbd "TAB")
    (lambda () (interactive) (if (evil-emacs-state-p) (indent-for-tab-command) (evil-jump-forward))))

  ;; insert newline only in emacs state
  (define-key evil-motion-state-map (kbd "RET")
    (lambda () (interactive) (when (evil-emacs-state-p) (newline))))

  (define-key evil-motion-state-map (kbd " ") nil)

  ;; in many modes q is close/exit etc., so leave it unbound
  (define-key evil-normal-state-map "q" nil)
  (define-key evil-normal-state-map "Q" 'evil-record-macro)
  (define-key evil-window-map "q" 'evil-window-delete)

  (define-key evil-normal-state-map (kbd "M-f") 'evil-scroll-page-down)
  (define-key evil-normal-state-map (kbd "M-b") 'evil-scroll-page-up)

  ;; move everywhere with M-hjkl
  (global-set-key (kbd "M-j") 'evil-next-line)
  (global-set-key (kbd "M-k") 'evil-previous-line)
  (global-set-key (kbd "M-h") 'left-char)
  (global-set-key (kbd "M-l") 'right-char)

  ;; Overload shifts so that they don't lose the selection
  ;; @see http://superuser.com/a/789156
  (defun mb/evil-shift-left-visual ()
    (interactive)
    (evil-shift-left (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))
  (defun mb/evil-shift-right-visual ()
    (interactive)
    (evil-shift-right (region-beginning) (region-end))
    (evil-normal-state)
    (evil-visual-restore))
  (define-key evil-visual-state-map (kbd ">") 'mb/evil-shift-right-visual)
  (define-key evil-visual-state-map (kbd "<") 'mb/evil-shift-left-visual))



;; Ido mode: text menu item selecting
(use-package ido
  :config
  ;; smarter fuzzy matching for ido
  (use-package flx-ido
    :ensure t
    :config (flx-ido-mode 1))
  ;; vertical menu for ido
  (use-package ido-vertical-mode
    :ensure t
    :config (ido-vertical-mode 1))

  (setq
   ido-enable-prefix          nil
   ido-enable-flex-matching   t
   ido-create-new-buffer      'always
   ido-use-filename-at-point  'guess

   ;; disable ido faces to see flx highlights
   ido-use-faces                nil

   ido-cannot-complete-command  'ido-next-match

   ;; make ido use completion-ignored-extensions
   ido-ignore-extensions        t

   ido-max-prospects 10

   ;; do not complete automatically unique result on tab
   ido-confirm-unique-completion t

   ;; ignore system buffers in ido-switch-buffer
   ido-ignore-buffers '("^[\s-]*\\*")

   ido-save-directory-list-file  (expand-file-name  "ido.hist"  mb-save-path)
   ido-default-file-method       'selected-window
   ido-auto-merge-work-directories-length  -1)

  (ido-mode 1)
  ;; (ido-everywhere 1)

  (add-hook 'ido-setup-hook
            (lambda()
              (define-key ido-completion-map (kbd "<backtab>") 'ido-prev-match)
              (define-key ido-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-file-dir-completion-map (kbd "C-w") 'ido-delete-backward-updir)
              (define-key ido-completion-map (kbd "M-j") 'ido-next-match)
              (define-key ido-completion-map (kbd "M-k") 'ido-prev-match))))


;; Better ido-based M-x
(use-package smex
  :ensure t
  :bind ("M-`" . smex-major-mode-commands)
  :config
  (setq smex-save-file (expand-file-name "smex-items" mb-save-path))
  (smex-initialize))



;; Helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :defines
  helm-scroll-amount
  helm-ff-search-library-in-sexp
  helm-ff-file-name-history-use-recentf
  helm-mode-handle-completion-in-region
  helm-M-x-fuzzy-match
  helm-buffers-fuzzy-matching
  helm-recentf-fuzzy-match
  helm-mode-fuzzy-match
  helm-imenu-fuzzy-match
  helm-semantic-fuzzy-match
  helm-locate-fuzzy-match
  helm-apropos-fuzzy-match
  helm-source-imenu

  :config
  (require 'helm-config)
  (require 'helm-imenu)

  (mb/ensure-bin-tool-exists "ag")

  (use-package helm-ag
    :ensure t
    :config
    (setq helm-ag-use-agignore t
          helm-ag-fuzzy-match t))

  (setq
   helm-split-window-in-side-p           t
   helm-prevent-escaping-from-minibuffer t
   helm-always-two-windows               t
   helm-move-to-line-cycle-in-source     t
   helm-scroll-amount                    8
   helm-ff-search-library-in-sexp        t
   helm-ff-file-name-history-use-recentf t
   helm-mode-handle-completion-in-region nil
   helm-echo-input-in-header-line        t

   ;; disable fuzzy matching for recentf because it breaks MRU order
   helm-recentf-fuzzy-match              nil

   ;; enable fuzzy for everything else
   helm-M-x-fuzzy-match                  t
   helm-buffers-fuzzy-matching           t
   helm-mode-fuzzy-match                 t
   helm-semantic-fuzzy-match             t
   helm-imenu-fuzzy-match                t
   helm-locate-fuzzy-match               t
   helm-apropos-fuzzy-match              t)

  ;; hide minibuffer while helm is open
  (add-hook 'helm-minibuffer-set-up-hook
            (lambda ()
              (when (with-helm-buffer helm-echo-input-in-header-line)
                (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
                  (overlay-put ov 'window (selected-window))
                  (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                                          `(:background ,bg-color :foreground ,bg-color)))
                  (setq-local cursor-type nil)))))

  ;; enables helm for completing everything: M-x, find file etc.
  (helm-mode 1)

  (defun mb/helm-imenu ()
    "Preconfigured `helm' for `imenu' (not using symbol at point)."
    (interactive)
    (unless helm-source-imenu
      (setq helm-source-imenu
            (helm-make-source "Imenu" 'helm-imenu-source
              :fuzzy-match helm-imenu-fuzzy-match)))
    (let ((imenu-auto-rescan t))
      (helm :sources 'helm-source-imenu
            :default ""
            :buffer "*helm imenu*")))

  (advice-add 'helm-imenu :around #'mb/advice-add-to-evil-jump-list)

  (defun mb/helm-open-current-file-externally ()
    "Open current file with external program which is selected with helm."
    (interactive)
    (let ((filename (buffer-file-name)))
      (when (and filename (file-exists-p filename))
          (helm-open-file-externally filename))))

  (defun mb/helm-open-current-file-wit-default-tool ()
    "Open current file with default external program."
    (interactive)
    (let ((filename (buffer-file-name)))
      (when (and filename (file-exists-p filename))
          (helm-open-file-with-default-tool filename))))

  (define-key helm-map (kbd "M-j") 'helm-next-line)
  (define-key helm-map (kbd "M-k") 'helm-previous-line)
  (define-key helm-map (kbd "M-h") 'helm-previous-source)
  (define-key helm-map (kbd "M-l") 'helm-next-source)
  (define-key helm-map (kbd "M-J") 'helm-follow-action-forward)
  (define-key helm-map (kbd "M-K") 'helm-follow-action-backward)

  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  (global-set-key (kbd "M-i") 'mb/helm-imenu)
  (global-set-key (kbd "M-I") 'helm-imenu)

  (evil-leader/set-key
    "`" 'helm-resume
    "TAB" 'helm-all-mark-rings

    "<SPC>" 'helm-mini
    "r"     'helm-recentf

    "bb" 'helm-buffers-list
    "bm" 'helm-bookmarks

    "ff" 'helm-find-files
    "fo" 'mb/helm-open-current-file-externally
    "fO" 'mb/helm-open-current-file-wit-default-tool
    "fs" 'helm-occur
    "fc" 'helm-colors))



;; Projectile: project management tool
(use-package projectile
  :ensure t
  :init
  ;; variables must be set BEFORE requiring projectile
  (setq-default
   projectile-cache-file          (expand-file-name "projectile.cache"         mb-save-path)
   projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" mb-save-path)

   projectile-mode-line          '(:eval (format " [%s]" (projectile-project-name)))

   projectile-completion-system  'helm
   projectile-sort-order         'modification-time)

  :config
  (use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on)

    ;; must be after helm-projectile-on otherwise it would be overwritten by helm-projectile
    (setq projectile-switch-project-action 'helm-projectile-recentf)

    (defun mb/helm-projectile-ag-dwim ()
      "Ag search in current project using symbol at point."
      (interactive)
      (let ((helm-ag-insert-at-point 'symbol))
        (helm-projectile-ag)))

    (advice-add 'mb/helm-projectile-ag-dwim :around #'mb/advice-add-to-evil-jump-list)

    (evil-leader/set-key
      "pp" 'helm-projectile-switch-project
      "pd" 'helm-projectile-find-dir
      "pf" 'helm-projectile-find-file
      "pF" 'helm-projectile-find-file-dwim
      "ps" 'helm-projectile-ag
      "pS" 'mb/helm-projectile-ag-dwim
      "ph" 'helm-projectile
      "pt" 'projectile-test-project
      "pr" 'helm-projectile-recentf
      "pb" 'helm-projectile-switch-to-buffer))

  (projectile-global-mode)

  ;; remove prefix "/:" when detecting base
  ;; dir to avoid issues with command line apps:
  ;; "/:/home/mbme/configs" -> "/home/mbme/configs"
  (advice-add 'projectile-project-root :around
              (lambda (origin-fun)
                (s-chop-prefix "/:" (funcall origin-fun))))

  (evil-leader/set-key
    "pD" 'projectile-dired
    "pR" 'projectile-replace
    "pk" 'projectile-kill-buffers))



;; Company-mode: autocomplete
(defvar-local company-fci-mode-on-p nil)
(use-package company
  :ensure t
  :diminish company-mode
  :defines
  company-dabbrev-ignore-case
  company-dabbrev-downcase
  :config
  (setq
   company-idle-delay                0.3
   company-tooltip-limit             20
   company-minimum-prefix-length     2
   company-echo-delay                0
   company-auto-complete             nil
   company-selection-wrap-around     t

   company-dabbrev-ignore-case       nil
   company-dabbrev-downcase          nil

   company-require-match             nil
   company-tooltip-align-annotations t
   company-show-numbers              t)

  ;; Sort completion candidates that already occur in the current
  ;; buffer at the top of the candidate list.
  (setq company-transformers '(company-sort-by-occurrence))

  (delete 'company-xcode company-backends)
  (delete 'company-ropemacs company-backends)

  (global-company-mode 1)

  ;; FIXME this is workarond for compatibility with the fci-mode
  (defun company-turn-off-fci (&rest ignore)
    (when (boundp 'fci-mode)
      (setq company-fci-mode-on-p fci-mode)
      (when fci-mode (fci-mode -1))))

  (defun company-maybe-turn-on-fci (&rest ignore)
    (when company-fci-mode-on-p (fci-mode 1)))

  (add-hook 'company-completion-started-hook 'company-turn-off-fci)
  (add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
  (add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)
  ;; end of workaround

  (define-key company-active-map (kbd "TAB") 'mb/company-complete-common-or-selection)
  (define-key company-active-map (kbd "<tab>") 'mb/company-complete-common-or-selection)
  (define-key company-active-map (kbd "M-j") 'company-select-next)
  (define-key company-active-map (kbd "M-k") 'company-select-previous)
  (define-key company-active-map (kbd "C-w") nil)
  (define-key company-active-map [escape]         'company-abort)
  (define-key company-active-map (kbd "<escape>") 'company-abort)

  (define-key company-active-map (kbd "<f1>") nil)

  (global-set-key (kbd "M-p") 'company-manual-begin))



;; YASnippet: snippets
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (use-package helm-c-yasnippet
    :ensure t
    :config
    (setq helm-yas-display-key-on-candidate t
          helm-yas-space-match-any-greedy   t))

  (setq yas-verbosity                       1
        yas-wrap-around-region              t
        yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

  (yas-global-mode)

  ;; disable `yas-expand` on TAB
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)

  (defun mb/yas-next-field ()
    "Switch to next yasnippet field.
Clear field placeholder if field was not modified."
    (interactive)
    (let ((field (and yas--active-field-overlay
                      (overlay-buffer yas--active-field-overlay)
                      (overlay-get yas--active-field-overlay 'yas--field))))
      (if (and field
               (not (yas--field-modified-p field))
               (eq (point) (marker-position (yas--field-start field))))
          (progn
            (yas--skip-and-clear field)
            (yas-next-field 1))
        (yas-next-field-or-maybe-expand))))

  (defun mb/complete-common-or-yas-next-field ()
    "Complete common prefix in company-mode or switch to next yasnippet field."
    (interactive)
    (if (> (or company-candidates-length 0) 0)
        (mb/company-complete-common-or-selection)
      (yas-next-field)))

  (defun mb/complete-selection-or-yas-next-field ()
    "Complete selection in company-mode or switch to next yasnippet field."
    (interactive)
    (if (> (or company-candidates-length 0) 0)
        (company-complete-selection)
      (mb/yas-next-field)))

  (setq yas-keymap
        (let ((map (make-sparse-keymap)))
          (define-key map (kbd "RET")   'mb/complete-selection-or-yas-next-field)
          (define-key map [return]      'mb/complete-selection-or-yas-next-field)

          (define-key map (kbd "TAB")   'mb/complete-common-or-yas-next-field)
          (define-key map (kbd "<tab>") 'mb/complete-common-or-yas-next-field)

          (define-key map (kbd "<backtab>") 'yas-prev-field)
          (define-key map (kbd "C-g") 'yas-abort-snippet)
          map))

  (defun mb/yas-expand ()
    "Expand yasnippet or return nil."
    (let ((yas-fallback-behavior 'return-nil))
      (yas-expand)))

  (defun mb/yas-expand-or-complete ()
    "Expand yasnippet or show matching snippets."
    (interactive)
    (company-abort)
    (or (mb/yas-expand)
        (helm-yas-complete)))

  (global-set-key (kbd "C-j") 'mb/yas-expand-or-complete))



;; Flyspell-mode: spell-checking on the fly as you type
(use-package flyspell
  :ensure t
  :diminish flyspell-mode
  :init
  (mb/ensure-bin-tool-exists "aspell")
  (setq ispell-personal-dictionary (expand-file-name "aspell.en.pws" mb-dotfiles-dir)
        ispell-program-name "aspell" ; use aspell instead of ispell
        ;; ispell-extra-args '("--sug-mode=ultra" "--run-together" "--run-together-limit=5" "--run-together-min=2")
        )
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook (lambda ()
                              (setq flyspell-consider-dash-as-word-delimiter-flag t)
                              (flyspell-prog-mode)))
  :config
  ;; helm interface for flyspell
  (use-package helm-flyspell
    :ensure t
    :bind* ([f8] . helm-flyspell-correct))

  (global-set-key [M-f8]  'flyspell-buffer))



;; Recentf: show recent files
(use-package recentf
  :config
  (setq recentf-save-file (expand-file-name "recentf" mb-save-path)
        recentf-max-menu-items 25
        recentf-max-saved-items 100
        ;; cleanup no-existing files on startup
        ;; can has problems with remote files
        recentf-auto-cleanup 'mode)
  ;; Ignore ephemeral git commit message files
  (add-to-list 'recentf-exclude "/COMMIT_EDITMSG$")
  (add-to-list 'recentf-exclude "/elpa/")
  (add-to-list 'recentf-exclude ".recentf")

  (add-hook 'server-done-hook 'recentf-save-list)
  (add-hook 'server-visit-hook 'recentf-save-list)
  (add-hook 'delete-frame-hook 'recentf-save-list)

  (recentf-mode t)
  (recentf-track-opened-file))



;; EditorConfig
(use-package editorconfig
  :ensure t
  :defer t
  :init
  (mb/ensure-bin-tool-exists "editorconfig")
  (add-hook 'prog-mode-hook 'editorconfig-mode)

  (defun mb/reload-editorconfig ( )
    "Reload editorconfig file and set variables for current major mode."
    (interactive)
    (message "mb: reloading EditorConfig...")
    (editorconfig-apply))

  (evil-leader/set-key "le" 'mb/reload-editorconfig))



;; Anzu: show current search match/total matches
(use-package anzu
  :ensure t
  :diminish anzu-mode
  :init
  (setq anzu-cons-mode-line-p nil)

  ;; from spacemacs
  (defun mb/anzu-update-mode-line (here total)
    "Custom update function which does not propertize the status.
                HERE is current position, TOTAL is total matches count."
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format "(%s/%d%s)"
                                      (anzu--format-here-position here total)
                                      total (if anzu--overflow-p "+" "")))
                      (replace-query (format "(%d replace)" total))
                      (replace (format "(%d/%d)" here total)))))
        status)))
  (setq anzu-mode-line-update-function 'mb/anzu-update-mode-line)
  (global-anzu-mode t)

  :config
  (use-package evil-anzu
    :ensure t))



;; Avy-mode: ace-jump replacement
(use-package avy
  :ensure t
  :bind*
  ("M-." . avy-goto-word-or-subword-1)
  ("M-;" . avy-goto-line)
  :init
  (setq avy-background  t
        avy-all-windows nil
        avy-style       'at-full)

  ;; free key for avy-jump
  (define-key evil-normal-state-map (kbd "M-.") nil)

  (define-key evil-normal-state-map (kbd "gc") 'avy-goto-char)
  (define-key evil-normal-state-map (kbd "gl") 'avy-goto-line))



;; Ace-window: switch windows
(use-package ace-window
  :ensure t
  :bind*
  ("M-w" . ace-window)
  :config
  (defun mb/other-window ()
    (other-window 1))
  (setq aw-keys '(?a ?s ?d ?f ?g ?j ?k ?l))
  (setq aw-scope 'frame)
  (setq aw-dispatch-always t)
  (setq aw-dispatch-alist
        '((?w mb/other-window)
          (?q evil-window-delete) ; delete focused window
          (?Q aw-delete-window " Ace - Delete Window") ; select which window to delete
          (?p aw-flip-window) ; focus previous window
          (?m aw-swap-window " Ace - Swap Window")

          (?v aw-split-window-vert " Ace - Split Vert Window")
          (?h aw-split-window-horz " Ace - Split Horz Window")

          (?o delete-other-windows)
          (?O delete-other-windows " Ace - Maximize Window"))))



;; Linum-mode: show line numbers
;; disabled: currently company mode breaks it
;; (setq linum-format "%4d")
;; (global-linum-mode 0)



;; Hl-line mode: highlight current line
(global-hl-line-mode t)
;; (set-face-background 'hl-line mb-color13)



;; Uniquify: unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      ;; rename after killing uniquified
      uniquify-after-kill-buffer-p t
      ;; don't muck with special buffers
      uniquify-ignore-buffers-re "^\\*")



;; Bookmark menu (local)
(use-package bookmark
  :bind ([f11] . bookmark-bmenu-list)
  :config
  (setq bookmark-default-file (expand-file-name "bookmarks" mb-save-path)
        bookmark-save-flag 1)

  (evil-set-initial-state 'bookmark-bmenu-mode 'normal)

  (define-key bookmark-bmenu-mode-map [f11] 'quit-window)

  (evil-define-key 'normal bookmark-bmenu-mode-map
    (kbd "RET") 'bookmark-bmenu-this-window
    "J"         'bookmark-jump
    "r"         'bookmark-bmenu-rename
    "R"         'bookmark-bmenu-relocate
    "s"         'bookmark-bmenu-save

    "d"         'bookmark-bmenu-delete
    (kbd "C-d") 'bookmark-bmenu-delete-backwards
    "x"         'bookmark-bmenu-execute-deletions))




;; Show available keybindings in separate window
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))




;; IBuffer (local)
;; use ibuffer on C-x C-b
(defalias 'list-buffers 'ibuffer)
;; use ibuffer as default buffers list (:ls)
(defalias 'buffer-menu 'ibuffer)

(use-package ibuffer
  :bind ([f2] . ibuffer)
  :config
  (define-key ibuffer-mode-map [f2]      'ibuffer-quit)
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line)
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line)
  (define-key ibuffer-mode-map (kbd "J") 'ibuffer-jump-to-buffer)
  (define-key ibuffer-mode-map (kbd "l") 'ibuffer-visit-buffer)
  (define-key ibuffer-mode-map (kbd "v") 'ibuffer-toggle-marks))



;; Saveplace: save cursor position
(require 'saveplace)
(setq-default save-place t
              save-place-file (expand-file-name "saveplace" mb-save-path))


;; Savehist: save mode-line history between sessions.
(require 'savehist)
(setq savehist-file (expand-file-name "savehist" mb-save-path)
      history-length 1000
      savehist-autosave-interval 60
      ;; save searches
      savehist-additional-variables '(search ring regexp-search-ring))
(savehist-mode t)



;; Delete-selection mode: delete seleted text when typing
(delete-selection-mode t)



;; Subword-mode: navigate in CamelCase words
;; http://ergoemacs.org/emacs/emacs_subword-mode_superword-mode.html
(global-subword-mode t)
(diminish 'subword-mode)



;; Electric indent mode: enable autoindent on enter etc.
(electric-indent-mode 1)



;; Electric-pair mode: auto insert closing brackets
;; skip over and delete white space if it stands between the cursor and the closing delimiter
(use-package elec-pair
  :init
  (setq electric-pair-skip-whitespace 'chomp)
  :config
  (electric-pair-mode 1)
  (defun mb/emulate-disabled-electric-pair ()
    "Disable auto-inserting parens."
    (setq-local electric-pair-pairs nil)
    (setq-local electric-pair-text-pairs nil)
    (setq-local electric-pair-inhibit-predicate #'identity))
  (add-hook 'minibuffer-setup-hook 'mb/emulate-disabled-electric-pair))



;; Eshell
(use-package eshell
  :defer t

  :init
  (defun mb/projectile-eshell ()
    "Open eshell in project root."
    (interactive)
    (projectile-with-default-dir (projectile-project-root)
      (eshell)))
  (evil-leader/set-key
    "e" 'eshell
    "pe" 'mb/projectile-eshell
    "E" (lambda () (interactive) (eshell t)))

  :config
  ;; half-way through typing a long command and need something else,
  ;; just M-q to hide it, type the new command, and continue where I left off.
  (use-package esh-buf-stack
    :ensure t
    :config (setup-eshell-buf-stack))

  (setq eshell-scroll-to-bottom-on-input t)

  ;; keybinding for eshell must be defined in eshell hook
  (add-hook 'eshell-mode-hook '(lambda ()
                                 (add-to-list 'eshell-visual-commands "htop")
                                 (add-to-list 'eshell-visual-commands "ranger")
                                 (add-to-list 'eshell-visual-commands "tig")
                                 (add-to-list 'eshell-visual-commands "vim")

                                 (define-key eshell-mode-map [tab] 'company-manual-begin)
                                 (define-key eshell-mode-map [M-tab] 'mb/prev-buffer)
                                 (define-key eshell-mode-map (kbd "M-h") 'helm-eshell-history)

                                 (define-key eshell-mode-map (kbd "C-d") 'bury-buffer)

                                 (define-key eshell-mode-map (kbd "M-q") 'eshell-push-command)

                                 (mb/no-highlight-whitespace)

                                 ;; use helm to show candidates
                                 (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
                                 ;; use helm to show history
                                 (substitute-key-definition 'eshell-list-history 'helm-eshell-history eshell-mode-map)))

  (add-hook 'term-mode-hook 'mb/no-highlight-whitespace)

  ;; override default eshell `clear' command.
  (defun eshell/clear ()
    "Clear the eshell buffer."
    (let ((inhibit-read-only t))
      (erase-buffer))))



;; Hippie expand is dabbrev expand on steroids
;; do not split words on _ and -
(use-package hippie-exp
  :bind* ("M-/" . hippie-expand)
  :config
  (use-package dabbrev
    :init
    (setq dabbrev-abbrev-char-regexp "[a-zA-Z0-9?!_\-]"))
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-expand-list
                                           try-expand-line)))



;; Eldoc
(add-hook  'emacs-lisp-mode-hook        'turn-on-eldoc-mode)
(add-hook  'lisp-interaction-mode-hook  'turn-on-eldoc-mode)
(add-hook  'ielm-mode-hook              'turn-on-eldoc-mode)
(add-hook 'eldoc-mode-hook
          (lambda() (diminish 'eldoc-mode)))



;; Dired
(use-package dired
  :defer t
  :config
  (require 'dired-x)

  (setq dired-auto-revert-buffer t    ; automatically revert buffer
        dired-clean-up-buffers-too t) ; kill buffers for deleted files

  (evil-set-initial-state 'wdired-mode 'normal)
  (evil-leader/set-key "d" 'dired-jump)

  (defun mb/dired-up-directory ()
    "Take dired up one directory, but behave like dired-find-alternate-file."
    (interactive)
    (let ((old (current-buffer)))
      (dired-up-directory)
      (kill-buffer old)))

  (evil-define-key 'normal dired-mode-map
    "h" 'mb/dired-up-directory
    "l" 'dired-find-alternate-file
    "o" 'dired-sort-toggle-or-edit
    "v" 'dired-toggle-marks
    "m" 'dired-mark
    "u" 'dired-unmark
    "U" 'dired-unmark-all-marks
    "c" 'helm-find-files
    "n" 'evil-search-next
    "N" 'evil-search-previous
    "q" 'kill-this-buffer))



;; Which-function-mode: show current function (disabled)
;; (require 'which-func)
;; (which-function-mode 1)



;; Volatile-highlights: momentarily highlight changes
;; made by commands such as undo, yank-pop, etc.
(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :config (volatile-highlights-mode t))



;; Powerline
(use-package powerline
  :ensure t
  :config
  ;; from https://github.com/raugturi/powerline-evil
  (defun mb/powerline-evil-tag ()
    "Get customized tag value for current evil state."
    (let* ((visual-block (and (evil-visual-state-p)
                              (eq evil-visual-selection 'block)))
           (visual-line (and (evil-visual-state-p)
                             (eq evil-visual-selection 'line))))
      (cond (visual-block " +V+ ")
            (visual-line " -V- ")
            (t evil-mode-line-tag))))

  (defun mb/powerline-default-evil-theme ()
    "Setup the default mode-line."
    (interactive)
    (setq-default mode-line-format
                  '("%e"
                    (:eval
                     (let* ((active (powerline-selected-window-active))
                            (mode-line (if active 'mode-line 'mode-line-inactive))
                            (face1 (if active 'powerline-active1 'powerline-inactive1))
                            (face2 (if active 'powerline-active2 'powerline-inactive2))

                            (separator-left (intern (format "powerline-%s-%s"
                                                            (powerline-current-separator)
                                                            (car powerline-default-separator-dir))))
                            (separator-right (intern (format "powerline-%s-%s"
                                                             (powerline-current-separator)
                                                             (cdr powerline-default-separator-dir))))

                            (lhs (list (powerline-raw (mb/powerline-evil-tag) mode-line)
                                       (powerline-buffer-id)
                                       (powerline-raw "%*")
                                       (powerline-vc face2 'r)
                                       (funcall separator-left mode-line face1)
                                       (powerline-major-mode face1 'l)
                                       (powerline-raw " " face1)
                                       (powerline-process face1)
                                       (powerline-narrow face1 'r)
                                       (funcall separator-left face1 face2)))
                            (rhs (list (powerline-raw global-mode-string face2 'r)
                                       (when (and (boundp 'anzu--state) anzu--state)
                                         (powerline-raw (anzu--update-mode-line) face2))
                                       (funcall separator-right face2 face1)
                                       (powerline-minor-modes face1)
                                       (funcall separator-right face1 mode-line)
                                       (powerline-raw "%4l" mode-line 'l)
                                       (powerline-raw ":" mode-line)
                                       (powerline-raw "%2c" mode-line)
                                       (powerline-raw "%4p" mode-line 'l))))
                       (concat (powerline-render lhs)
                               (powerline-fill face2 (powerline-width rhs))
                               (powerline-render rhs)))))))

  (mb/powerline-default-evil-theme))



;; Flycheck: error checking on the fly
(use-package flycheck
  :ensure t
  :defer t
  :bind*
  ("M-e 1" . flycheck-first-error)
  ("M-e j" . flycheck-next-error)
  ("M-e k" . flycheck-previous-error)
  ("M-e l" . mb/toggle-flyckeck-errors-list)
  ("M-e b" . flycheck-buffer)
  :init
  (global-flycheck-mode)

  :config
  (setq flycheck-indication-mode 'right-fringe
        flycheck-temp-prefix "FLYCHECK_XXY")

  ;; from http://www.lunaryorn.com/2014/07/30/new-mode-line-support-in-flycheck.html
  (setq flycheck-mode-line
        '(:eval
          (pcase flycheck-last-status-change
            (`not-checked nil)
            (`no-checker (propertize " -" 'face 'warning))
            (`running (propertize " ..." 'face 'success))
            (`errored (propertize " !" 'face 'error))
            (`finished
             (let* ((error-counts (flycheck-count-errors flycheck-current-errors))
                    (no-errors (cdr (assq 'error error-counts)))
                    (no-warnings (cdr (assq 'warning error-counts)))
                    (face (cond (no-errors 'error)
                                (no-warnings 'warning)
                                (t 'success))))
               (propertize (format " %s/%s" (or no-errors 0) (or no-warnings 0))
                           'face face)))
            (`interrupted " -")
            (`suspicious '(propertize " ?" 'face 'warning)))))


  (advice-add 'flycheck-first-error :around #'mb/advice-add-to-evil-jump-list)
  (advice-add 'flycheck-next-error :around #'mb/advice-add-to-evil-jump-list)
  (advice-add 'flycheck-previous-error :around #'mb/advice-add-to-evil-jump-list)

  ;; from Spacemacs
  (defun mb/toggle-flyckeck-errors-list ()
    "Toggle flycheck's error list window."
    (interactive)
    (-if-let (window (flycheck-get-error-list-window))
        (quit-window nil window)
      (flycheck-list-errors))))



;; Expand-region: expand selection like C-w in intellij idea
(use-package expand-region
  :ensure t
  :defer t
  :init
  (evil-leader/set-key "w" 'er/expand-region)
  (setq expand-region-contract-fast-key "W"
        expand-region-reset-fast-key    "r"))



;; Show parens mode: highlight matching parens
(use-package paren
  :config
  (setq show-paren-delay 0
        ;; decrease overlay priority because
        ;; it's higher than selection
        show-paren-priority 10
        ;; highlight everything inside parens
        show-paren-style 'expression)
  ;; (set-face-background 'show-paren-match-face mb-color12)
  (show-paren-mode 1))



;; Rainbow-mode: highlight colors in text (e.g "red" or #3332F3)
(use-package rainbow-mode
  :ensure t
  :defer t
  :diminish rainbow-mode)



;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))



;; Highlight-indentation: highlight indentation columns
(use-package highlight-indentation
  :ensure t
  :defer t
  :init (add-hook 'ruby-mode-hook 'highlight-indentation-current-column-mode)
  :config
  (set-face-background 'highlight-indentation-face mb-color12)
  (set-face-background 'highlight-indentation-current-column-face mb-color13))



;; Highlight-chars: highlight tabs and trailing whitespace
(defvar mb-highlight-chars t "If highlight-chars should be enabled or not.")
(make-variable-buffer-local 'mb-highlight-chars)

(defun mb/no-highlight-whitespace ()
  "Disable whitespace highlighting."
  (interactive)
  (setq mb-highlight-chars nil))

(use-package highlight-chars
  :ensure t
  :config
  (add-hook 'font-lock-mode-hook (lambda ()
                                   (when mb-highlight-chars
                                     (hc-highlight-trailing-whitespace)
                                     (hc-highlight-hard-hyphens)
                                     (hc-highlight-hard-spaces)
                                     (hc-highlight-tabs)))))

;; highlight todos
(use-package hl-todo
  :ensure t
  :defer t
  :init (add-hook 'prog-mode-hook 'hl-todo-mode))



;; highlight max line length
(use-package fill-column-indicator
  :disabled t
  :ensure t
  :defer t
  :init
  (setq fci-rule-width 1)
  (add-hook 'prog-mode-hook (lambda () (fci-mode 1))))



;; Emmet mode
(use-package emmet-mode
  :ensure t
  :defer t
  ;; :diminish emmet-mode
  :init
  (setq emmet-preview-default nil
        emmet-indentation mb-web-indent-size)
  :config
  (define-key emmet-mode-keymap (kbd "C-j") nil))

(defun mb/emmet-jsx ()
  "Enable emmet with jsx support.
It use className instead of class."
  (interactive)
  (setq emmet-expand-jsx-className? t)
  (emmet-mode t))



;; Magit: UI for git
(use-package magit
  :ensure t
  :defer t
  :defines
  magit-last-seen-setup-instructions
  magit-status-buffer-switch-function
  magit-rewrite-inclusive
  magit-save-some-buffers
  magit-auto-revert-mode-lighter
  magit-push-always-verify
  magit-set-upstream-on-push

  :init
  (mb/ensure-bin-tool-exists "git")
  (evil-leader/set-key
    "gs" 'magit-status
    "gl" 'magit-log-all
    "gL" 'magit-log-buffer-file
    "gb" 'magit-blame)

  :config
  (use-package evil-magit
    :ensure t)

  (setq magit-last-seen-setup-instructions "1.4.0"
        vc-follow-symlinks nil

        ;; open magit status in same window as current buffer
        magit-status-buffer-switch-function 'switch-to-buffer
        ;; highlight word/letter changes in hunk diffs
        magit-diff-refine-hunk 'all
        ;; ask me if I want to include a revision when rewriting
        magit-rewrite-inclusive 'ask
        ;; ask me to save buffers
        magit-save-some-buffers t
        ;; pop the process buffer if we're taking a while to complete
        magit-process-popup-time 10
        ;; don't show " MRev" in modeline
        magit-auto-revert-mode-lighter ""
        magit-push-always-verify nil

        ;; max length of first line of commit message
        git-commit-summary-max-length 70

        ;; ask me if I want a tracking upstream
        magit-set-upstream-on-push 'askifnotset)

  (diminish 'auto-revert-mode)
  (define-key magit-file-section-map (kbd "K") 'magit-discard)

  (add-hook 'magit-mode-hook 'mb/no-highlight-whitespace)

  ;; blame
  (evil-define-key 'normal magit-blame-map
    "q"         'magit-blame-mode
    "j"         'magit-blame-next-chunk
    "k"         'magit-blame-previous-chunk
    (kbd "RET") 'magit-show-commit)

  (evil-add-hjkl-bindings magit-log-mode-map 'emacs)
  (evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
  (evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
    "K" 'magit-discard
    "L" 'magit-key-mode-popup-logging)
  (evil-add-hjkl-bindings magit-status-mode-map 'emacs
    "K" 'magit-discard
    "l" 'magit-key-mode-popup-logging
    "h" 'magit-toggle-diff-refine-hunk)

  (message "mb: initialized MAGIT"))



;; Git-diff mode
(use-package diff-mode
  :ensure t
  :defer t
  :config
  (define-key diff-mode-map (kbd "j") 'diff-hunk-next)
  (define-key diff-mode-map (kbd "k") 'diff-hunk-prev))



;; Git-timemachine: browse through file history
(use-package git-timemachine
  :ensure t
  :defer t
  :init (evil-leader/set-key "gt" 'git-timemachine)
  :config
  (set-face-attribute 'git-timemachine-minibuffer-detail-face nil :foreground mb-color10)

  (evil-make-overriding-map git-timemachine-mode-map 'normal)
  ;; force update evil keymaps after git-timemachine-mode loaded
  (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))



;; Git-config mode
(use-package gitconfig-mode
  :ensure t
  :defer t)



;; Git-ignore mode
(use-package gitignore-mode
  :ensure t
  :defer t)



;; Diff-hl: highlight changes in gutter
(use-package diff-hl
  :ensure t
  :config
  (setq diff-hl-draw-borders nil)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)

  (evil-leader/set-key
    "gj" 'diff-hl-next-hunk
    "gk" 'diff-hl-previous-hunk
    "gr" 'diff-hl-revert-hunk
    "gd" 'diff-hl-diff-goto-hunk)

  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

  (diff-hl-flydiff-mode)
  (global-diff-hl-mode))



;; ---------------------------------------- LANGUAGES



;; Makefile mode

(defun mb/use-tabs ()
  "Use tabs."
  (setq tab-width        8
        indent-tabs-mode 1))

(add-hook 'makefile-mode-hook 'mb/use-tabs)
(add-hook 'makefile-bsdmake-mode-hook 'mb/use-tabs)



;; Go-mode: Golang mode
(use-package go-mode ; requires godef bin
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :init
  (add-to-list 'hs-special-modes-alist '(go-mode "{" "}" "/[*/]" nil nil))

  (add-hook 'go-mode-hook
            (lambda ()
              ;; go-eldoc
              (go-eldoc-setup)

              (add-hook 'before-save-hook 'gofmt-before-save)

              (set (make-local-variable 'company-backends) '((company-go :with company-dabbrev-code)))
              (company-mode)

              ;; unbind go-mode-insert-and-indent
              ;; because it conflicts with something else
              (define-key go-mode-map (kbd "}") nil)
              (define-key go-mode-map (kbd ")") nil)
              (define-key go-mode-map (kbd ",") nil)
              (define-key go-mode-map (kbd ":") nil)
              (define-key go-mode-map (kbd "=") nil)))

  :config
  ;; go get -u golang.org/x/tools/cmd/gorename
  ;; go build golang.org/x/tools/cmd/gorename
  (use-package go-rename
    :ensure t
    :if (executable-find "gorename")
    :init (mb/ensure-bin-tool-exists "gorename")
    :config
    (evil-leader/set-key-for-mode 'go-mode
      "mr" 'go-rename))

  ;; go get -u github.com/nsf/gocode
  (use-package go-eldoc
    :ensure t
    :init (mb/ensure-bin-tool-exists "gocode")
    :if (executable-find "gocode"))

  (use-package company-go
    :ensure t
    :if (executable-find "gocode")
    :init (mb/ensure-bin-tool-exists "gocode")
    :config
    (setq company-go-insert-arguments nil)
    (evil-leader/set-key-for-mode 'go-mode
      "mj" 'godef-jump
      "md" 'godef-describe))

  (evil-leader/set-key-for-mode 'go-mode
    "ma" 'go-import-add
    "mi" 'go-goto-imports)

  (message "mb: GO MODE"))



;; Python mode
(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :init
  (setq anaconda-mode-installation-directory (expand-file-name  "anaconda-mode"  mb-save-path)
        python-indent-offset mb-tab-size)

  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'eldoc-mode)

  :config
  (use-package anaconda-mode
    :ensure t)
  (use-package company-anaconda
    :ensure t)
  (add-to-list 'company-backends 'company-anaconda)
  (message "mb: PYTHON MODE"))



;; Ruby mode
(use-package ruby-mode
  :disabled t
  :ensure t
  :mode
  ("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode)
  ("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode)
  :interpreter "ruby"
  :init
  (add-hook 'ruby-mode-hook 'highlight-indentation-current-column-mode)
  :config
  (message "mb: RUBY MODE"))



;; Clojure mode
(use-package clojure-mode
  :disabled t
  :ensure t
  :mode (("\\.cljs$" . clojure-mode)
         ("\\.cljx$" . clojure-mode)
         ("\\.edn$" . clojure-mode)
         ("\\.dtm$" . clojure-mode))
  :init
  (evil-leader/set-key-for-mode 'clojure-mode
    "mj"  'cider-jack-in
    "mq"  'cider-quit
    "mn"  'cider-repl-set-ns
    "meb" 'cider-eval-buffer
    "mer" 'cider-eval-region
    "mes" 'cider-eval-last-sexp
    "mz"  'cider-switch-to-repl-buffer)

  (add-hook 'clojure-mode-hook 'eldoc-mode)

  :config
  (use-package clojure-mode-extra-font-locking
    :ensure t)
  (use-package clojure-snippets
    :ensure t)
  (use-package cider
    :ensure t)

  (setq nrepl-hide-special-buffers t)
  (setq cider-repl-use-pretty-printing t)
  ;; (setq cider-repl-display-in-current-window t)

  (evil-set-initial-state 'cider-repl-mode 'emacs)
  (evil-set-initial-state 'nrepl-mode 'emacs)

  (message "mb: CLOJURE MODE"))



;; C-based languages like Java
(use-package cc-mode
  :defer t
  :config

  ;; Set the default formatting styles for various C based modes.
  ;; Particularly, change the default style from GNU to Java.
  (setq c-default-style
        '((awk-mode . "awk")
          (other . "java")))

  (defvar flycheck-antrc "build.xml" "Ant build file name.")

  (flycheck-define-checker java
    "Java syntax checker using ant."
    :command ("ant" "-e"
              (config-file "-buildfile"flycheck-antrc)
              "compile")
    :error-patterns
    ((error line-start (file-name) ":" line ": error:"
            (message (zero-or-more not-newline)) line-end))
    :modes java-mode)

  (add-to-list 'flycheck-checkers 'java)

  (add-hook 'java-mode-hook (lambda ()
                              ;; check only on save
                              (setq flycheck-check-syntax-automatically '(mode-enabled save))
                              ;; disable auto-indent
                              (electric-indent-local-mode 0)))

  (message "mb: CC MODE"))



;; Javascript
(use-package js-mode
  :defer t
  :defines javascript-indent-level js-indent-level
  :config
  (setq javascript-indent-level mb-web-indent-size
        js-indent-level         mb-web-indent-size)

  (add-hook 'js-mode-hook 'rainbow-mode)

  (add-hook 'js-mode-hook (lambda ()
                            ;; (setq imenu-create-index-function 'mb/imenu-js-make-index)
                            (mb/emmet-jsx)))
  (message "mb: JS MODE"))




;; JS2 mode
(use-package js2-mode
  :ensure t
  :mode
  ("\\.js\\'" . js2-mode)
  ("\\.jsx\\'" . js2-jsx-mode)
  :interpreter ("node" . js2-jsx-mode)
  :defines
  js2-consistent-level-indent-inner-bracket-p
  js2-pretty-multiline-decl-indentation-p
  :config
  (setq js2-basic-offset mb-web-indent-size
        js2-highlight-level 3
        js2-skip-preprocessor-directives t
        ;; idiomatic closing bracket position
        js2-consistent-level-indent-inner-bracket-p t
        ;; allow for multi-line var indenting
        js2-pretty-multiline-decl-indentation-p t

        ;; Don't highlight missing variables in js2-mode: we have jslint for that
        js2-highlight-external-variables          nil
        js2-mode-show-parse-errors                nil
        js2-mode-show-strict-warnings             nil
        js2-missing-semi-one-line-override        nil
        js2-strict-inconsistent-return-warning    nil
        js2-strict-cond-assign-warning            nil
        js2-strict-var-redeclaration-warning      nil
        js2-strict-var-hides-function-arg-warning nil
        js2-strict-missing-semi-warning           nil)

  ;; ensure that we're in insert state when inserting js line break
  (advice-add 'js2-line-break :around #'mb/advice-ensure-evil-insert-state)

  (add-hook 'js2-jsx-mode-hook (lambda () (mb/emmet-jsx)))
  (message "mb: JS2 MODE"))



;; Json-mode
(use-package json-mode
  :ensure t
  :mode
  ("\\.json\\'" . json-mode)
  ("\\.eslintrc\\'" . json-mode)

  :config
  (defun mb/json-beautify (&rest ignored)
    "Beautify json buffer.  Ignore all `IGNORED' vars."
    (json-mode-beautify))
  ;; set format function for json
  (add-hook 'json-mode-hook (lambda ()
                              (setq-local indent-region-function 'mb/json-beautify)))

  ;; disable json-jsonlist checking for json files
  (add-to-list 'flycheck-disabled-checkers 'json-jsonlint)

  (message "mb: JSON MODE"))



;; WebMode
(use-package web-mode
  :ensure t
  :mode
  ("\\.phtml\\'"      . web-mode)
  ("\\.tpl\\.php\\'"  . web-mode)
  ("\\.twig\\'"       . web-mode)
  ("\\.html\\'"       . web-mode)
  ("\\.htm\\'"        . web-mode)
  ("\\.[gj]sp\\'"     . web-mode)
  ("\\.as[cp]x?\\'"   . web-mode)
  ("\\.eex\\'"        . web-mode)
  ("\\.erb\\'"        . web-mode)
  ("\\.mustache\\'"   . web-mode)
  ("\\.handlebars\\'" . web-mode)
  ("\\.hbs\\'"        . web-mode)
  ("\\.eco\\'"        . web-mode)
  ("\\.ejs\\'"        . web-mode)
  ("\\.djhtml\\'"     . web-mode)
  :init
  (setq web-mode-enable-auto-pairing  nil
        web-mode-markup-indent-offset mb-web-indent-size ; html tag in html file
        web-mode-css-indent-offset    mb-web-indent-size ; css in html file
        web-mode-code-indent-offset   mb-web-indent-size ; js code in html file
        )

  :config
  (evil-leader/set-key-for-mode 'web-mode
    "mr" 'web-mode-element-rename)

  (flycheck-add-mode 'javascript-eslint 'web-mode)

  ;; React.js JSX-related configs
  ;; use eslint with web-mode for jsx files
  (defun mb/web-mode-jsx-hacks ()
    "Enable eslint for jsx in flycheck."
    (if (or (equal web-mode-content-type "jsx")
            (equal web-mode-content-type "javascript"))
        (progn
          (setq imenu-create-index-function 'mb/imenu-js-make-index)
          (mb/emmet-jsx)
          (message "enabled web mode for js/jsx"))
      (progn
        (setq flycheck-disabled-checkers '(javascript-eslint))
        (emmet-mode t)
        (message "enabled web mode"))))

  (add-hook 'web-mode-hook (lambda () (fci-mode -1)))
  (add-hook 'web-mode-hook 'mb/web-mode-jsx-hacks)
  (add-hook 'web-mode-hook 'rainbow-mode)

  (message "mb: WEB MODE"))



;; XML
(use-package nxml-mode
  :mode ("\\.xml\\'" . nxml-mode)
  :config

  (setq nxml-child-indent  mb-tab-size)

  (add-hook 'nxml-mode-hook 'emmet-mode)

  (message "mb: nXML MODE"))



;; Css
(use-package css-mode
  :mode ("\\.css\\'" . css-mode)
  :config
  (setq css-indent-offset mb-web-indent-size)

  (add-hook 'css-mode-hook 'rainbow-mode)

  ;; enable Emmet's css abbreviation.
  (add-hook 'css-mode-hook  'emmet-mode)

  (message "mb: CSS MODE"))



;; SCSS-mode
(use-package scss-mode
  :ensure t
  :mode ("\\.scss\\'" . scss-mode)
  :defer t
  :config
  (add-hook 'scss-mode-hook 'rainbow-mode)
  (setq scss-compile-at-save nil)
  (message "mb: SCSS MODE"))



;; LESS-mode
(use-package less-css-mode
  :disabled t
  :ensure t
  :defer t
  :config (message "mb: LESS MODE"))



;; Yaml
(use-package yaml-mode
  :disabled t
  :ensure t
  :mode ("\\.yml$" . yaml-mode)
  :config (message "mb: YAML MODE"))



;; Rust
(use-package rust-mode
  :ensure t
  :defer t
  :config
  (mb/ensure-bin-tool-exists "rustfmt")
  (setq rust-indent-offset  mb-tab-size
        rust-format-on-save nil)
  (use-package flycheck-rust
    :ensure t
    :init
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
  (use-package racer
    :ensure t
    :init
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode))
  (use-package company-racer
    :ensure t
    :init (add-to-list 'company-backends 'company-racer))
  (message "mb: RUST MODE"))



;; Toml
(use-package toml-mode
  :ensure t
  :defer t
  :config (message "mb: TOML MODE"))



;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (message "mb: MARKDOWN MODE"))



;; CoffeeScript
(use-package coffee-mode
  :disabled t
  :ensure t
  :defer t
  :config
  (custom-set-variables `(coffee-tab-width ,mb-web-indent-size))
  (message "mb: COFFEESCRIPT MODE"))



;; Emacs Lisp
(evil-leader/set-key-for-mode 'emacs-lisp-mode "meb" 'eval-buffer)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "mer" 'eval-region)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "mes" 'eval-last-sexp)
(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "ELisp")))
(add-hook 'lisp-interaction-mode-hook
          (lambda() (setq mode-name "λ")))



;; Php-mode
(use-package php-mode
  :disabled t
  :ensure t
  :defer t
  :config
  (define-key php-mode-map [(meta tab)] nil)
  (message "mb: PHP MODE"))



;; Scheme
(use-package geiser
  :ensure t
  :defer t
  :defines
  geiser-active-implementations
  scheme-program-name
  geiser-mode-map
  geiser-repl-mode-map
  :config
  (setq geiser-active-implementations '(chicken))
  (setq scheme-program-name "csi -:c")
  (add-hook 'geiser-mode-hook (lambda ()
                                (define-key geiser-mode-map (kbd "M-.") nil)
                                (define-key geiser-repl-mode-map (kbd "M-`") nil)))

  (evil-leader/set-key-for-mode 'scheme-mode
    "mj" 'run-geiser
    "mb" 'geiser-compile-current-buffer
    "md" 'geiser-doc-symbol-at-point
    "meb" 'geiser-eval-buffer
    "meB" 'geiser-eval-buffer-and-go
    "mef" 'geiser-eval-definition
    "meF" 'geiser-eval-definition-and-go
    "mes" 'geiser-eval-last-sexp
    "mer" 'geiser-eval-region
    "meR" 'geiser-eval-region-and-go)

  (message "mb: SCHEME MODE"))



;; Ocaml
(use-package tuareg
  :disabled t
  :ensure t
  :mode
  ("\\.ml[ily]?$" . tuareg-mode)
  ("\\.topml$" . tuareg-mode)

  :config
  ;; autocomplete
  (use-package merlin
    :ensure t
    :if (executable-find "ocamlmerlin")
    :init
    (mb/ensure-bin-tool-exists "ocamlmerlin")
    (require 'merlin-company)
    (add-to-list 'company-backends 'merlin-company-backend)

    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)
    (setq merlin-error-after-save nil))

  ;; repl
  (use-package utop
    :ensure t
    :if (executable-find "utop")
    :init (mb/ensure-bin-tool-exists "utop"))

  ;; source code indent
  (use-package ocp-indent
    :ensure t
    :if (executable-find "ocp-indent")
    :init (mb/ensure-bin-tool-exists "ocp-indent"))

  (mb/ensure-bin-tool-exists "opam")

  ;; Setup environment variables using opam
  (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
    (setenv (car var) (cadr var)))

  ;; Update the emacs path
  (setq exec-path (append (parse-colon-path (getenv "PATH"))
                          (list exec-directory)))

  (add-hook 'tuareg-mode-hook (lambda()
                                (merlin-mode)
                                (utop-minor-mode)))

  (message "mb: OCAML MODE"))



;; Shell mode
(use-package sh-script
  :defer t
  :init
  ;; Use sh-mode when opening `.zsh' files, and when opening Prezto runcoms.
  (dolist (pattern '("\\.zsh\\'"
                     "zlogin\\'"
                     "zlogout\\'"
                     "zpreztorc\\'"
                     "zprofile\\'"
                     "zshenv\\'"
                     "zshrc\\'"))
    (add-to-list 'auto-mode-alist (cons pattern 'sh-mode)))
  :config
  (use-package company-shell
    :ensure t
    :config
    (add-to-list 'company-backends 'company-shell))
  (message "mb: SH MODE"))



;; Typescript mode
(use-package typescript-mode
  :ensure t
  :mode ("\\.ts$" . typescript-mode)
  :config

  (use-package tide
    :ensure t
    :init
    (evil-leader/set-key-for-mode 'typescript-mode
      "mj" 'tide-jump-to-definition
      "mh" 'tide-documentation-at-point
      "mr" 'tide-rename-symbol)
    (add-hook 'typescript-mode-hook
              (lambda ()
                (tide-setup)
                (setq flycheck-check-syntax-automatically '(save mode-enabled))
                (eldoc-mode 1))))

  ;; linting with tslint
  ;; https://palantir.github.io/tslint/
  (use-package flycheck-typescript-tslint
    :ensure t
    :init
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-typescript-tslint-setup)))

  (add-hook 'typescript-mode-hook 'emmet-mode)

  (message "mb: TYPESCRIPT MODE"))



;; ---------------------------------------- GLOBAL KEYBINDINGS


;; disable input methods
(global-set-key (kbd "C-\\") nil)

;; prevent accidentally closed frames
(global-unset-key (kbd "C-x C-z"))


;; zoom in / zoom out in editor
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(when mb-is-mac-os
  (global-set-key (kbd "C-<wheel-up>")   'text-scale-increase)
  (global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease))


(global-set-key (kbd "M-,") 'evil-jump-backward)
(global-set-key (kbd "C-x e")   'mb/eval-and-replace)
(global-set-key [M-tab]         'mb/prev-buffer)
(global-set-key (kbd "M-S-SPC") 'just-one-space)

(global-set-key [f4]    'mb/terminal)
(global-set-key [M-f4]  'mb/projectile-base-term)
(global-set-key [f5]    'make-frame)
(global-set-key [f6]    'mb/revert-buffer)
(global-set-key [f12]   'menu-bar-mode)


;; NOTE: m is reserved for mode-local bindings
(evil-leader/set-key
  "2"  'call-last-kbd-macro
  "q"  'evil-quit
  ","  'mb/prev-buffer
  "n"  'mb/narrow-or-widen-dwim
  "ll" 'mb/cleanup-buffer
  "lt" 'mb/sort-columns
  "k"  'kill-this-buffer
  ";"  'evil-ex
  "s"  'save-buffer
  "lm" 'evil-show-marks
  "u"  'undo-tree-visualize

  "bd" 'mb/delete-current-buffer-file
  "bh" 'bury-buffer
  "br" 'mb/rename-file-and-buffer
  "bs" 'scratch)

(provide 'init)
;;; init.el ends here

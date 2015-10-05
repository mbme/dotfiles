;;; init.el --- mbme main emacs config file
;;; Commentary:
;; Part of code is from
;; * Emacs Prelude https://github.com/bbatsov/prelude
;; * Emacs Graphene https://github.com/rdallasgray/graphene
;; * Spacemacs https://github.com/syl20bnr/spacemacs
;;; Code:



;; ---------------------------------------- VARS
(defvar is-mac-os (eq system-type 'darwin))
(defvar is-linux (eq system-type 'gnu/linux))

(defvar provided-dir (expand-file-name "provided" user-emacs-directory))

;; base configs dir
(defvar dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; dir for temp files
(defvar mb-save-path (expand-file-name "save-files/" dotfiles-dir))


;; (defvar mb-font "inconsolata:spacing=100")
;; (defvar mb-font "source code pro:spacing=100")
;; (defvar mb-font "ubuntu mono:spacing=100")
;; (defvar mb-font "droid sans mono:spacing=100")
;; (defvar mb-font "meslo lg s dz:spacing=100")
;; (defvar mb-font "liberation mono:spacing=100")
;; (defvar mb-font "roboto:spacing=100")
;; (defvar mb-font "roboto condensed:spacing=100")

(defvar mb-font (if is-mac-os "menlo-13" "dejavu sans mono-12"))

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
(load (expand-file-name "local.el" dotfiles-dir) t)

;; ---------------------------------------- INIT

(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Manually installed packages

;; load provided scripts from local dir
(add-to-list 'load-path provided-dir)

;; load themes
(add-to-list 'custom-theme-load-path provided-dir)

(package-initialize)

;; load and instalL all required packages if not installed
(defvar my-packages
  '(
    ;; utils
    dash ; lists manipulating
    s ; strings manipulations
    exec-path-from-shell ; fix issues with PATH on Mac

    evil; vim emulator
    evil-surround ; emulates surround.vim
    evil-matchit ; match braces or tags pairs
    evil-visualstar ; search for selected text
    evil-leader ; vim leader feature
    evil-exchange ; exchange with objects

    helm
    helm-ag
    helm-themes
    helm-flyspell
    helm-make

    imenu-anywhere

    soft-morning-theme
    color-theme-sanityinc-tomorrow
    solarized-theme

    ;; show current search match/total matches
    anzu
    evil-anzu

    powerline
    nyan-mode

    project-explorer ; side bar
    projectile ; project management
    helm-projectile

    flycheck ; syntax checker
    flycheck-pos-tip ; show errors in popup

    yasnippet ; snippets
    helm-c-yasnippet

    rainbow-delimiters ; highlight parens
    smartparens ; deals with parens pairs and highlights them
    ethan-wspace ; cleanup tabs/whitespace etc.
    highlight-chars ; highlight some chars like trailing whitespace, tab etc.

    highlight-indentation ; highligh indentation columns
    rainbow-mode ; highlight colors in text (e.g "red" or #3332F3)

    expand-region ; expands current selection like C-w in intellij idea
    volatile-highlights ; highlights possible keybindigs for commands
    diminish ; cleanup mode line

    smex ; ido-like M-x replacement
    flx-ido ; flexible matching for ido-mode (select files etc.)
    ido-vertical-mode ; vertical ido menu

    company ; autocomplete
    company-statistics ; sort autocomplete results

    ag ; use ag (the silver searcher)

    editorconfig ; EditorConfig support

    avy ; ace-jump replacement

    ;; Ivy
    swiper ; better search using ivy (ido alternative)
    counsel ; additional functions for ivy


    esh-buf-stack ;; eshell improvement


    ;; GIT
    magit
    gitconfig-mode
    gitignore-mode
    ;; git gutter
    fringe-helper
    git-gutter-fringe


    ;; LANGUAGES SUPPORT

    web-mode
    emmet-mode
    scss-mode
    less-css-mode

    json-mode
    js2-mode
    tern ; requires npm tern
    company-tern ; autocomplete, requires npm tern

    go-mode ; golang mode, requires godef bin
    company-go ; requires gocode bin
    go-eldoc ; documentation for go, requires godoc bin

    rust-mode

    toml-mode

    markdown-mode
    yaml-mode
    coffee-mode

    ;; python
    anaconda-mode
    company-anaconda

    ;; Clojure
    clojure-mode
    clojure-mode-extra-font-locking
    clojure-snippets
    cider

    ))

;; install packages if not installed yet
;; and refresh package list before installation
(let ((refreshed nil))
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install p))))

;; create temp files dir if it does not exists
(unless (file-exists-p mb-save-path)
  (make-directory mb-save-path))

(when is-mac-os
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

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
  (indent-region (point-min) (point-max)))

(defun mb/cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (mb/indent-buffer)
  (ethan-wspace-clean-all)
  (message "mb: cleanup and indent buffer"))

(defun mb/rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
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
        (message "File '%s' successfully removed" filename)))))

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
  (let ((commands (if is-mac-os
                      (-concat (list "open" "-a" "Terminal" default-directory) args)
                    (-concat (list "termite") args))))
    (apply 'mb/launch-application commands)))

(defun mb/projectile-base-term (&rest args)
  "Launches terminal in projectile root with ARGS."
  (interactive)
  (message default-directory)
  (let ((default-directory (projectile-project-root)))
    (apply 'mb/terminal args)))

(defun mb/projectile-file? ()
  (let ((projectile-require-project-root t))
    (ignore-errors (projectile-project-root) t)))

(defun mb/project-explorer-maybe-open (&optional select-file)
  "Open project explorer if current file is inside projectile project.
If `SELECT-FILE' then put cursor on current file in project explorer buffer."
  (interactive)
  (if (mb/projectile-file?)
      (let ((pe/goto-current-file-on-open select-file))
        (project-explorer-open))

    ;; switch to project-explorer window if already open
    (let (( window (pe/get-project-explorer-window)))
      (if window
          (select-window window)
        (message "mb: project explorer not inside projectile project")))))

(defun mb/toggle-comment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))


(defun mb/yas-expand ()
  "Expand yasnippet or return nil."
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun mb/yas-expand-or-complete ()
  "Expand yasnippet or show matching snippets."
  (interactive)
  (company-abort)
  (or (mb/yas-expand)
      (helm-yas-complete)))

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
    (setq column-command (if is-linux "column -o \" \" -t" "column -t"))
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

(defun mb/dired-up-directory ()
  "Take dired up one directory, but behave like dired-find-alternate-file."
  (interactive)
  (let ((old (current-buffer)))
    (dired-up-directory)
    (kill-buffer old)))


;; @see https://stackoverflow.com/questions/20863386/idomenu-not-working-in-javascript-mode
;; @see https://github.com/redguardtoo/emacs.d/blob/master/lisp/init-javascript.el
(defun mb/imenu-js-make-index ()
  "Create imenu for javascript file."
  (imenu--generic-function '(("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                             ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                             ("Class"    "class[ \t]+\\([a-zA-Z0-9_$.]+\\([ \t]+extends[ \t]+[a-zA-Z0-9_$.]+\\)?\\)[ \t]*{" 1)
                             ("Method" "[ \t{]\\([a-zA-Z0-9_$.]+\\):[ \t]*function[ \t]*(" 1)
                             ("Method"   "^[ \t]+\\([a-zA-Z0-9_$]+\\)[ \t]*([a-zA-Z0-9_$, {}:]*)[ \t]*{" 1)
                             )))


(defun mb/add-to-evil-jump-list (origin-fun &rest args)
  "Save current pos to evil jump list before executing ORIGIN-FUN with ARGS."
  (evil-set-jump)
  (apply origin-fun args))


(defun mb/helm-projectile-ag-dwim ()
  "Ag search in current project using symbol at point."
  (interactive)
  (let ((helm-ag-insert-at-point 'symbol))
    (helm-projectile-ag)))


;; @see https://emacs.stackexchange.com/questions/653/how-can-i-find-out-in-which-keymap-a-key-is-bound
(defun mb/key-binding-at-point (key)
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



;; ---------------------------------------- CONFIG

;;@UI

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

;; make urls in comments/strings clickable
(add-hook 'find-file-hooks 'goto-address-prog-mode)

;; Font
(setq-default default-font mb-font)
;; set font for all windows
(add-to-list 'default-frame-alist `(font . ,mb-font))

;; highlight todos
(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\\<\\(FIXME\\|TODO\\)\\ .*"
                0
                `(:background ,mb-color10) prepend)))))

;; selection (region) colors
(set-face-attribute 'region nil
                    :background mb-color12
                    :foreground mb-color6)

;; Fringe background
;; (set-face-background 'fringe mb-color1)

;; (load-theme 'soft-morning t)
;; (load-theme 'sanityinc-tomorrow-day t)
;; (load-theme 'leuven t)

(setq
 ;; Use less bolding
 solarized-use-less-bold t
 ;; Use less colors for indicators such as git:gutter, flycheck and similar
 solarized-emphasize-indicators nil)
(load-theme 'solarized-light t)


;;@GENERAL

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
;; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(setq utf-translate-cjk-mode nil)


(setq javascript-indent-level       mb-web-indent-size ; javascript-mode
      js-indent-level               mb-web-indent-size ; js-mode
      js2-basic-offset              mb-web-indent-size ; js2-mode
      web-mode-markup-indent-offset mb-web-indent-size ; web-mode, html tag in html file
      web-mode-css-indent-offset    mb-web-indent-size ; web-mode, css in html file
      web-mode-code-indent-offset   mb-web-indent-size ; web-mode, js code in html file
      css-indent-offset             mb-web-indent-size ; css-mode
      emmet-indentation             mb-web-indent-size ; css-mode
      )

;; dir to save info about interrupted sessions
(setq auto-save-list-file-prefix mb-save-path)

;; Transparently open compressed files
(auto-compression-mode t)

;; Automatically update unmodified buffers whose files have changed.
(global-auto-revert-mode t)


(defadvice server-visit-files
    (before parse-numbers-in-lines (files proc &optional nowait) activate)
  "Open file with emacsclient with cursors positioned on requested line.
Most of console-based utilities prints filename in format
'filename:linenumber'.  So you may wish to open filename in that format.
Just call:
emacsclient filename:linenumber
and file 'filename' will be opened and cursor set on line 'linenumber'"
  (ad-set-arg
   0
   (mapcar (lambda (fn)
             (let ((name (car fn)))
               (if (string-match
                    "^\\(.*?\\):\\([0-9]+\\)\\(?::\\([0-9]+\\)\\)?$" name)
                   (cons
                    (match-string 1 name)
                    (cons (string-to-number (match-string 2 name))
                          (string-to-number (or (match-string 3 name) ""))))
                 fn))) files)))


;; Tabs: use only spaces for indent
(setq-default
 indent-tabs-mode  nil
 tab-always-indent nil

 tab-width          mb-tab-size
 c-basic-offset     mb-tab-size
 py-indent-offset   mb-tab-size
 nxml-child-indent  mb-tab-size)

;; Set the default formatting styles for various C based modes.
;; Particularly, change the default style from GNU to Java.
(setq c-default-style
      '((awk-mode . "awk")
        (other . "java")))

(setq-default
 ;; Sentences do not need double spaces to end
 sentence-end-double-space nil

 ;; lines should be 80 characters wide, not 72
 fill-column 80)

;; copy-paste (work with both terminal (S-INS) and X11 apps.):
(when (and is-linux (> (display-color-cells) 16)) ;if linux and not in CLI
  ;;copy-paste should work (default in emacs24)
  (setq x-select-enable-clipboard t
        ;; with other X-clients
        interprogram-paste-function 'x-cut-buffer-or-selection-value))



;; ---------------------------------------- PLUGINS

;; Dash.el modern list library (helpers)
(require 'dash)
(eval-after-load 'dash '(dash-enable-font-lock))



;; Undo-tree: save/show undo tree
;; also required by evil
(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-visualizer-timestamps t
      undo-tree-visualizer-diff t)



;; Evil: vim mode

;; use C-u as scroll-up
;; this must be set before loading evil
(defvar evil-want-C-u-scroll t)

(require 'evil)
(require 'evil-leader)
(require 'evil-surround)
(require 'evil-matchit)
(require 'evil-visualstar)
(require 'evil-exchange)

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


;; Exit to emacs state after save
(add-hook 'after-save-hook 'evil-normal-state)

;; evils states for different modes
(require 'cl) ; we need this for loop
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (term-mode . emacs)
                              (help-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (rdictcc-buffer-mode . emacs))
      do (evil-set-initial-state mode state))

;; cursor colors for evil states
(setq  evil-emacs-state-cursor     (list  mb-evil-emacs-face     'box)
       evil-normal-state-cursor    (list  mb-evil-normal-face    'hollow)
       evil-visual-state-cursor    (list  mb-evil-visual-face    'box)
       evil-insert-state-cursor    (list  mb-evil-insert-face    'bar)
       evil-replace-state-cursor   (list  mb-evil-replace-face   'hollow)
       evil-operator-state-cursor  (list  mb-evil-operator-face  'hollow))

;; enable evil leader in all modes
(setq evil-leader/in-all-states 1)
(setq evil-leader/non-normal-prefix "M-")
;; (setq evil-leader/no-prefix-mode-rx '("."))

(evil-leader/set-leader "<SPC>")
(global-set-key (kbd "M-<SPC>") evil-leader--default-map)

(global-evil-leader-mode 1)

(global-evil-surround-mode 1)

;; search for selected text with * and #
(global-evil-visualstar-mode)

;; match braces/tags with %
(global-evil-matchit-mode 1)
(advice-add 'evilmi-jump-items :around #'mb/add-to-evil-jump-list)

(evil-exchange-install)

(evil-mode 1)

;; esc quits
(define-key minibuffer-local-map            [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map         [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map    [escape] 'minibuffer-keyboard-quit)

;; disable man look up
(define-key evil-motion-state-map "K" nil)

;; in many modes q is close/exit etc., so leave it unbound
(define-key evil-normal-state-map "q" nil)
(define-key evil-normal-state-map "Q" 'evil-record-macro)

(define-key evil-normal-state-map (kbd "M-.") nil)

;; move everywhere with M-hjkl
(global-set-key (kbd "M-j") 'evil-next-line)
(global-set-key (kbd "M-k") 'evil-previous-line)
(global-set-key (kbd "M-h") 'left-char)
(global-set-key (kbd "M-l") 'right-char)

(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-o") 'evil-execute-in-normal-state)

(define-key evil-window-map "q" 'evil-window-delete)

(evil-leader/set-key
  ;; manage windows with evil
  "w" 'evil-window-map)



;; Ido mode: text menu item selecting
(require 'ido)
(require 'flx-ido) ; smarter fuzzy matching for ido
(flx-ido-mode 1)

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
            (define-key ido-completion-map (kbd "M-k") 'ido-prev-match)))

;; vertical menu for ido-mode
(require 'ido-vertical-mode)
(ido-vertical-mode 1)



;; Smex: ido M-x replacement
(require 'smex)
;; initialize M-x replacement first time
(smex-initialize)

(setq smex-save-file (expand-file-name "smex-items" mb-save-path))

(global-set-key (kbd "M-`") 'smex-major-mode-commands)
(global-set-key (kbd "M-X") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



;; Helm
(require 'helm)
(require 'helm-config)
(require 'helm-themes)
(require 'helm-make)

(require 'grep)
(require 'helm-ag)

(setq
 helm-split-window-in-side-p           t
 helm-prevent-escaping-from-minibuffer t
 helm-always-two-windows               t
 helm-move-to-line-cycle-in-source     t
 helm-scroll-amount                    8
 helm-ff-search-library-in-sexp        t
 helm-ff-file-name-history-use-recentf t
 helm-mode-handle-completion-in-region nil
 helm-ag-use-agignore                  t
 helm-echo-input-in-header-line        t

 helm-M-x-fuzzy-match                  t
 helm-buffers-fuzzy-matching           t

 ;; disable fuzzy matching for recentf because it breaks MRU order
 helm-recentf-fuzzy-match              nil

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

(advice-add 'helm-imenu          :around #'mb/add-to-evil-jump-list)
(advice-add 'helm-imenu-anywhere :around #'mb/add-to-evil-jump-list)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(define-key helm-map (kbd "M-j") 'helm-next-line)
(define-key helm-map (kbd "M-k") 'helm-previous-line)

(define-key helm-map (kbd "M-h") 'helm-previous-source)
(define-key helm-map (kbd "M-l") 'helm-next-source)

(define-key helm-map (kbd "M-J") 'helm-follow-action-forward)
(define-key helm-map (kbd "M-K") 'helm-follow-action-backward)

(global-set-key (kbd "M-i")     'helm-imenu)
(global-set-key (kbd "M-I")     'helm-imenu-anywhere)

(evil-leader/set-key
  "<SPC>" 'helm-mini
  "r"     'helm-recentf

  "bb" 'helm-buffers-list
  "bd" 'mb/delete-current-buffer-file
  "bh" 'bury-buffer
  "br" 'rename-current-buffer-file
  "bs" 'scratch
  "bm" 'helm-bookmarks

  "ff" 'helm-find-files
  "s"  'helm-occur
  "fc" 'helm-colors)



;; Projectile: project management tool
;; variables must be set BEFORE requiring projectile
(setq-default
 projectile-cache-file (expand-file-name "projectile.cache"         mb-save-path)
 projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" mb-save-path)
 projectile-mode-line '(:eval (format " [%s]" (projectile-project-name)))
 projectile-completion-system    'helm)

(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode t)
(helm-projectile-on)

;; must be after helm-projectile-on otherwise it would be overwritten by helm-projectile
(setq projectile-switch-project-action 'helm-projectile-recentf)

;; remove prefix "/:" when detecting base
;; dir to avoid issues with command line apps:
;; "/:/home/mbme/configs" -> "/home/mbme/configs"
(advice-add 'projectile-project-root :around
            (lambda (origin-fun)
              (s-chop-prefix "/:" (funcall origin-fun))))

(advice-add 'mb/helm-projectile-ag-dwim :around #'mb/add-to-evil-jump-list)

(evil-leader/set-key
  "pp" 'helm-projectile-switch-project
  "pd" 'helm-projectile-find-dir
  "pD" 'projectile-dired
  "pf" 'helm-projectile-find-file
  "pF" 'helm-projectile-find-file-dwim
  "ps" 'helm-projectile-ag
  "pS" 'mb/helm-projectile-ag-dwim
  "ph" 'helm-projectile
  "pr" 'helm-projectile-recentf
  "pR" 'projectile-replace
  "pb" 'helm-projectile-switch-to-buffer
  "pk" 'projectile-kill-buffers)



;; Company-mode: autocomplete
(require 'company)
(require 'company-statistics)

(setq
 company-idle-delay                0.3
 company-tooltip-limit             20
 company-minimum-prefix-length     1
 company-echo-delay                0
 company-auto-complete             nil
 company-selection-wrap-around     t

 ;; company-dabbrev-ignore-case       t
 ;; company-dabbrev-downcase          nil

 company-statistics-file   (expand-file-name "company-statistics-cache.el" mb-save-path)

 company-require-match             nil
 company-tooltip-align-annotations t)

(delete 'company-xcode company-backends)
(delete 'company-ropemacs company-backends)

(global-company-mode 1)
(company-statistics-mode)

(define-key company-active-map (kbd "M-j") 'company-select-next)
(define-key company-active-map (kbd "M-k") 'company-select-previous)
(define-key company-active-map [escape]    'company-abort)
(global-set-key (kbd "M-p") 'company-manual-begin)



;; Project-explorer
(require 'project-explorer)

(setq
 pe/omit-gitignore            t
 pe/goto-current-file-on-open nil
 pe/project-root-function     'projectile-project-root
 pe/cache-directory (expand-file-name "project-explorer-cache/" mb-save-path))
(add-hook 'project-explorer-mode-hook
          (lambda ()
            (linum-mode 0)
            (hl-line-mode)
            (text-scale-set -0.65)))
;; just open buffer in other window
;; with default function there are some issues with switching to previous buffer
(setq pe/display-content-buffer-function 'switch-to-buffer)

(evil-set-initial-state 'project-explorer-mode 'emacs)

(global-set-key (kbd "M-1") 'mb/project-explorer-maybe-open)
(define-key project-explorer-mode-map (kbd "M-1") 'pe/quit)
(global-set-key [(meta f1)] (lambda () (interactive) (mb/project-explorer-maybe-open t)))
(define-key project-explorer-mode-map [(meta f1)] 'pe/quit)



;; Editorconfig
(require 'editorconfig)
(defun mb/reload-editorconfig ( )
  "Reload editorconfig file and set variables for current major mode."
  (interactive)
  (message "mb: reloading EditorConfig...")
  (edconf-find-file-hook))



;; Anzu
(require 'anzu)
(require 'evil-anzu)
(global-anzu-mode t)
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



;; Avy-mode: ace-jump replacement
(require 'avy)
(setq avy-background t)
(setq avy-style 'at-full)
(evil-leader/set-key "." 'avy-goto-word-or-subword-1)



;; Swiper: better search
(require 'swiper)
(require 'counsel)
(ivy-mode 1)
(setq
 ivy-use-virtual-buffers t
 ivy-count-format "(%d/%d) ")

(define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "C-w") 'ivy-backward-kill-word)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f7] 'ivy-resume)

(global-set-key (kbd "C-x C-f") 'counsel-find-file)




;; Linum-mode: show line numbers
;; disabled: currently company mode breaks it
(require 'linum)
(setq linum-format "%4d")
(global-linum-mode 0)



;; Hl-line mode: highlight current line
(require 'hl-line)
(global-hl-line-mode 1)
;; (set-face-background 'hl-line mb-color13)



;; Uniquify: unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      ;; rename after killing uniquified
      uniquify-after-kill-buffer-p t
      ;; don't muck with special buffers
      uniquify-ignore-buffers-re "^\\*")



;; Recentf: show recent files
(require 'recentf)
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
(recentf-track-opened-file)



;; Bookmark menu
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" mb-save-path)
      bookmark-save-flag 1)

(evil-set-initial-state 'bookmark-bmenu-mode 'normal)

(global-set-key [f11]   'bookmark-bmenu-list)
(define-key bookmark-bmenu-mode-map [f11] 'quit-window)

(evil-define-key 'normal bookmark-bmenu-mode-map
  (kbd "RET") 'bookmark-bmenu-this-window
  "J"         'bookmark-jump
  "r"         'bookmark-bmenu-rename
  "R"         'bookmark-bmenu-relocate
  "s"         'bookmark-bmenu-save

  "d"         'bookmark-bmenu-delete
  (kbd "C-d") 'bookmark-bmenu-delete-backwards
  "x"         'bookmark-bmenu-execute-deletions)



;; IBuffer
;; use ibuffer on C-x C-b
(defalias 'list-buffers 'ibuffer)
;; use ibuffer as default buffers list (:ls)
(defalias 'buffer-menu 'ibuffer)

(global-set-key [f2]    'ibuffer)

(define-key ibuffer-mode-map [f2]      'ibuffer-quit)
(define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line)
(define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line)
(define-key ibuffer-mode-map (kbd "J") 'ibuffer-jump-to-buffer)
(define-key ibuffer-mode-map (kbd "l") 'ibuffer-visit-buffer)
(define-key ibuffer-mode-map (kbd "v") 'ibuffer-toggle-marks)



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
(require 'subword)
(global-subword-mode t)



;; Electric indent mode: enable autoindent on enter etc.
(electric-indent-mode 1)



;; Hideshow-mode: show/hide blocks
(setq hs-special-modes-alist
      (append '(go-mode "{" "}" "/[*/]" nil nil) hs-special-modes-alist)
      ;; Hide the comments too when you do a 'hs-hide-all'
      hs-hide-comments nil)
(add-hook 'prog-mode-hook 'hs-minor-mode)



;; Winner mode: undo/redo windows configuration
(require 'winner)
(winner-mode 1)



;; Eshell
(require 'eshell)
(require 'esh-buf-stack)

;; half-way through typing a long command and need something else,
;; just M-q to hide it, type the new command, and continue where I left off.
(setup-eshell-buf-stack)

(setq eshell-scroll-to-bottom-on-input t)

;; keybinding for eshell must be defined in eshell hook
(add-hook 'eshell-mode-hook '(lambda ()
                               (add-to-list 'eshell-visual-commands "htop")
                               (add-to-list 'eshell-visual-commands "ranger")

                               (define-key eshell-mode-map [tab] 'company-manual-begin)
                               (define-key eshell-mode-map [M-tab] 'mb/prev-buffer)
                               (define-key eshell-mode-map (kbd "M-h") 'helm-eshell-history)

                               (define-key eshell-mode-map (kbd "C-d") 'bury-buffer)

                               (define-key eshell-mode-map (kbd "M-q") 'eshell-push-command)

                               ;; use helm to show candidates
                               (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
                               ;; use helm to show history
                               (substitute-key-definition 'eshell-list-history 'helm-eshell-history eshell-mode-map)
                               ))
;; override default eshell `clear' command.
(defun eshell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))



;; Hippie expand is dabbrev expand on steroids
;; do not split words on _ and -
(setq dabbrev-abbrev-char-regexp "[a-zA-Z0-9?!_-]")
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line))

(global-set-key (kbd "M-/") 'hippie-expand)



;; Eldoc
(add-hook  'emacs-lisp-mode-hook        'turn-on-eldoc-mode)
(add-hook  'lisp-interaction-mode-hook  'turn-on-eldoc-mode)
(add-hook  'ielm-mode-hook              'turn-on-eldoc-mode)



;; Dired
(require 'dired)
(require 'dired-x)

(setq dired-auto-revert-buffer t    ; automatically revert buffer
      dired-clean-up-buffers-too t) ; kill buffers for deleted files

(evil-set-initial-state 'wdired-mode 'normal)
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
  "q" 'kill-this-buffer)

(evil-leader/set-key "d" 'dired-jump)



;; Which-function-mode: show current function (disabled)
;; (require 'which-func)
;; (which-function-mode 1)



;; Show parens mode: highlight matching parens
(require 'paren)
(setq show-paren-delay 0
      ;; decrease overlay priority because
      ;; it's higher than selection
      show-paren-priority 10
      ;; highlight everything inside parens
      show-paren-style 'expression)
;; (set-face-background 'show-paren-match-face mb-color12)
(show-paren-mode 1)



;; Volatile-highlights: momentarily highlight changes
;; made by commands such as undo, yank-pop, etc.
(require 'volatile-highlights)
(volatile-highlights-mode t)



;; Ethan-wspace manage whitespace
(require 'ethan-wspace)
(setq mode-require-final-newline nil
      require-final-newline nil)
(global-ethan-wspace-mode 1)



;; Powerline
(require 'powerline)

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
                                     (funcall separator-left face1 face2)
                                     (when (bound-and-true-p nyan-mode)
                                       (powerline-raw (list (nyan-create)) face2 'l))))
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
(mb/powerline-default-evil-theme)



;; Nyan mode
(require 'nyan-mode)
(nyan-mode t)



;; Flycheck: error checking on the fly
(require 'flycheck)
(require 'flycheck-pos-tip)

(setq flycheck-indication-mode 'left-fringe)
(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(set-face-foreground  'flycheck-fringe-error    mb-color7)
(set-face-foreground  'flycheck-fringe-info     mb-color8)
(set-face-foreground  'flycheck-fringe-warning  mb-color2)

(define-fringe-bitmap 'my-flycheck-fringe-indicator
  (vector #b00000000
          #b00000000
          #b00000000
          #b00000000
          #b01111111
          #b01111111
          #b01111111
          #b01111111
          #b01111111
          #b01111111
          #b01111111
          #b01111111
          #b00000000
          #b00000000
          #b00000000
          #b00000000
          #b00000000))

(flycheck-define-error-level 'error
  :overlay-category 'flycheck-error-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-error)
(flycheck-define-error-level 'warning
  :overlay-category 'flycheck-warning-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-warning)
(flycheck-define-error-level 'info
  :overlay-category 'flycheck-info-overlay
  :fringe-bitmap 'my-flycheck-fringe-indicator
  :fringe-face 'flycheck-fringe-info)

;; from http://www.lunaryorn.com/2014/07/30/new-mode-line-support-in-flycheck.html
(setq flycheck-mode-line
      '(:eval
        (pcase flycheck-last-status-change
          (`not-checked nil)
          (`no-checker (propertize " -" 'face 'warning))
          (`running (propertize " ✷" 'face 'success))
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


(advice-add 'projectile-project-root :around
            (lambda (origin-fun)
              (s-chop-prefix "/:" (funcall origin-fun))))

(advice-add 'flycheck-first-error :around #'mb/add-to-evil-jump-list)
(advice-add 'flycheck-next-error :around #'mb/add-to-evil-jump-list)
(advice-add 'flycheck-previous-error :around #'mb/add-to-evil-jump-list)

(define-prefix-command 'mb-flycheck-map)
(global-set-key (kbd "M-e")   'mb-flycheck-map)
(global-set-key (kbd "M-e 1") 'flycheck-first-error)
(global-set-key (kbd "M-e j") 'flycheck-next-error)
(global-set-key (kbd "M-e k") 'flycheck-previous-error)
(global-set-key (kbd "M-e l") 'flycheck-list-errors)
(global-set-key (kbd "M-e b") 'flycheck-buffer)



;; Imenu-anywhere: entries for imenu across all open buffers of the same type
(require 'imenu-anywhere)



;; Expand-region: expand selection like C-w in intellij idea
(require 'expand-region)

;; start expanding region as C-w in intellij idea
(global-set-key (kbd "M-w") 'er/expand-region)
(global-set-key (kbd "M-W") 'er/contract-region)



;; Rainbow-mode: highlight colors
(require 'rainbow-mode)
;; dirty fix for having rainbow mode everywhere
(define-globalized-minor-mode global-rainbow-mode
  rainbow-mode (lambda ()
                 (if (not (minibufferp (current-buffer)))
                     (rainbow-mode 1))))
(global-rainbow-mode t)



;; Smartparens: parens pairs management
(require 'smartparens-config)
(smartparens-global-mode)



;; Rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)



;; Highlight-indentation
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face mb-color12)
(set-face-background 'highlight-indentation-current-column-face mb-color13)

(add-hook 'ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))
(add-to-list
 'auto-mode-alist
 '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'"
   . ruby-mode))
(add-to-list
 'auto-mode-alist
 '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'"
   . ruby-mode))



;; YASnippet: snippets
(require 'yasnippet)
(require 'helm-c-yasnippet)
(setq
 helm-c-yas-display-key-on-candidate t
 helm-c-yas-space-match-any-greedy   t

 yas-verbosity                       1
 yas-wrap-around-region              t
 yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

(yas-global-mode)

;; do not highlight missing new line at the end of the snippet file
(add-hook 'snippet-mode-hook
          (lambda ()
            (setq ethan-wspace-errors (remove 'no-nl-eof ethan-wspace-errors))))


;; disable `yas-expand` on TAB
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(setq yas-keymap
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "C-n") 'mb/yas-next-field)
        (define-key map (kbd "C-p") 'yas-prev-field)
        (define-key map (kbd "C-g") 'yas-abort-snippet)
        map))

(global-set-key (kbd "C-j") 'mb/yas-expand-or-complete)



;; Magit: UI for git
(require 'magit)
(setq
 magit-last-seen-setup-instructions "1.4.0"
 vc-follow-symlinks nil

 ;; open magit status in same window as current buffer
 magit-status-buffer-switch-function 'switch-to-buffer
 ;; highlight word/letter changes in hunk diffs
 magit-diff-refine-hunk t
 ;; ask me if I want to include a revision when rewriting
 magit-rewrite-inclusive 'ask
 ;; ask me to save buffers
 magit-save-some-buffers t
 ;; pop the process buffer if we're taking a while to complete
 magit-process-popup-time 10
 ;; don't show " MRev" in modeline
 magit-auto-revert-mode-lighter ""
 magit-push-always-verify nil
 ;; ask me if I want a tracking upstream
 magit-set-upstream-on-push 'askifnotset)

;; modes to show diff automatically
(setq magit-diff-auto-show '(log-oneline log-select blame-follow))


;; these two force a new line to be inserted into a commit window,
;; which stops the invalid style showing up.
;; From: http://git.io/rPBE0Q
(add-hook 'git-commit-mode-hook
          (lambda () (when (looking-at "\n") (open-line 1))))

;; blame
(evil-define-key 'normal magit-blame-map
  "q"         'magit-blame-mode
  "j"         'magit-blame-next-chunk
  "k"         'magit-blame-previous-chunk
  (kbd "RET") 'magit-blame-locate-commit)

(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)

(evil-leader/set-key
  "gs" 'magit-status
  "gl" 'magit-file-log
  "gb" 'magit-blame-mode)



;; Git-gutter-fringe
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(set-face-foreground 'git-gutter-fr:deleted  mb-color7)
(set-face-foreground 'git-gutter-fr:added    mb-color8)
(set-face-foreground 'git-gutter-fr:modified mb-color9)

(setq git-gutter:hide-gutter t)
;; Don't need log/message.
(setq git-gutter:verbosity 0)
(setq git-gutter-fr:side 'right-fringe)

(add-hook 'git-gutter:update-hooks 'magit-revert-buffer-hook)
(add-to-list 'git-gutter:update-hooks 'focus-in-hook)
(add-to-list 'git-gutter:update-commands 'other-window)

(evil-leader/set-key
  "gj" 'git-gutter:next-hunk
  "gk" 'git-gutter:previous-hunk
  "gp" 'git-gutter:popup-hunk
  "gr" 'git-gutter:revert-hunk)



;; Flyspell mode
;; flyspell-mode does spell-checking on the fly as you type
(require 'flyspell)
(require 'helm-flyspell)
(setq ispell-personal-dictionary (expand-file-name "aspell.en.pws" dotfiles-dir)
      ispell-program-name "aspell" ; use aspell instead of ispell
      ;; ispell-extra-args '("--sug-mode=ultra" "--run-together" "--run-together-limit=5" "--run-together-min=2")
      )
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook (lambda ()
                            (setq flyspell-consider-dash-as-word-delimiter-flag t)
                            (flyspell-prog-mode)
                            ))

(global-set-key [f8]    'helm-flyspell-correct)
(global-set-key [M-f8]  'flyspell-buffer)



;; Makefile mode
(add-hook 'makefile-mode-hook
          (lambda ()
            ;; Turn on tabs
            (setq indent-tabs-mode t)
            (setq ethan-wspace-errors (remove 'tabs ethan-wspace-errors))))



;; highlight tabs and trailing whitespace
(require 'highlight-chars)
(add-hook 'font-lock-mode-hook (lambda ()
                                 (hc-highlight-trailing-whitespace)
                                 (hc-highlight-hard-hyphens)
                                 (hc-highlight-hard-spaces)
                                 (hc-highlight-tabs)))



;; Go-mode: Golang mode
(require 'company-go)
(setq company-go-insert-arguments nil)

(add-hook 'go-mode-hook
          (lambda ()
            ;; go-rename
            (load "rename.el")
            ;; go-eldoc
            (go-eldoc-setup)

            (add-hook 'before-save-hook 'gofmt-before-save)

            (setq ethan-wspace-errors (remove 'tabs ethan-wspace-errors))

            (set (make-local-variable 'company-backends) '((company-go :with company-dabbrev-code)))
            (company-mode)

            ;; unbind go-mode-insert-and-indent
            ;; because it conflicts with something else
            (define-key go-mode-map (kbd "}") nil)
            (define-key go-mode-map (kbd ")") nil)
            (define-key go-mode-map (kbd ",") nil)
            (define-key go-mode-map (kbd ":") nil)
            (define-key go-mode-map (kbd "=") nil)))

(evil-leader/set-key-for-mode 'go-mode
  "mr" 'go-rename
  "mj" 'godef-jump
  "md" 'godef-describe
  "ma" 'go-import-add
  "mi" 'go-goto-imports)



;; Python mode
(require 'anaconda-mode)
(require 'company-anaconda)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(add-to-list 'company-backends 'company-anaconda)



;; Clojure mode
(require 'clojure-mode-extra-font-locking)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-use-pretty-printing t)
;; (setq cider-repl-display-in-current-window t)

(evil-set-initial-state 'cider-repl-mode 'emacs)
(evil-set-initial-state 'nrepl-mode 'emacs)

(evil-leader/set-key-for-mode 'clojure-mode
  "mj"  'cider-jack-in
  "mq"  'cider-quit
  "mn"  'cider-repl-set-ns
  "meb" 'cider-eval-buffer
  "mer" 'cider-eval-region
  "mes" 'cider-eval-last-sexp
  "mz"  'cider-switch-to-repl-buffer)



;; Javascript
(require 'js)
;; disable jshint since we prefer eslint checking
;; (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(javascript-jshint)))
(add-hook 'js-mode-hook (lambda ()
                          (setq imenu-create-index-function 'mb/imenu-js-make-index)))



;; JS2 mode
(require 'js2-mode)
(setq
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

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (js2-imenu-extras-mode)



;; Json-mode
(require 'json-mode)
;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(json-jsonlist)))

(defun mb/json-beautify (&rest ignored)
  "Beautify json buffer.  Ignore all `IGNORED' vars."
  (json-mode-beautify))
;; set format function for json
(add-hook 'json-mode-hook (lambda ()
                            (setq-local indent-region-function 'mb/json-beautify)))
(add-to-list 'auto-mode-alist '("\\.eslintrc$" . json-mode))



;; Tern (disabled)
(require 'tern)
;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (add-to-list 'company-backends '(company-tern :with company-dabbrev-code))

(evil-leader/set-key-for-mode 'js-mode
  "mr" 'tern-rename-variable
  "md" 'tern-get-docs
  "mj" 'tern-find-definition)



;; WebMode
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))

(evil-leader/set-key-for-mode 'web-mode
  "mr" 'web-mode-element-rename)


;; React.js JSX-related configs

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defun mb/web-mode-jsx-hacks ()
  "Enable eslint for jsx in flycheck."
  (if (or (equal web-mode-content-type "jsx")
          (equal web-mode-content-type "javascript"))
      (progn
        (flycheck-select-checker 'javascript-eslint)
        (setq imenu-create-index-function 'mb/imenu-js-make-index))
    (flycheck-disable-checker 'javascript-eslint)))

(add-hook 'web-mode-hook 'mb/web-mode-jsx-hacks)
(setq web-mode-content-types-alist '(("jsx" . "\\.js\\'")))



;; CoffeeScript
(require 'coffee-mode)
(custom-set-variables `(coffee-tab-width ,mb-web-indent-size))



;; SCSS-mode
(require 'scss-mode)
(setq scss-compile-at-save nil)



;; Yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))



;; Emmet mode
(require 'emmet-mode)
(setq emmet-preview-default nil)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode)
(add-hook 'js-mode-hook   'emmet-mode)
(define-key emmet-mode-keymap (kbd "C-j") nil)



;; Emacs Lisp
(evil-leader/set-key-for-mode 'emacs-lisp-mode "meb" 'eval-buffer)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "mer" 'eval-region)
(evil-leader/set-key-for-mode 'emacs-lisp-mode "mes" 'eval-last-sexp)



;; Diminish: cleanup mode line
(require 'diminish)
(diminish 'flyspell-mode)
(diminish 'yas-minor-mode)
(diminish 'undo-tree-mode)
(diminish 'smartparens-mode)
(diminish 'volatile-highlights-mode)
(diminish 'company-mode)
(diminish 'subword-mode)
(diminish 'rainbow-mode)
(diminish 'git-gutter-mode)
(diminish 'ethan-wspace-mode)
(diminish 'ivy-mode)
(diminish 'helm-mode)
(diminish 'anzu-mode)
(add-hook 'hs-minor-mode-hook
          (lambda() (diminish 'hs-minor-mode)))
(add-hook 'emacs-lisp-mode-hook
          (lambda() (setq mode-name "ELisp")))
(add-hook 'lisp-interaction-mode-hook
          (lambda() (setq mode-name "λ")))
(add-hook 'eldoc-mode-hook
          (lambda() (diminish 'eldoc-mode)))



;; ---------------------------------------- GLOBAL KEYBINDINGS

;; disable input methods
(global-set-key (kbd "C-\\") nil)

;; prevent accidentally closed frames
(global-unset-key (kbd "C-x C-z"))


(global-unset-key (kbd "M-,"))
(global-set-key (kbd "M-.") 'avy-goto-word-or-subword-1)


;; zoom in / zoom out in editor
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
(when is-mac-os
  (global-set-key (kbd "C-<wheel-up>")   'text-scale-increase)
  (global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease))


(global-set-key (kbd "C-c L")   'mb/untabify-buffer)
(global-set-key (kbd "C-c l")   'mb/cleanup-buffer)
(global-set-key (kbd "C-c t")   'mb/sort-columns)
(global-set-key (kbd "C-x e")   'mb/eval-and-replace)
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key [M-tab]         'mb/prev-buffer)
(global-set-key (kbd "M-S-SPC") 'just-one-space)

(global-set-key [f4]    'mb/terminal)
(global-set-key [M-f4]    'mb/projectile-base-term)
(global-set-key [f5]    'make-frame)
(global-set-key [f6]    'mb/revert-buffer)
(global-set-key [f12]   'menu-bar-mode)


;; NOTE: m is reserved for mode-local bindings
(evil-leader/set-key
  "o" 'other-window

  "2" 'call-last-kbd-macro
  "," 'mb/prev-buffer
  "n" 'mb/narrow-or-widen-dwim
  "c" 'mb/toggle-comment-region-or-line
  "ll" 'mb/cleanup-buffer
  "le" 'mb/reload-editorconfig
  "lm" 'evil-show-marks
  "k" 'kill-this-buffer
  "TAB" 'helm-all-mark-rings

  "pm" 'helm-make-projectile

  "u" 'undo-tree-visualize

  "e" 'eshell
  "E" (lambda () (interactive) (eshell t)))


(provide 'init)
;;; init.el ends here

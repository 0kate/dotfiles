;;; init.el --- Summary



;;; Commentary:

;;; Code:

;;; Parse command line args
;; (defvar with-profiler (seq-contains-p command-line-args "--with-profiler"))
;; (defvar with-refresh-packages (seq-contains-p command-line-args "--with-refresh-packages"))
;; (defvar with-clipboard (seq-contains-p command-line-args "--with-clipboard"))
(defvar with-profiler t)
(defvar with-refresh-packages t)
(defvar with-clipboard t)

;;; Profiler:
(when with-profiler
  (require 'profiler)
  (profiler-start 'cpu))

;;; Packages manager:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))

(when with-refresh-packages
  (package-initialize)
  (package-refresh-contents))

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (message "use-package is not ready. Installing...")
    (package-install 'use-package)
    (message "use-package is installed!"))
  (require 'use-package))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; We need this import for compiled init file.
;; In uncompiled init.el, use-package will autoload bind-key package.
;; But in compiled init.el, bind-key is not autoloaded.
;; For more details, see https://github.com/jwiegley/use-package/issues/436.
(require 'bind-key)

;; (add-to-list 'load-path "/home/kate/.config/emacs/scripts")

;; (load "my-eshell.el")

;; (load "exec-path-from-asdf.el")
;; (exec-path-from-asdf-initialize)
;; (load "clipper.el")
;; (clipper-setup)


;; Packages (Enhancements)
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-copy-envs '("ASDF_DIR" "ASDF_DATA_DIR"))
  (exec-path-from-shell-initialize))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1))

(use-package projectile-rails
  :ensure t
  :after (projectile)
  :config
  (projectile-rails-global-mode))

(use-package all-the-icons
  :ensure t)

(use-package treemacs
  :ensure t
  :bind (("C-t" . (treemacs))
         ("C-l" . (lambda () (enlarge-window-horizontally)))
         ("C-h" . (lambda () (shrink-window-horizontally)))))

(use-package treemacs-evil
  :ensure t
  :bind (("C-t" . (treemacs))))

(use-package treemacs-all-the-icons
  :ensure t
  (treemacs-load-theme "all-the-icons"))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (setq evil-want-keybinding t)
  ;; normal mode
  (evil-global-set-key 'normal (kbd "C-h") 'shrink-window-horizontally)
  (evil-global-set-key 'normal (kbd "C-j") 'enlarge-window)
  (evil-global-set-key 'normal (kbd "C-k") 'shrink-window)
  (evil-global-set-key 'normal (kbd "C-l") 'enlarge-window-horizontally)
  (evil-global-set-key 'normal (kbd "C-t") 'treemacs)
  ;; insert mode
  (evil-global-set-key 'insert (kbd "C-h") 'shrink-window-horizontally)
  (evil-global-set-key 'insert (kbd "C-l") 'enlarge-window-horizontally)
  (evil-global-set-key 'insert (kbd "C-t") 'treemacs)
  :hook
  ((eshell-mode . (lambda ()
                    ;;; for input histories
                    (evil-define-key 'insert eshell-mode-map (kbd "C-p") 'eshell-previous-input)
                    (evil-define-key 'insert eshell-mode-map (kbd "C-n") 'eshell-next-input)
                    ;;; for moving windows
                    (evil-define-key 'insert eshell-mode-map (kbd "C-w h") 'evil-window-left)
                    (evil-define-key 'insert eshell-mode-map (kbd "C-w j") 'evil-window-down)
                    (evil-define-key 'insert eshell-mode-map (kbd "C-w k") 'evil-window-up)
                    (evil-define-key 'insert eshell-mode-map (kbd "C-w l") 'evil-window-right)))
   (treemacs-mode . (lambda ()
                      (evil-define-key 'normal treemacs-mode-map (kbd "C-c C-l") 'treemacs-root-down)
                      (evil-define-key 'normal treemacs-mode-map (kbd "C-c C-h") 'treemacs-root-up)
                      (evil-define-key 'normal treemacs-mode-map (kbd "C-c C-n") 'treemacs-create-file)
                      (evil-define-key 'normal treemacs-mode-map (kbd "C-m") 'treemacs-RET-action)
                      (evil-define-key 'normal treemacs-mode-map (kbd "<RET>") 'treemacs-RET-action)))))

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init '(company eshell ibuffer ivy magit)))

(use-package git-gutter
  :ensure t
  :init
  (setq git-gutter:modified-sign "~")
  :config
  (global-git-gutter-mode +1))

(use-package whitespace
  :init
  (setq whitespace-line nil
        whitespace-display-mappings '((space-mark   ?\x3000 [?\▫])
                                      (tab-mark     ?\t     [?\xBB ?\t])
                                      (newline-mark ?\n     [?¬ ?\n])))
  :config
  (global-whitespace-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :init
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?┊)
  :hook ((prog-mode . highlight-indent-guides-mode)))

(use-package rainbow-mode :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package company
  :ensure t
  :init
  (setq company-backends '((company-capf company-dabbrev-code))
        company-minimum-prefix-length 1
        company-idle-delay 0)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package restclient :ensure t)
(use-package company-restclient
  :ensure t
  :after (company)
  :config
  (add-to-list 'company-backends 'company-restclient))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package flycheck-rust
  :ensure t
  :after (flycheck)
  :config
  :hook ((rust-mode . flycheck-rust-setup)))

(use-package ivy
  :ensure t
  :config
  (ivy-mode t))

(use-package ibuffer-projectile
  :ensure t
  :hook
  ((ibuffer-mode . (lambda ()
                     (ibuffer-projectile-set-filter-groups)
                     (unless (eq ibuffer-sorting-mode 'alphabetic)
                       (ibuffer-do-sort-by-alphabetic))))))


;; Packages (Integrations)
(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package magit :ensure t)

(use-package yaml-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package docker :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package typescript-mode
  :ensure t
  :after (tide)
  :hook ((typescript-mode . setup-tide-mode)))

(use-package json-mode
  :ensure t
  :init
  (setq js-indent-level 2))

(use-package tide
  :ensure t
  :after (typescript-mode)
  :init
  (setq tide-completion-ignore-case t
        tide-completion-show-source t
        tide-completion-fuzzy t
        tide-completion-detailed t)
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  :hook ((web-mode . (lambda () (tide-setup)))))

(use-package web-mode
  :ensure t
  :init
  (setq web-mode-attr-indent-offset nil
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-auto-closing t
        web-mode-enable-auto-pairing t
        web-mode-auto-close-style 2)
  :mode (("\\.js\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :config
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  :hook ((web-mode . (lambda ()
                       (when (string-equal "tsx" (file-name-extension buffer-file-name))
                         (setup-tide-mode)))))
  :custom
  (web-mode-tag-auto-close-style 2)
  :custom-face
  (web-mode-html-tag-bracket-face ((t (:foreground "#909090")))))

(use-package emacs-prisma-mode
  :ensure t
  :straight (emacs-prisma-mode :type git :host github :repo "pimeys/emacs-prisma-mode"))

(use-package lsp-mode
  :ensure t
  :init
  ;; for debugging
  ;; (when debug-lsp (setq lsp-log-io t))
  :hook ((c-mode . lsp)
         (ruby-mode . lsp)
         (rust-mode . lsp)
         (typescript-mode . lsp)
         (typescript-tsx-mode . lsp)
         (clojure-mode . lsp)
         (yaml-mode . lsp)
         (web-mode . lsp)
         (dockerfile-mode . lsp))
  :custom
  ;; for clangd
  (setq lsp-clangd-binary-path (executable-find "clangd"))
  ;; for rust-analyzer
  (lsp-rust-analyzer-server-command '("rustup" "run" "stable" "rust-analyzer"))
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-binding-mode-hints t)
  (lsp-rust-analyzer-inlay-hints-mode t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable t)
  (lsp-rust-analyzer-server-display-inlay-hints t))

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :init
  (setq lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions t))


;; Hooks
(defun disable-scroll-margin ()
  (setq-local maximum-scroll-margin 0.5
              scroll-margin 99999
              scroll-step 1))

;; (add-hook 'window-setup-hook (lambda ()
;;                                (set-face-background 'default (if (display-graphic-p) "#000000" "undefined"))))
(add-hook 'treemacs-mode-hook (lambda ()
                                (display-line-numbers-mode -1)
                                (treemacs-toggle-fixed-width)
                                (treemacs-load-theme "all-the-icons")))
(add-hook 'eshell-mode-hook (lambda ()
                              (setq-local evil-mode -1)
                              (display-line-numbers-mode -1)
                              (eshell-disable-buffer-control)))
(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 8)))
(add-hook 'prog-mode-hook (lambda () (disable-scroll-margin)))
(add-hook 'text-mode-hook (lambda () (disable-scroll-margin)))
(add-hook 'before-make-frame-hook (lambda ()
                                    (add-to-list 'default-frame-alist '(undecorated . t))))
(add-hook 'after-make-frame-functions (lambda (frame)
                                        (setq neo-theme 'icons)
                                        (set-face-background 'default "#000000")))

(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))



;; Basic options
(setq-default truncate-lines 1
              indent-tabs-mode nil)
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)
(electric-pair-mode 1)
(rectangle-mark-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

(defvar frame-height-increase 1)

(defun increase-frame-height ()
  (interactive)
  (set-frame-height (selected-frame) (+ (frame-height) frame-height-increase)))

(defun decrease-frame-height ()
  (interactive)
  (set-frame-height (selected-frame) (- (frame-height) frame-height-increase)))

;; Basic keybinds
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "M-n") 'increase-frame-height)
(global-set-key (kbd "M-p") 'decrease-frame-height)

;; Debug options
;; (setq max-specpdl-size 5
;;       debug-on-error t)



;; Custsom commands
(defun restclient-new-buffer ()
  (interactive)
  (set-buffer (generate-new-buffer "*restclient*"))
  (restclient-mode))

(defun enable-window-sizing ()
  (interactive)
  (global-set-key (kbd "C-n") 'enlarge-window)
  (global-set-key (kbd "C-p") 'shrink-window)
  (global-set-key (kbd "C-f") 'enlarge-window-horizontally)
  (global-set-key (kbd "C-b") 'shrink-window-horizontally))

(defun disable-window-sizing ()
  (interactive)
  (global-set-key (kbd "C-n") 'next-line)
  (global-set-key (kbd "C-p") 'previous-line)
  (global-set-key (kbd "C-f") 'forward-char)
  (global-set-key (kbd "C-b") 'backward-char))

(defun eshell-enable-buffer-control ()
  (interactive)
  (when (eq major-mode 'eshell-mode)
    (local-set-key (kbd "C-p") 'previous-line)
    (local-set-key (kbd "C-n") 'next-line)
    (message "[eshell] Buffer control is enabled")))

(defun eshell-disable-buffer-control()
  (interactive)
  (when (eq major-mode 'eshell-mode)
    (local-set-key (kbd "C-p") 'eshell-previous-input)
    (local-set-key (kbd "C-n") 'eshell-next-input)
    (message "[eshell] Buffer control is disabled")))

(defun split ()
  "Vim like key bindings for window splitting."
  (interactive)
  (split-window-vertically))

(defun vsplit ()
  "Vim like key bindings for window splitting."
  (interactive)
  (split-window-horizontally))

(defun copy-to-clipboard (text)
  "Copy selected TEXT into the GUI's clipboard."
  (let* ((copy-process (make-process :name "copy-proc"
                                     :buffer nil
                                     :command '("xclip")
                                     :connection-type 'pipe)))
    (process-send-string copy-process text)
    (process-send-eof copy-process)))

(defun paste-from-clipboard ()
  "Paste text from the GUI's clipboard."
  (shell-command-to-string "xclip -o"))

(when with-clipboard
  (setq interprogram-cut-function 'copy-to-clipboard)
  (setq interprogram-paste-function 'paste-from-clipboard))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(custom-set-variables
 '(eshell-prompt-function
   (lambda nil
     (concat
      (propertize (getenv "USER")
                  'face '(:foreground "green" :bold t))
      (propertize "@"
                  'face '(:foreground "white"))
      (propertize (system-name)
                  'face '(:foreground "white"))
      (propertize ":"
                  'face '(:foreground "white"))
      (eshell/pwd)
      (propertize "  "
                  'face '(:foreground "white"))
      (magit-get-current-branch)
      (propertize "  "
                  'face '(:foreground "white")))))
 '(eshell-prompt-regexp ".*  "))



(when with-profiler
  (profiler-report)
  (profiler-stop))

(provide 'init)

;;; init.el ends here

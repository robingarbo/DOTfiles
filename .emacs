;; ;; config cedet first, so to avoid max-lisp-eval-depth error
;; ;; from: http://emacser.com/cedet.htm
;; (load-file "/home/zhanxw/emacsesscedet/common/cedet.el")
;; ;; (semantic-load-enable-minimum-features)
;; (semantic-load-enable-code-helpers)
;; ;; (semantic-load-enable-guady-code-helpers)
;; ;; (semantic-load-enable-excessive-code-helpers)
;; (semantic-load-enable-semantic-debugging-helpers)
;; ;; use M-x eassist-switch-h-cpp => switch between .cpp and .h
;; (require 'semantic-c nil 'noerror)
;; (setq eassist-header-switches
;;       '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
;;         ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
;;         ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
;;         ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
;;         ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
;;         ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
;;         ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
;;         ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
;;         ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
;;         ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
;;         ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
;;         ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
;;         ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
;;         ("c" . ("h"))
;;         ("m" . ("h"))
;;         ("mm" . ("h"))))


(global-font-lock-mode t)
(global-font-lock-mode t)
(set-face-foreground 'font-lock-comment-face "red")
(set-face-foreground 'font-lock-comment-delimiter-face "red")
(transient-mark-mode t)
(column-number-mode t)

;; my old indent style 
;; (setq standard-indent 2)
;; (require 'cc-mode)
;; (c-set-offset 'substatement-open 0)
;; (c-set-offset (quote substatement) 2 nil)
;; (c-set-offset 'defun-block-intro 2)
;; (c-set-offset 'statement-block-intro 2)
;; (c-set-offset 'statement-case-intro 2)
;; (setq standard-indent 2)

;; To conform to Karma code standard
;; we use K&R style and 4 as indent length.
;;(c-set-offset 'substatement-open 0)
(require 'cc-mode)
(defun my-build-tab-stop-list (width)
  (let ((num-tab-stops (/ 80 width))
	(counter 1)
	(ls nil))
    (while (<= counter num-tab-stops)
      (setq ls (cons (* width counter) ls))
      (setq counter (1+ counter)))
    (set (make-local-variable 'tab-stop-list) (nreverse ls))))
(defun my-c-mode-common-hook ()
  (c-set-style "k&r")
  (setq tab-width 4) ;; change this to taste, this is what K&R uses :)
  (my-build-tab-stop-list tab-width)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil) ;; force only spaces for indentation
  (local-set-key "\C-o" 'ff-get-other-file)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)



;; maximum column number in fill-mode is 60
(setq default-fill-column 60)

;; Generally, to bind a key
;;    1. M-x global-set-key RET 交互式的绑定的键。
;;    2. C-x Esc Esc 调出上一条$A-Y$AN484TSC|An$AN!!#

(global-set-key [f8] 'compile)



;; Match "%" accordingly

(global-set-key "%" 'match-paren)
          
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;; Begin to scroll when there are 3 lines.
(setq scroll-margin 3
      scroll-conservatively 10000)

;;swbuff-y.el, swbuff.el
;;Buffer switching with C-tab/C-S-tab. 
;;You can find swbuff-y.el on EmacsW32 web site. 
;;You also needs swbuff.el which you can find on http://www.EmacsWiki.org/.
(add-to-list 'load-path "/home/zhanxw/emacs/EmacsW32")
(require 'swbuff-y)
(swbuff-y-mode t)

;; Emacs Load Path
(setq load-path (cons "~/emacs" load-path))

;; ansi-color
(load "~/emacs/ansi-color.el")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; ESS 
(add-to-list 'load-path "~/emacs/ess-5.12/lisp")
(require 'ess-site)

; Enable which-func
(which-func-mode)
(add-to-list 'which-func-modes 'ess-mode)
; Modeline format
(setq-default mode-line-format
 '("L%l C%c %b"
   global-mode-string " (" mode-name minor-mode-alist "%n)" 
   (which-func-mode (" " which-func-format ""))))
(require 'r-utils)

;; for switch buffer use
(global-set-key "\C-x\C-b" 'bs-show)    ;; or another key
(global-set-key "\M-p"  'bs-cycle-previous)
(global-set-key "\M-n"  'bs-cycle-next)

;; how to bind keys in Emacs:
;; 1. M-x global-set-key
;; 2. C-Esc Esc  to get previous command
;; 

;; My personal keybindings
;; C-;   change to other window
(global-set-key (quote [67108923]) (quote other-window))
(if window-system
    (windmove-default-keybindings 'meta)
  (progn
    (global-set-key (quote [27 left])  'windmove-left)
    (global-set-key (quote [27 up]) 'windmove-up)
    (global-set-key (quote [27 right]) 'windmove-right)
    (global-set-key (quote [27 down]) 'windmove-down)))
;; C-c c   comment-region
(global-set-key "c" (quote comment-region))
;; C-c u   uncomment-region
(global-set-key "u" (quote uncomment-region))
;; C-c g   goto-line
(global-set-key "g" (quote goto-line))


;; Useful key bindings
;; C-S-Back kill-whole-line
;; C-/ undo
;; C-o open-lien
;; C-M-o split-line

;; from:
;; http://www.plope.com/Members/chrism/flymake-mode
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
		       'flymake-create-temp-inplace)) 
	   (local-file (file-relative-name 
			temp-file 
			(file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file)))) 
  
  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py\\'" flymake-pyflakes-init))) 

(add-hook 'find-file-hook 'flymake-find-file-hook)


;; Try yet-another-snnipet
(add-to-list 'load-path "/home/zhanxw/emacs/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "/home/zhanxw/emacs/yasnippet-0.6.1c/snippets")

;; add smart-compile
(add-to-list 'load-path "/home/zhanxw/emacs")
(require 'smart-compile)

;; start server so we can edit it file under screen
(server-start)
;;(global-hi-lock-mode t)
;;(global-highlight-changes t)

;; indent whole buffer, 
;; invoke by M-x iwb
(defun iwb ()
 "indent whole buffer"
 (interactive)
 (delete-trailing-whitespace)
 (indent-region (point-min) (point-max) nil))

;; load ibuffer 
;; refer to : http://learn.tsinghua.edu.cn:8080/2005211356/stdlib/Ibuffer.html
(require 'ibuffer nil t)
(require 'ibuf-ext nil t)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; load partial-complete
;; refer to : http://learn.tsinghua.edu.cn:8080/2005211356/stdlib/complete.html
(partial-completion-mode 1)

;; load ido-mode
;; refer to : http://learn.tsinghua.edu.cn:8080/2005211356/stdlib/ido.html
;; also refer to the comment part in : http://emacslife.blogspot.com/2008/02/icicles.html 
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point t)
(setq ido-auto-merge-work-directories-length -1)

(require 'recentf)
(setq recentf-max-saved-items 100)
;; from emacs wiki http://www.emacswiki.org/emacs/RecentFiles#toc7
(defun recentf-ido-find-file () 
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key [(meta f11)] 'recentf-ido-find-file)
(global-set-key `[27 f11] 'recentf-ido-find-file)

;; load dna-mode
;; ---Autoload:
;;  (autoload 'dna-mode "dna-mode" "Major mode for dna" t)
;;  (add-to-list 'magic-mode-alist '("^>\\|ID\\|LOCUS\\|DNA" . dna-mode))
;;  (add-to-list
;;     'auto-mode-alist
;;     '("\\.\\(fasta\\|fa\\|exp\\|ace\\|gb\\)\\'" . dna-mode))
;;  (add-hook 'dna-mode-hook 'turn-on-font-lock)
;;
;; ---Load:
;;  (setq dna-do-setup-on-load t)
;;  (load "~/emacs/dna-mode")

(global-set-key (kbd "<f5>") 'speedbar-get-focus)
(global-set-key (quote [S-up]) (quote windmove-up))
(global-set-key (quote [S-down]) (quote windmove-down))
(global-set-key (quote [S-left]) (quote windmove-left))
(global-set-key (quote [S-right]) (quote windmove-right))

;; for convenient collapsing and expanding region
(require 'hideshow nil t)
(when (featurep 'hideshow)
  (dolist (hook '(c++-mode-hook c-mode-hook emacs-lisp-mode-hook
                                cperl-mode-hook))
    (add-hook hook 'hs-minor-mode)))
(global-set-key "t" (quote hs-toggle-hiding))

;; set TAGS directory
(setq tags-table-list '("." ".." "../.."))

;; set up ^C-o a prefix for outline mode
;; useful commands:
;; 1.  hide-sublevels (C-o C-q)
;;     show-all (C-o C-a) 
;; 2.  hide-subtree (C-o C-d)
;;     hide-other (C-o C-o) 
;;     show-subtree (C-o C-s)
;;  
(setq outline-minor-mode-prefix [(control o)])

;; try hippie expand
;; refer to: http://lifegoo.pluskid.org/wiki/EmacsTip.html
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev                 ; .... buffer
        try-expand-dabbrev-visible         ; ........
        try-expand-dabbrev-all-buffers     ; .... buffer
        try-expand-dabbrev-from-kill       ; . kill-ring ...
        try-complete-file-name-partially   ; .......
        try-complete-file-name             ; .....
        try-expand-all-abbrevs             ; .......
        try-expand-list                    ; ......
        try-expand-line                    ; .....
        try-complete-lisp-symbol-partially ; .... elisp symbol
        try-complete-lisp-symbol))         ; .. lisp symbol


;; Completing numeric or algebraic expressions (using Calc (aka AdvancedDeskCalculator) and HippieExpand)
;; refer to: http://www.emacswiki.org/cgi-bin/wiki/MicheleBini
(defun my-try-complete-with-calc-result (arg)
  (and
   (not arg) (eolp)
   (save-excursion
     (beginning-of-line)
     (when (and (boundp 'comment-start)
		comment-start)
       (when (looking-at
	      (concat
	       "[ \n\t]*"
	       (regexp-quote comment-start)))
	 (goto-char (match-end 0))
	 (when (looking-at "[^\n\t ]+")
	   (goto-char (match-end 0)))))
     (looking-at ".* \\(\\([;=]\\) +$\\)"))
   (save-match-data
     (require 'calc-ext nil t))
   ;;(require 'calc-aent)
   (let ((start (match-beginning 0))
	 (op (match-string-no-properties 2)))
     (save-excursion
       (goto-char (match-beginning 1))
       (if (re-search-backward (concat "[\n" op "]") start t)
	   (goto-char (match-end 0)) (goto-char start))
       (looking-at (concat " *\\(.*[^ ]\\) +" op "\\( +\\)$"))
       (goto-char (match-end 2))
       (let* ((b (match-beginning 2))
	      (e (match-end 2))
	      (a (match-string-no-properties 1))
	      (r (calc-do-calc-eval a nil nil)))
	 (when (string-equal a r)
	   (let ((b (save-excursion
		      (and (search-backward "\n\n" nil t)
			   (match-end 0))))
		 (p (current-buffer))
		 (pos start)
		 (s nil))
	     (setq r
		   (calc-do-calc-eval
		    (with-temp-buffer
		      (insert a)
		      (goto-char (point-min))
		      (while (re-search-forward
			      "[^0-9():!^ \t-][^():!^ \t]*" nil t)
			(setq s (match-string-no-properties 0))
			(let ((r
			       (save-match-data
				 (save-excursion
				   (set-buffer p)
				   (goto-char pos)
				   (and
				    ;; TODO: support for line
				    ;; indentation
				    (re-search-backward
				     (concat "^" (regexp-quote s)
					     " =")
				     b t)
				    (progn
				      (end-of-line)
				      (search-backward "=" nil t)
				      (and (looking-at "=\\(.*\\)$")
					   (match-string-no-properties 1))))))))
			  (if r (replace-match (concat "(" r ")") t t))))
		      (buffer-substring (point-min) (point-max)))
		    nil nil))))
	 (and
	  r
	  (progn
	    (he-init-string b e)
	    (he-substitute-string (concat " " r))
	    t)))))))
(setq hippie-expand-try-functions-list
      (cons
       'my-try-complete-with-calc-result
       (delq 'my-try-complete-with-calc-result
	     hippie-expand-try-functions-list)))

;; deal with buffers with the same name
;; now will preced a directory name before actual file names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; auctex setting:
(add-to-list 'load-path "~/emacs/auctex-11.85/lisp")
(load "~/emacs/auctex-11.85/lisp/auctex.el" nil t t)
(load "~/emacs/auctex-11.85/lisp/preview-latex.el" nil t t)

(require 'tex-site)
(require 'tex)
(add-to-list 'TeX-command-list
             (list "dvipdfmx" "dvipdfmx %s.dvi" 'TeX-run-command nil t))

;;
;; from http://www.io.com/~jimm/emacs_tips.html#abbrev-mode
(define-key global-map [f9] 'bookmark-jump)
(define-key global-map [f10] 'bookmark-set)
(defalias 'bs 'bookmark-set)
(defalias 'bl 'bookmark-bmenu-list)
(setq bookmark-save-flag 1); How many mods between saves

;; manage bookmark
;; from http://emacsblog.org/2007/03/22/bookmark-mania/
(setq bm-restore-repository-on-load t)
(require 'bm)
(global-set-key `[27 f2] `bm-toggle)
(global-set-key `[f2] 'bm-next)
(global-set-key `[f12] 'bm-previous) ;; [f12] is Shift+F2
 
;; make bookmarks persistent as default
(setq-default bm-buffer-persistence t)
 
;; Loading the repository from file when on start up.
(add-hook' after-init-hook 'bm-repository-load)
 
;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)
 
;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)
 
;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))


;; Use C-x a g to define a global abbreviation
;; and C-x a l to define an abbreviation that is
;; specific to the current major mode.
;(setq abbrev-file-name ("/GNU Emacs/abbrev_defs.el"))
;(read-abbrev-file abbrev-file-name t)
(setq dabbrev-case-replace nil)  ; Preserve case when expanding
(setq abbrev-mode t)


;; from:
;; http://sachachua.com/wp/2008/07/27/emacs-keyboard-shortcuts-for-navigating-code/
;; Type C-s (isearch-forward) to start interactively searching forward,
;; and type C-x to get the current word. Use C-s and C-r to search forward
;; and backward. You can modify your search, too.
(defun sacha/isearch-yank-current-word ()
  "Pull current word from buffer into search string."
  (interactive)
  (save-excursion
    (skip-syntax-backward "w_")
    (isearch-yank-internal
     (lambda ()
       (skip-syntax-forward "w_")
       (point)))))
(define-key isearch-mode-map (kbd "C-x") 'sacha/isearch-yank-current-word)


;; In every buffer, the line which contains the cursor will be fully
;; highlighted
(global-hl-line-mode 1)


(require 'ido)
(ido-mode t)

;; M-g g is the default goto-line
;; (global-set-key "\C-cl" 'goto-line)

(defun my-kill-whole-line ()
  "Kill an entire line, including trailing newline"
  (interactive)
  (beginning-of-line)
  (kill-line 1))


(defun tweakemacs-move-one-line-downward ()
  "Move current line downward once."
  (interactive)
  (forward-line)
  (transpose-lines 1)
  (forward-line -1))
(defun tweakemacs-move-one-line-upward ()
  "Move current line upward once."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))
(global-set-key (quote [C-M-up]) 'tweakemacs-move-one-line-upward)
(global-set-key (quote [C-M-down]) 'tweakemacs-move-one-line-downward)


;; easy binding for emacs
;; outline-mode-easy-bindings.el
;;
;; You can control outline entirely with Meta+<cursor> keys
;;
;; Store this file as outline-mode-easy-bindings.el somewhere in your
;; load-path and add the following lines to your init file:
;;
;;      (add-hook 'outline-mode-hook
;;                '(lambda ()
;;                   (require 'outline-mode-easy-bindings)))
;;
;;      (add-hook 'outline-minor-mode-hook
;;                '(lambda ()
;;                   (require 'outline-mode-easy-bindings)))

(defun outline-body-p ()
  (save-excursion
    (outline-back-to-heading)
    (outline-end-of-heading)
    (and (not (eobp))
         (progn (forward-char 1)
                (not (outline-on-heading-p))))))

(defun outline-body-visible-p ()
  (save-excursion
    (outline-back-to-heading)
    (outline-end-of-heading)
    (not (outline-invisible-p))))

(defun outline-subheadings-p ()
  (save-excursion
    (outline-back-to-heading)
    (let ((level (funcall outline-level)))
      (outline-next-heading)
      (and (not (eobp))
           (< level (funcall outline-level))))))

(defun outline-subheadings-visible-p ()
  (interactive)
  (save-excursion
    (outline-next-heading)
    (not (outline-invisible-p))))

(defun outline-do-close ()
  (interactive)
  (if (outline-on-heading-p)
      (cond ((and (outline-body-p)
                  (outline-body-visible-p))
             (hide-entry)
             (hide-leaves))
            (t
             (hide-subtree)))))

(defun outline-do-open ()
  (interactive)
  (if (outline-on-heading-p)
      (cond ((and (outline-subheadings-p)
                  (not (outline-subheadings-visible-p)))
             (show-children))
            ((and (not (outline-subheadings-p))
                  (not (outline-body-visible-p)))
             (show-subtree))
            ((and (outline-body-p)
                  (not (outline-body-visible-p)))
             (show-entry))
            (t
             (show-subtree)))))

(outline-minor-mode t)
(define-key outline-mode-map (kbd "M-<left>") 'outline-do-close)
(define-key outline-mode-map (kbd "M-<right>") 'outline-do-open)
(define-key outline-mode-map (kbd "M-<up>") 'outline-previous-visible-heading)
(define-key outline-mode-map (kbd "M-<down>") 'outline-next-visible-heading)


(define-key outline-minor-mode-map (kbd "M-<left>") 'outline-do-close)
(define-key outline-minor-mode-map (kbd "M-<right>") 'outline-do-open)
(define-key outline-minor-mode-map (kbd "M-<up>") 'outline-previous-visible-heading)
(define-key outline-minor-mode-map (kbd "M-<down>") 'outline-next-visible-heading)

(provide 'outline-mode-easy-bindings)

;; Make M-w do more intelligently. If region is active, behave like normal. Otherwise, do the following:
;; M-w copy url, email or current line, in that order
;; M-w followed by key f, l, s or w, copy filename, list, sexp and word, respectively
;; with numeric prefix, copy that many thing-at-point
;; from: http://www.emacswiki.org/emacs/Leo
;;; Copy thing-at-point intelligently
(defun sdl-kill-ring-save-thing-at-point (&optional n)
  "Save THING at point to kill-ring."
  (interactive "p")
  (let ((things '((?l . list) (?f . filename) (?w . word) (?s . sexp)))
        (message-log-max)               ; don't write to *Message*
        beg t-a-p thing event)
    (flet ((get-thing ()
                      (save-excursion
                        (beginning-of-thing thing)
                        (setq beg (point))
                        (if (= n 1)
                            (end-of-thing thing)
                          (forward-thing thing n))
                        (buffer-substring beg (point)))))
      ;; try detecting url email and fall back to 'line'
      (dolist (thing '(url email line))
        (when (bounds-of-thing-at-point thing)
          (setq t-a-p (get-thing))
          ;; remove the last newline character
          (when (and (eq thing 'line)
                     (>= (length t-a-p) 1)
                     (equal (substring t-a-p -1) "\n"))
            (setq t-a-p (substring t-a-p 0 -1)))
          (kill-new t-a-p)
          (message "%s" t-a-p)
          (return nil)))
      (setq event (read-event nil))
      (when (setq thing (cdr (assoc event things)))
        (clear-this-command-keys t)
        (if (not (bounds-of-thing-at-point thing))
            (message "No %s at point" thing)
          (setq t-a-p (get-thing))
          (kill-new t-a-p 'replace)
          (message "%s" t-a-p))
        (setq last-input-event nil))
      (when last-input-event
        (clear-this-command-keys t)
        (setq unread-command-events (list last-input-event))))))

(defun sdl-kill-ring-save-dwim ()
  "This command dwim on saving text.

If region is active, call `kill-ring-save'. Else, call
`sdl-kill-ring-save-thing-at-point'.

This command is to be used interactively."
  (interactive)
  (condition-case e
      (when (mark)
        (call-interactively 'kill-ring-save))
    ;; handler
    ('mark-inactive
     (call-interactively 'sdl-kill-ring-save-thing-at-point)))
  )

(global-set-key (kbd "M-w") 'sdl-kill-ring-save-dwim)

;; add redo mode
;; from: http://www.emacswiki.org/cgi-bin/wiki/RedoMode
(require 'redo)
(define-key global-map (kbd "C-x C-_") 'redo)

;; highlight parens
(defun hl-paren-highlight ()
  "Highlight the parentheses around point."
  (unless (= (point) hl-paren-last-point)
    (save-excursion
      (let ((pos (point))
            (match-pos (point))
            (level -1)
            (max (1- (length hl-paren-overlays))))
        (while (and match-pos (< level max))
          (setq match-pos
                (when (setq pos (cadr (syntax-ppss pos)))
                  (ignore-errors (scan-sexps pos 1))))
          (when match-pos
            (if (eq 'expression hl-paren-type)
                (hl-paren-put-overlay pos match-pos (incf level))
              (hl-paren-put-overlay pos (1+ pos) (incf level))
              (hl-paren-put-overlay (1- match-pos) match-pos 
                (incf level)))
            ))
        (while (< level max)
          (hl-paren-put-overlay nil nil (incf level)))))
    (setq hl-paren-last-point (point))))

;; set up "tabbar"
;; from http://amitp.blogspot.com/2007/04/emacs-buffer-tabs.html
(require 'tabbar)
(set-face-attribute
 'tabbar-default-face nil
 :background "gray60")
(set-face-attribute
 'tabbar-unselected-face nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected-face nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button-face nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator-face nil
 :height 0.7)

(tabbar-mode 1)

;; customize shell-mode
;;; Shell mode
;; From Amit's blog
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; icicles
;; We temporarily not use it, since in text terminal,
;; icicles prompts are too messy
;; (add-to-list 'load-path "~/emacs/icicles")
;; (require 'icicles)


;; From http://infolab.stanford.edu/~manku/dotemacs.html
;; Removing Annoyances
;; will inhibit startup messages.
(setq inhibit-startup-message t)
;; will make the last line end in a carriage return.
(setq require-final-newline t) 
;;  will allow you to type just "y" instead of "yes" when you exit.
(fset 'yes-or-no-p 'y-or-n-p)
;; will disallow creation of new lines when you press 
;; the "arrow-down key" at end of the buffer. 
(setq next-line-add-newlines nil)

;; General Embellishments
;; load auto-show (shows lines when cursor moves to right of long line).
;;(require 'auto-show) (auto-show-mode 1) (setq-default auto-show-mode t) 
;; will position the cursor to end of output in shell mode.
;;(auto-show-make-point-visible)
;; will position cursor to end of output in shell mode automatically.
;;(auto-show-make-point-visible)
;; will highlight region between point and mark. 
(transient-mark-mode t)
;;  denotes our interest in maximum possible fontification. 
(setq font-lock-maximum-decoration t)

;; will highlight during query.
(setq query-replace-highlight t)
;; highlight incremental search
(setq search-highlight t)
;; will make text-mode default. 
(setq default-major-mode 'text-mode)

;; get intermittent messages to stop typing 
;; (type-break-mode)


(setq enable-recursive-minibuffers t) ;; allow recursive editing in minibuffer
;; (resize-minibuffer-mode 1)            ;; minibuffer gets resized if it becomes too big
(follow-mode t)                       ;; follow-mode allows easier editing of long files 

(cond
 ((display-graphic-p)
  (set-foreground-color "blanched almond") 
  (set-background-color "dark slate gray"))
)

;;gud-mode (debugging with gdb)
(add-hook 'gud-mode-hook
	  '(lambda ()
             (local-set-key [home]        ; move to beginning of line, after prompt
                            'comint-bol)
	     (local-set-key [up]          ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
	     (local-set-key [down]        ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             ))

;; shell-toggle.el stuff

(autoload 'shell-toggle "shell-toggle" 
  "Toggles between the *shell* buffer and whatever buffer you are editing." t) 
(autoload 'shell-toggle-cd "shell-toggle" 
  "Pops up a shell-buffer and insert a \"cd \" command." t)
(global-set-key [f4] 'shell-toggle)
(global-set-key [C-f4] 'shell-toggle-cd)


;; pager.el stuff
(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next]     'pager-page-down)
(global-set-key "\ev"      'pager-page-up)
(global-set-key [prior]    'pager-page-up)
(global-set-key '[M-up]    'pager-row-up)
(global-set-key '[M-kp-8]  'pager-row-up)
(global-set-key '[M-down]  'pager-row-down)
(global-set-key '[M-kp-2]  'pager-row-down)

;; This is a way to hook tempo into cc-mode
(defvar c-tempo-tags nil
  "Tempo tags for C mode")
(defvar c++-tempo-tags nil
  "Tempo tags for C++ mode")

;;; C-Mode Templates and C++-Mode Templates (uses C-Mode Templates also)
(require 'tempo)
(setq tempo-interactive t)

(add-hook 'c-mode-hook
          '(lambda ()
             (local-set-key [f11] 'tempo-complete-tag)
             (tempo-use-tag-list 'c-tempo-tags)
             ))
(add-hook 'c++-mode-hook
          '(lambda ()
             (local-set-key [f11] 'tempo-complete-tag)
             (tempo-use-tag-list 'c-tempo-tags)
             (tempo-use-tag-list 'c++-tempo-tags)
             ))

;;; Preprocessor Templates (appended to c-tempo-tags)

(tempo-define-template "c-include"
		       '("include <" r ".h>" > n
			 )
		       "include"
		       "Insert a #include <> statement"
		       'c-tempo-tags)

(tempo-define-template "c-ifdef"
		       '("ifdef " (p "ifdef-clause: " clause) > n> p n
			 "#else /* !(" (s clause) ") */" n> p n
			 "#endif /* " (s clause)" */" n>
			 )
		       "ifdef"
		       "Insert a #ifdef #else #endif statement"
		       'c-tempo-tags)

(tempo-define-template "c-ifndef"
		       '("ifndef " (p "ifndef-clause: " clause) > n
			 "#define " (s clause) n> p n
			 "#endif /* " (s clause)" */" n>
			 )
		       "ifndef"
		       "Insert a #ifndef #define #endif statement"
		       'c-tempo-tags)
;;; C-Mode Templates

(tempo-define-template "c-if"
		       '(> "if (" (p "if-clause: " clause) ")" n>
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "if"
		       "Insert a C if statement"
		       'c-tempo-tags)

(tempo-define-template "c-else"
		       '(> "else" n>
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "else"
		       "Insert a C else statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-else"
		       '(> "if (" (p "if-clause: " clause) ")"  n>
                           "{" > n
                           > r n
                           "}" > n
                           "else" > n
                           "{" > n>
                           > r n
                           "}" > n>
                           )
		       "ifelse"
		       "Insert a C if else statement"
		       'c-tempo-tags)

(tempo-define-template "c-while"
		       '(> "while (" (p "while-clause: " clause) ")" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "while"
		       "Insert a C while statement"
		       'c-tempo-tags)

(tempo-define-template "c-for"
		       '(> "for (" (p "for-clause: " clause) ")" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "for"
		       "Insert a C for statement"
		       'c-tempo-tags)

(tempo-define-template "c-for-i"
		       '(> "for (" (p "variable: " var) " = 0; " (s var)
                           " < "(p "upper bound: " ub)"; " (s var) "++)" >  n>
                           "{" > n
                           > r n
                           "}" > n>
                           )
		       "fori"
		       "Insert a C for loop: for(x = 0; x < ..; x++)"
		       'c-tempo-tags)

(tempo-define-template "c-main"
		       '(> "int main(int argc, char *argv[])" >  n>
                           "{" > n>
                           > r n
                           > "return 0 ;" n>
                           > "}" > n>
                           )
		       "main"
		       "Insert a C main statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-malloc"
		       '(> (p "variable: " var) " = ("
                           (p "type: " type) " *) malloc (sizeof(" (s type)
                           ") * " (p "nitems: " nitems) ") ;" n>
                           > "if (" (s var) " == NULL)" n>
                           > "error_exit (\"" (buffer-name) ": " r ": Failed to malloc() " (s var) " \") ;" n>
                           )
		       "ifmalloc"
		       "Insert a C if (malloc...) statement"
		       'c-tempo-tags)

(tempo-define-template "c-if-calloc"
		       '(> (p "variable: " var) " = ("
                           (p "type: " type) " *) calloc (sizeof(" (s type)
                           "), " (p "nitems: " nitems) ") ;" n>
                           > "if (" (s var) " == NULL)" n>
                           > "error_exit (\"" (buffer-name) ": " r ": Failed to calloc() " (s var) " \") ;" n>
                           )
		       "ifcalloc"
		       "Insert a C if (calloc...) statement"
		       'c-tempo-tags)

(tempo-define-template "c-switch"
		       '(> "switch (" (p "switch-condition: " clause) ")" n>
                           "{" >  n>
                           "case " (p "first value: ") ":" > n> p n
                           "break;" > n> p n
                           "default:" > n> p n
                           "break;" > n
                           "}" > n>
                           )
		       "switch"
		       "Insert a C switch statement"
		       'c-tempo-tags)

(tempo-define-template "c-case"
		       '(n "case " (p "value: ") ":" > n> p n
			   "break;" > n> p
			   )
		       "case"
		       "Insert a C case statement"
		       'c-tempo-tags)

(tempo-define-template "c++-class"
		       '("class " (p "classname: " class) p > n>
                         " {" > n
                         "public:" > n
                         "" > n
			 "protected:" > n
                         "" > n
			 "private:" > n
                         "" > n
			 "};" > n
			 )
		       "class"
		       "Insert a class skeleton"
		       'c++-tempo-tags)


;;Startup
(split-window-vertically)   ;; want two windows at startup 
(other-window 1)              ;; move to other window
(shell)                       ;; start a shell
(rename-buffer "shell-first") ;; rename it
(other-window 1)              ;; move back to first window 
;; (my-key-swap my-key-pairs)    ;; zap keyboard

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(max-specpdl-size 3200))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "black")))))

(setq mac-command-key-is-meta t)

;; git 
(add-to-list 'load-path "/home/zhanxw/emacs/git")
(require 'git)
(require 'git-blame)

(add-to-list 'load-path "/home/zhanxw/emacs/magit/share/emacs/site-lisp")
(require 'magit)

;; gtags 
;; from http://www.newsmth.net/bbscon.php?bid=573&id=84691&ftype=3&num=1557
(add-to-list 'load-path "/home/zhanxw/emacs/global-5.8.2/share/gtags")
(autoload 'gtags-mode "gtags" "" t)

(add-hook 'c-mode-hook
      '(lambda ()
        (gtags-mode 1)))

(add-hook 'c++-mode-hook
      '(lambda ()
        (gtags-mode 1)))

(add-hook 'asm-mode-hook
      '(lambda ()
        (gtags-mode 1)))

;; from http://emacs-fu.blogspot.com/2009/01/navigating-through-source-code-using.html
(defun gtags-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
    (let ((olddir default-directory)
          (topdir (read-directory-name  
                    "gtags: top of source tree:" default-directory)))
      (cd topdir)
      (shell-command "gtags && echo 'created tagfile'")
      (cd olddir)) ; restore   
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))

;; from: http://www.emacswiki.org/emacs/CyclingGTagsResult
(defun ww-next-gtag ()
  "Find next matching tag, for GTAGS."
  (interactive)
  (let ((latest-gtags-buffer
         (car (delq nil  (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
                                 (buffer-list)) ))))
    (cond (latest-gtags-buffer
           (switch-to-buffer latest-gtags-buffer)
           (next-line)
           (gtags-select-it nil))
          ) ))

;; convenient setting
(gtags-mode 1)
(global-set-key "\M-;" 'ww-next-gtag)   ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,
(global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
(global-set-key [(control meta .)] 'gtags-find-rtag)   ;; C-M-. find all references of tag
(global-set-key [(control meta ,)] 'gtags-find-symbol) ;; C-M-, find all usages of symbol.
(define-key gtags-mode-map "\e," 'gtags-find-tag-from-here) 

;; M-x occur or M-x so => find occurance of word
;; M-x rgrep: recursively (including subdirectory) grep
;; M-x lgrep: local directory grep

;; from: http://sachachua.com/wp/2008/09/emacs-jump-to-anything/
(require 'anything)
(require 'anything-config)
(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-file-name-history
            anything-c-source-info-pages
            anything-c-source-man-pages
	        anything-c-source-file-cache
            anything-c-source-emacs-commands))
(global-set-key (kbd "M-X") 'anything)

;; from http://www.gnu.org/software/idutils/manual/idutils.html#Emacs-gid-interface
(autoload 'gid "gid" nil t)

(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist
			      '(("\\.cflow$" . cflow-mode))))

;; Pymacs + Ropemacs

;; Ropemacs
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-") ; note this line will make 'M-x help' function disabled
;; so we use hook function as below
(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  ;(setenv "PYMACS_PYTHON" "python2.5") ; disabled for now
  (require 'python-mode)
  (require 'pymacs)
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  ;; (eval-after-load "pymacs"
  ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
  (pymacs-load "ropemacs" "rope-")
  (setq rope-confirm-saving 'nil)
  (ropemacs-mode t)
  (local-set-key [(meta ?/)] 'rope-code-assist) ;; avoid rope start for C++ file
  )

(add-hook 'python-mode-hook 'load-ropemacs)


;; ;; how to debug max-specpdl-size-errors?
;; ;; http://stackoverflow.com/questions/1322591/tracking-down-max-specpdl-size-errors-in-emacs
;; (setq max-specpdl-size 5)  ; default is 1000, reduce the backtrace level
;; (setq debug-on-error t)    ; now you should get a backtrace
;; ; now do something to repeat the bug

(setq load-path (cons "/home/zhanxw/emacs/org-6.36c/lisp" load-path))
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
;; add from tutorial http://orgmode.org/worg/org-tutorials/orgtutorial_dto.php
(setq org-log-done t)

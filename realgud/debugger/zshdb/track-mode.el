;;; Copyright (C) 2012, 2014-2015 Rocky Bernstein <rocky@gnu.org>
;;; "zshdb" Debugger tracking a comint buffer.

(eval-when-compile (require 'cl))
(require 'load-relative)
(require-relative-list '(
			 "../../common/cmds"
			 "../../common/menu"
			 "../../common/track"
			 "../../common/track-mode"
			 )
		       "realgud-")
(require-relative-list '("core" "init") "realgud:zshdb-")
(require-relative "../../lang/posix-shell" nil "realgud-lang-")

(declare-function realgud:cmd-remap          'realgud-cmds)
(declare-function realgud:track-set-debugger 'realgud-track-mode)
(declare-function realgud-track-mode-setup   'realgud-track-mode)
(declare-function realgud-posix-shell-populate-command-keys
		  'realgud-lang-posix-shell)

(realgud-track-mode-vars "zshdb")
(realgud-posix-shell-populate-command-keys zshdb-track-mode-map)

(declare-function realgud-track-mode(bool))


(defun zshdb-track-mode-hook()
  (if zshdb-track-mode
      (progn
	(use-local-map zshdb-track-mode-map)
	(message "using zshdb mode map")
	)
    (message "zshdb track-mode-hook disable called"))
)

(define-minor-mode zshdb-track-mode
  "Minor mode for tracking zshdb source locations inside a process shell via realgud. zshdb is a zsh debugger.

If called interactively with no prefix argument, the mode is toggled. A prefix argument, captured as ARG, enables the mode if the argument is positive, and disables it otherwise.

\\{zshdb-track-mode-map}
"
  :init-value nil
  ;; :lighter " zshdb"   ;; mode-line indicator from realgud-track is sufficient.
  ;; The minor mode bindings.
  :global nil
  :group 'realgud:zshdb
  :keymap zshdb-track-mode-map

  (realgud:track-set-debugger "zshdb")
  (if zshdb-track-mode
      (progn
	(realgud-track-mode-setup 't)
        (zshdb-track-mode-hook))
    (progn
      (setq realgud-track-mode nil)
      ))
)

(define-key zshdb-short-key-mode-map "T" 'realgud:cmd-backtrace)

(provide-me "realgud:zshdb-")

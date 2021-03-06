(require 'test-simple)
(load-file "../realgud.el")

(declare-function realgud:loaded-features    'realgud)
(declare-function realgud:unload-features    'realgud-regexp)
(declare-function __FILE__                   'load-relative)

(test-simple-start)

(eval-when-compile
  (defvar test-realgud:features)
)

(note "realgud")

(note "realgud:loaded-features")
(set (make-local-variable 'test-realgud:features) (realgud:loaded-features))
;; (dolist (feature '(realgud-trepan realgud-pydbgr
;; 			       realgud-core))
;;   (assert-t (not (not (member feature test-realgud:features)))) )

(note "realgud-unload-features")
(load-file "../realgud.el")
(assert-nil (not (realgud:loaded-features)))
(assert-nil (not (realgud:unload-features)))
(realgud:loaded-features)

(end-tests)

(require "data-base" "db.lisp")
(require "server" "server.lisp")

(defpackage db-server
  (:nicknames :db-sv)
  (:use :db :sv :cl))
(in-package db-server)

(defun handler (socket-stream)
    (let ((ret (eval (read socket-stream))))
      (with-standard-io-syntax
        (print ret socket-stream))))

;(defun handler (socket-stream)
;  (let ((command (read socket-stream)))
;    (format t "~a~%" command)
;    (force-output t)
;    (let ((ret (eval command)))
;      (with-standard-io-syntax
;        (print ret socket-stream)))))

(start-server #'handler)

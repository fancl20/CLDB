(require "data-base" "db.lisp")
(require "server" "server.lisp")
(require "log" "log.lisp")

(defpackage db-server
  (:nicknames :db-sv)
  (:use :db :sv :cl :lg))
(in-package db-server)

(defun handler (socket-stream)
  (let ((ret (eval (read socket-stream))))
    (with-standard-io-syntax
      (print ret socket-stream))))

(defun debug-handler (socket-stream)
  (let ((command (read socket-stream)))
    (format t "~a~%" command)
    (force-output t)
    (let ((ret (eval command)))
      (with-standard-io-syntax
        (print ret socket-stream)))))

(defun log-handler (socket-stream)
  (let ((command (read socket-stream))
        (logger (get-logger "log.txt")))
    (funcall logger command)
    (let ((ret (eval command)))
      (with-standard-io-syntax
        (print ret socket-stream)))))

(start-server #'log-handler)

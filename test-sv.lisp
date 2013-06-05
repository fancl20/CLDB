(require "server" "server.lisp")
(in-package :sv)

(defun echo (socket-stream)
  (let ((str (read-line socket-stream)))
  (format t "~A~%" str)
  (format socket-stream "OK~%")))
(start-server #'echo)

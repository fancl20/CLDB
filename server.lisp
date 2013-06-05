(require :sb-bsd-sockets)
(defpackage socket-server
  (:use :sb-bsd-sockets :cl)
  (:nicknames :sv)
  (:export start-server))
(in-package socket-server)

(defun start-server (handler-func)
  (let ((server (make-instance 'inet-socket
                               :type :stream
                               :protocol :tcp)))
    (socket-bind server #(127 0 0 1) 8000)
    (socket-listen server 5)
    (loop
      (let ((socket-stream (socket-make-stream
                             (socket-accept server)
                             :output t :input t)))
        (funcall handler-func socket-stream)
        (close socket-stream)))))

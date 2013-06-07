(defpackage logging
  (:use :cl)
  (:nicknames :lg)
  (:export get-logger))
(in-package logging)
(defun get-logger (filename)
  (lambda (message)
    (with-open-file (out filename
                         :direction :output
                         :if-exists :append)
      (with-standard-io-syntax
        (print message out))
      (format out "~%"))))


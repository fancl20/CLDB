(defpackage data-base
  (:use :cl)
  (:nicknames :db)
  (:export create insert select update erase
           show dump
           save-db load-db
           get-value))
(in-package data-base)

(defvar *db* ())
(defmacro get-value (key alist)
  `(cadr (assoc ,key ,alist)))

(defun create (name column)
  (push (list name (list column ())) *db*))

(defun into (table-name)
  (get-value table-name *db*))
(defun insert (table value)
  (let ((name (car table)))
    (push
      (loop for i in name
            for j = value
            then (cdr j)
            collect (list i (car j)))
      (cadr table))))

(defun from (table-name)
  (into table-name))
(defun select (table selector)
  (let ((data (cadr table)))
    (remove-if-not selector data)))
(defmacro where (&rest clauses)
  (labels ((make-comparisons-expr (field value)
             `(equal (get-value ,field obj) ,value))
           (make-comparisons-list (fields)
             (loop while fields
                   collect (make-comparisons-expr
                             (pop fields) (pop fields)))))
    `#'(lambda (obj) (and ,@(make-comparisons-list clauses)))))

(defmacro upd-set (key val)
  `#'(lambda (obj)
       (setf (get-value ,key obj) ,val)))
(defmacro upd-push (key val)
  `#'(lambda (obj)
       (push ,val (get-value ,key obj))))
(defmacro upd-pull (key val)
  (let ((key-name (gensym)))
    `#'(lambda (obj)
         (let ((,key-name ,key))
           (setf (get-value ,key-name obj)
                 (delete ,val (get-value ,key-name obj)))))))
(defun update (table selector &rest upd)
  (let ((data (cadr table)))
    (loop for obj in data do
          (when (funcall selector obj)
            (loop for updater in upd do
                  (funcall updater obj))))))

(defun erase (table selector)
  (setf (cadr table)
        (let ((data (cadr table)))
          (remove-if selector data))))

(defun show (data)
  (format nil "~{~{~{~a~^: ~15t~}~%~}~%~}" data))
(defun dump (table)
  (let ((data (cadr table)))
    (show data)))

(defun save-db (filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))
(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))


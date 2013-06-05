(require "data-base" "work/db.lisp")
(require "server" "work/server.lisp")

(defpackage library
  (:use :db :sv :cl))

(in-package library)

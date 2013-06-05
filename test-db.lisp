(require "data-base" "db.lisp")
(in-package data-base)

(create :Book
        (list :ISBN
              :Title
              :Author
              :Publisher
              :Description
              :Bought-Time
              :Amount))

(insert (into :book) (list 1 "so sad" "xf" "f" "hehe" 10))
(insert (into :book) (list 2 "so sad" "xf" "f" "hehe" 10 100))

;(print (select (from :book) (where :title "so sad" :isbn 1)))

;(update (from :book) (where :isbn 1) :isbn 4)
;(print (select (from :book) (where :title "so sad")))

;(erase (from :book) (where :Amount 100))

;(format t "~A" (dump (from :book)))
(format t "~A" (show (select (from :book) (where :title "so sad"))))

;(save-db "data.txt")
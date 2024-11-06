#lang racket

(require "tablero-size.rkt")

(provide POSN-LIST)
(provide COORDS-LIST)
(provide (struct-out posn))
(provide TABLERO-SIZE)

(define-struct posn [x y])

(if (not (system (string-append "knight-tour.exe " (number->string TABLERO-SIZE)))) (error "Cannot open knight-tour.exe, try recompiling knight-tour-solver.cpp") #true)

(define (list->posn l) (make-posn (first l) (first (rest l)) ))

(define COORDS-LIST (file->list "knight-tour.txt"))

(define POSN-LIST (map list->posn COORDS-LIST))
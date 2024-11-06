#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require images/flomap)
(require "file-reading.rkt")

;;(define-struct posn [x y])

(provide gen-tablero)
(provide place-knight)

(define KNIGHT (bitmap "transparent-knight.png"))
(define KNIGHT-SCALE-FACTOR (expt TABLERO-SIZE (/ 3 -2)))

KNIGHT-SCALE-FACTOR

(set! KNIGHT (scale KNIGHT-SCALE-FACTOR KNIGHT))

(define CELDA-ANCHO (image-height KNIGHT))
(define CELDA-MARGEN (* 10 (expt (log TABLERO-SIZE 10) 0.5)))
(define CELDA (square (+ CELDA-ANCHO CELDA-MARGEN) "outline" "black"))
(define CELDA-VISITADA (frame (square (+ CELDA-ANCHO CELDA-MARGEN) "solid" "gray")))

(define (gen-fila w) (cond [(not (integer? w)) (error "The size must be an integer")]
                           [(negative? w) (error "Negative size")]
                           [(zero? w) empty-image]
                           [(= w 1) CELDA]
                           [else (overlay/xy CELDA (image-width CELDA) 0 (gen-fila (sub1 w)))]))


(define (gen-tablero w h) (cond [(zero? h) empty-image]
                              [else (overlay/xy (gen-fila w) 0 (image-height CELDA) (gen-tablero w (sub1 h)))]))

;(define TABLERO-SIZE 8)
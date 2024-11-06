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

(define TABLERO (gen-tablero TABLERO-SIZE TABLERO-SIZE))
(define TABLERO-MARGEN 0)
(set! TABLERO (overlay/xy TABLERO 0 0 (rectangle (+ (image-width TABLERO) TABLERO-MARGEN) (+ (image-height TABLERO) TABLERO-MARGEN) "solid" "white")))

(define (place-image/posn img pt bg) (place-image img (posn-x pt) (posn-y pt) bg))

(define (get-knight-coords x [y 0]) (cond [(posn? x) (get-knight-coords (posn-x x) (posn-y x))]
                                      [else (make-posn (* (/ (+ (* 2 x) 1) 2) (image-width CELDA)) (* (/ (+ (* 2 y) 1) 2) (image-height CELDA)))]))

(define (place-knight x y bg) (place-image/posn KNIGHT (get-knight-coords (sub1 x) (sub1 y)) bg))
(define (place-knight/posn p bg) (place-knight (posn-x p) (posn-y p) bg))

;; INTERACTIVIDAD

(define FRAME_DELAY 0.5)

(define-struct estado [posn-lista tablero])

(define (escena s) (place-knight/posn (first (estado-posn-lista s)) (estado-tablero s)))

(define (sub1posn p) (make-posn (sub1 (posn-x p)) (sub1 (posn-y p))))

(define (mover s) (let
                      ([l (estado-posn-lista s)] [tablero (estado-tablero s)])
                      (make-estado (rest l)
                                   (let*
                                       ([knight-posn (get-knight-coords (sub1posn (first l)))] [knight-next-posn (if (empty? (rest l)) knight-posn (get-knight-coords (sub1posn(first (rest l)))))])
                                       (place-image (circle (/ (image-width CELDA) 8) "solid" (if (= (length l) (length POSN-LIST)) "blue" "red"))
                                                    (posn-x knight-posn)
                                                    (posn-y knight-posn)
                                                    (scene+line tablero (posn-x knight-posn) (posn-y knight-posn) (posn-x knight-next-posn) (posn-y knight-next-posn) "black")
                                                    )
                                     )
                                   )
                    )
  )

(define (sin-movimientos? s) (empty? (estado-posn-lista s)))

COORDS-LIST

(define (escena-final s) (let*
                             ([tablero (estado-tablero s)] [font-size 20])
                             (escena (make-estado (reverse POSN-LIST) tablero))
                           )
  )

(big-bang (make-estado POSN-LIST TABLERO)
  [to-draw escena]
  [record? #f];(if (<= TABLERO-SIZE 8) "./images" #false)]
  [on-tick mover FRAME_DELAY]
  [stop-when sin-movimientos? escena-final]
)
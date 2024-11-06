#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(provide TABLERO-SIZE)

(define TABLERO-SIZE 8)

(define INITIAL-TEXT (text "Elige el tamaño deseado del tablero con las flechas del teclado" 20 "black"))

(define FONDO (empty-scene (+ (image-width INITIAL-TEXT) 50) 100))

(define STOP #false)

(define (handleKey s k) (cond [(key=? k "left") (max 5 (sub1 s))]
                              [(key=? k "right") (min 30 (add1 s))]
                              [(key=? k "\r") (set!-values (STOP TABLERO-SIZE) (values #true s))]
                              [else s]))

(define (escena s) (overlay/offset (text (number->string s) 20 "black") 0 -15 (overlay/offset INITIAL-TEXT 0 30 FONDO)))

(define (stop? s) STOP)

(big-bang 8
  [to-draw escena]
  [on-key handleKey]
  [stop-when stop?]
  [close-on-stop #true]
)
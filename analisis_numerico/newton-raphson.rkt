#lang racket/base

"Ingrese el radio R del tanque"
(define input (string->number (read-line (current-input-port))))
(+ input 10)
"El volumen de agua, para un tanque de radio R y la altura h es"



(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (f x)
  (+ (cube x)
     (* 4 (square x))
     (- 10)))

(define (der-f x)
  (+ (* 3 (square x))
     (* 8 x)))

(define (next-p f der-f p)
  (- p (/ (f p) (der-f p))))

(define tolerance 0.001)

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (error-relativo p prev-p)
  (/ (abs (- p prev-p))
     (abs p)))

(define (good-enough? p prev-p)
  (< (error-relativo p prev-p)
     tolerance))

(define (nr-iter f der-f p prev-p)
  (if (good-enough? p prev-p)
      p
      (nr-iter f
	       der-f
	       (next-p f der-f p)
	       p)))

(nr-iter f der-f 1.30 0)


     



(define (cube x)
  (* x x x))

(define (square x)
  (* x x))

(define (f x)
  (+ (cube x)
     (* 4 (square x))
     (- 10)))

(define (biseccion-iter f a b p prev-p)
  (if (good-enough? p prev-p)
      p
      (if (< (* (f a) (f p)) 0)
	  (biseccion-iter f a p (next-p a p) p)
	  (biseccion-iter f p b (next-p p b) p))))

(define (raiz-biseccion f a b)
  (biseccion-iter f a b (next-p a b) (+ (next-p a b) 1)))

(define (next-p a b)
  (/ (+ a b) 2))

(define tolerance 0.000001)

(define (good-enough? p prev-p)
  (< (/ (abs (- p prev-p))
	(abs p))
     tolerance))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(raiz-biseccion f 1 2)

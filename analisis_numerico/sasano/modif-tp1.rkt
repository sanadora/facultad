(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (next-p-sec f p prev-p)
  (- p (/ (* (f p)
	     (- p prev-p))
	  (- (f p)
	     (f prev-p)))))

;; tolerancias para calcular el error relativo
;; la de Biseccion es grande porque se usa
;; para sacar las semillas para Newton-Raphson
(define *tolerancia-nr* 0.001)
(define *tolerancia-bi* 0.1)

(define (modulo x)
  (if (< x 0)
      (- x)
      x))

(define (error-relativo p prev-p)
  (/ (modulo (- p prev-p))
     (modulo p)))

(define (good-enough? p prev-p tolerancia)
  (< (error-relativo p prev-p)
     tolerancia))

;; Newton-Raphson por el metodo de la secante.
(define (nr-secante f p prev-p)
  (if (good-enough? p prev-p *tolerancia-nr*)
      p
      (nr-secante f (next-p-sec f p prev-p) p)))

;; busqueda de raiz por Biseccion
(define (biseccion-iter f a b p prev-p)
  (if (good-enough? p prev-p *tolerancia-bi*)
      p
      (if (< (* (f a) (f p)) 0)
	  (biseccion-iter f a p (prox-p a p) p)
	  (biseccion-iter f p b (prox-p p b) p))))

(define (raiz-biseccion f a b)
  (biseccion-iter f a b (prox-p a b) (+ (prox-p a b) 1)))

;; busqueda del proximo p para Biseccion.
(define (prox-p a b)
  (/ (+ a b) 2))

(define pi 3.1416)

;; funcion a la cual calcularle la raiz.
(define (funcion r)
  (lambda (h)
    (- (* pi
	  (square h)
	  (/ (- (* 3 r)
		h)
	     3))
       30)))

(define (derivada-funcion r)
  (lambda (h)
    (+ (* (- pi) (square h))
       (* 2 pi r h)
       (- 30))))

(define (main)
  (display "Ingrese un valor (en metros) para el radio del tanque (entre 1.95m y 40m): ")
  (let ((radio (read)))
    (if (and (> radio 1.95)
	     (< radio 40))
	(begin (display "En un tanque con el radio deseado, para que contenga 30m^3, debe llenarse a una profundidad de ")
	       (display (real->decimal-string (nr-secante (funcion radio)
				  (raiz-biseccion (funcion radio) 0 4)
				  -1)))
	       (display "m")
               (newline))
	(begin (display "El radio ingresado para el tanque es invalido (fuera del rango permitido)")
	       (newline)
               (main)))))
	

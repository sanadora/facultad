(defun square (x)
  (* x x))

(defun cube (x)
  (* x x x))

(defun f (x)
  (+ (cube x)
     (* 4 (square x))
     (- 10)))

;; para calcular el p de la proxima iteracion, en el metodo normal de Newton-Raphson.
(defun next-p (f der-f p r)
  (- p (/ (funcall f p r) (funcall der-f p r))))

;; para calcular el p de la prox iteracion, en el metodo de la secante de NR.
(defun next-p-sec (f p prev-p)
  (- p (/ (* (funcall f p)
	     (- p prev-p))
	  (- (funcall f p)
	     (funcall f prev-p)))))

(defparameter *tolerancia-nr* 0.001)
(defparameter *tolerancia-bi* 0.1)

(defun modulo (x)
  (if (< x 0)
      (- x)
      x))

(defun error-relativo (p prev-p)
  (/ (modulo (- p prev-p))
     (modulo p)))

(defun good-enough? (p prev-p tolerancia)
  (< (error-relativo p prev-p)
     tolerancia))

;; algoritmo de Newton-Raphson normal.
(defun nr-iter (f der-f p prev-p)
  (if (good-enough? p prev-p *tolerancia-nr*)
      p
      (nr-iter f
	       der-f
	       (next-p f der-f p)
	       p)))

;; Newton-Raphson por el metodo de la secante.
(defun nr-secante (f p prev-p)
  (If (good-enough? p prev-p *tolerancia-nr*)
      p
      (nr-secante f (next-p-sec f p prev-p) p)))

;; busqueda de raiz por Biseccion
(defun biseccion-iter (f a b p prev-p)
  (if (good-enough? p prev-p *tolerancia-bi*)
      p
      (if (< (* (funcall f a) (funcall f p)) 0)
	  (biseccion-iter f a p (prox-p a p) p)
	  (biseccion-iter f p b (prox-p p b) p))))

(defun raiz-biseccion (f a b)
  (biseccion-iter f a b (prox-p a b) (+ (prox-p a b) 1)))

;; busqueda del proximo p para Biseccion.
(defun prox-p (a b)
  (/ (+ a b) 2))

;; funcion a la cual calcularle la raiz.
(defun funcion (r)
  (lambda (h)
    (- (* pi
	  (square h)
	  (/ (- (* 3 r)
		h)
	     3))
       30)))

(defun derivada-funcion (r)
  (lambda (h)
    (+ (* (- pi) (square h))
       (* 2 pi r h)
       (- 30))))
	

;; (nr-secante (function g) (raiz-biseccion (function g) 0 40) 1)

(defun main ()
  (princ "Ingrese un valor para el radio del tanque (entre 1.95m y 40m): ")
  (let ((radio (read)))
    (if (and (> radio 1.95)
	     (< radio 40))
	(progn (princ "En un tanque con el radio deseado, para que contenga 30m^3, debe llenarse a una profundidad de ")
	       (princ (nr-secante (funcion radio)
				  (raiz-biseccion (funcion radio) 0 4)
				  -1))
	       (ext:exit))
	(progn (princ "El nro de R ingresado es invalido.")
	       (fresh-line)
	       (main)))))

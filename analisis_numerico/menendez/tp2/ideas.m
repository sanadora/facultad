# variables iniciales
t0 = clock();
longitud = 20; # [centimetros]
tiempo = 60; # [segundos]
k = 0.120;
c = 0.114;
p = 7.8;
mu = k / (c * p);
dt = 0.01;
dx = 0.5;
r = (mu * dt) / (dx ** 2)
# m: cantidad de puntos
m = (longitud / dx) + 1
# n: cant de ptos importantes para la matriz
n = m - 2;

A = zeros(n,n);
x = zeros(m,1);
b = zeros(m,1);

# se carga la matriz A, con los coeficientes de las ecuaciones
A(1,1) = 2 + 2*r;
A(1,2) = -r;
for j = 2:n-1;
  A(j,j) = 2 + 2*r;
  A(j,j-1) = -r;
  A(j,j+1) = -r;
endfor;
A(n,n-1) = -r;
A(n,n)   = 2 + 2*r;

for j = 0:m-1;
  if (j*dx) <= 10;
    x(j+1,1) = 10 * j*dx;
  else
    x(j+1,1) = 200 - 10 * j*dx;
  endif;
endfor;


disp("1) Eliminacion Gausseana");
disp("2) Doolittle");
disp("3) Cholesky");
disp("4) Gauss-Seidel");
disp("--------------------------------");
switch menu = input("Que metodo quiere utilizar? [1-4]  > ");
  case 2
    [l, u, p] = lu(A);
  case 3
    L=chol(A,'lower');
end;

for i = 1: tiempo / dt;
  disp(i);
  for j = 2: m-1;
    b(j,1) = r * x(j-1,1) + (2-2*r) * x(j,1) + r * x(j+1,1);
  endfor;

  switch menu;
         case 1
           x(2:m-1 , 1) = eliminacion_gaussiana(A,b(2:m-1 , 1),false);
         case 2
           y = eliminacion_l(l,b(2:m-1,1));
           x(2:m-1 , 1) = eliminacion_gaussiana(u,y,true);
         case 3
           y = eliminacion_l(L,b(2:m-1,1));
           x(2:m-1 , 1) = eliminacion_gaussiana(transpose(L),y,true);
         case 4
           error = 99;
           while error > 0.001
             x_ant = x(2:m-1 , 1);
             x(2:m-1 , 1) = gauss_seidel(A,b(2:m-1 , 1), x(2:m-1 , 1));
             x_nuevo = x(2:m-1 , 1);
             error = max( abs( x_nuevo - x_ant));
           endwhile;


  end;
endfor;

disp("RESULTADO");
disp(x);

printf("Tiempo transcurrido: %f segundos.\n",etime(clock(),t0));

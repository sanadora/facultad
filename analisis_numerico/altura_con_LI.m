function altura = altura_con_LI(i,j,datos)
% INTERPOLACION LINEAL: asigna a la celda el valor promedio de los k
% puntos observados mas cercanos.
  global lado_celda;
  altura = 0;
  k = 4;
  punto_actual = [i*lado_celda , j*lado_celda];
% espando la tabla de datos con una columna para poner las distancias
  puntos = horzcat(datos,zeros(24,1));
  for i=1:24;
      puntos(i,4) = dist(punto_actual , [datos(i,1) , datos(i,2)]);
  endfor;
% la tabla queda ordenada de menor a mayor por la distancia
  puntos = sortrows(puntos,4);
  for i=1:k;
      altura += puntos(i,3);
  endfor
  altura = altura / k;
endfunction;

function norma = dist(punto_a, punto_b)
  norma = norm(punto_a - punto_b);
endfunction;

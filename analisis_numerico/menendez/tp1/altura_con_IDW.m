function altura = altura_con_IDW(i,j,datos)
% INVERSA DISTANCIA PONDERADA asigna a la celda la media ponderada
% utilizando como factor de ponderacion la inversa de la distancia
% elevada al exponente b.
  global lado_celda;
  altura = 0;
  distancia = 0;
  b = 3;
  punto_actual = [i*lado_celda , j*lado_celda];
% expando la tabla de datos con dos columnas para poner, en la primera
% el valor 1/di**b y en la segunda zi/dij**b
  puntos = horzcat(datos,zeros(24,2));
  for i=1:24;
      distancia = dist(punto_actual , [datos(i,1) , datos(i,2)]);
      puntos(i,4) = 1 / (distancia ** b);
      puntos(i,5) = datos(i,3) / (distancia ** b);
  endfor;
  altura = sum(puntos(:,5)) / sum(puntos(:,4));
endfunction;

function norma = dist(punto_a, punto_b)
  norma = norm(punto_a - punto_b);
endfunction;

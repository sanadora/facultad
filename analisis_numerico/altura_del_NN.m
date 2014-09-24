function altura = altura_del_NN(i,j,datos)
% NEAREST NEIGHBOUR: a cada celda se le asigna el valor del punto
% observado mas cercano
  global lado_celda;
  altura = 0;
  distancia  = 9999;
  punto1 = [i*lado_celda , j*lado_celda];
  punto2 = zeros(1,2);
  for k=1:24;
    punto2 = [datos(k,1) , datos(k,2)];
    if (norm(punto1 - punto2) < distancia);
      distancia = norm(punto1 - punto2);
      altura = datos(k,3);
    endif;
  endfor;
endfunction;


function tabla = transformar(terreno)
  dimensiones = size(terreno);
  tabla = zeros(dimensiones(1)*dimensiones(2),3);
  for i = 0:dimensiones(1)-1;
      for j = 1:dimensiones(2);
          fila = i * dimensiones(2) + j;
          tabla(fila,:) = [i+1 , j , terreno(i+1,j)];
      endfor;
  endfor;
endfunction;
  

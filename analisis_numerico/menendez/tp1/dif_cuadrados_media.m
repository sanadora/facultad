function resultado = dif_cuadrados_media(datos,terreno,lado_celda)
  diferencia = 0;
  resultado = 0;
  for i=1:24;
    n = floor(datos(i,2) / lado_celda) ;
    m = floor(datos(i,1) / lado_celda) ;
    if n >= size(terreno)(1);
       n -= 1;
    endif
    if n < 1;
       n += 1;
    endif;
    if m >= size(terreno)(2);
       m -= 1;
    endif
    disp(terreno(n,m));
    disp(datos(i,3));
    diferencia = datos(i,3) - terreno(n,m)
    resultado += diferencia ** 2;
  endfor
  resultado = resultado / 24;
endfunction;
  
    

    

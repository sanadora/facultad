% tabla con los valores de altura para el barrio La Ribera
load datos.txt;
% largo y ancho del terreno 
lt = 1150;
at = 400;
% lado del cuadrado que tomamos como celda, en metros 
global lado_celda = 20;

ancho = at / lado_celda;
largo = lt / lado_celda;
terreno = zeros( ancho , largo);

for i = 1:ancho;
    disp(i);
    for j = 1:largo;
        terreno(i,j) = altura_con_IDW(i,j,datos);
    endfor;
endfor;
save resultado.txt;
      

    


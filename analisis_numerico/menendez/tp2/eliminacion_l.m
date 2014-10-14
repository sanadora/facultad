function [ x ] = eliminacion_l( A , b)
  [n q]=size(A);
  x=zeros(n,1);
  for i=1:n;
    aux = 0;
    for j=1:i-1;
        aux += A(i,j) * x(j);
    endfor;
    x(i)=(b(i)-aux)/A(i,i);
endfor;

function altura_con_GRIDDATA(datos)
  x = datos(:,1);
  y = datos(:,2);
  z = datos(:,3);
% Three steps of magic
  [X,Y] = meshgrid(unique(x),unique(y));
  Z = griddata(x,y,z,X,Y);
%  pcolor(X,Y,Z); shading flat; colorbar;
%  hold on; plot(x,y,'k.')  %Original data points
  W = horzcat(X,Y,Z);
  mesh(Z);

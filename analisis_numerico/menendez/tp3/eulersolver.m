function [t,data] = eulersolver(y,dt,t_final,derivs_handle)
  time = 0;
  Nsteps = round(t_final/dt); % number of steps to take
  t = zeros(Nsteps,1);
  data = zeros(Nsteps,length(y));
  t(1) = time; % store initial condition
  data(1,:) = y';
  for i = 1:Nsteps
      dy = feval(derivs_handle,time,y);
      y = y + dy*dt;
      time = time + dt;
      t(i+1) = time;
      data(i+1,:) = y';
  end

function dy = derivs(time,y)
  dy = zeros(2,1); %% initialize dy array and orient as column
  X = 1; %% position
  V = 2; %% velocity
  dy(V) = -y(X);   %% dv/dt = -x
  dy(X) = y(V);    %% dx/dt = v

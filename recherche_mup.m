function [mup,fmup,Imup] = recherche_mup(mu,f,Imu,i)
  [N,d] = size(mu);

  if i == 1
    mup = [mu(2,:)]';
    fmup = [f(2,:)]';
    Imup = [Imu(2,:)]';
  elseif i == N
    mup = [mu(N-1,:)]';
    fmup = [f(N-1,:)]';
    Imup = [Imu(N-1,:)]';
  else
    mup = [mu(i-1,:) mu(i+1,:)]';
    fmup = [f(i-1,:) f(i+1,:)]';
    Imup = [Imu(i-1,:) Imu(i+1,:)]';
  endif
  
endfunction
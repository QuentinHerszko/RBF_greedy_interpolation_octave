function [mup,fmup] = recherche_mup(mu,fmu,i)
  [N,d] = size(mu);

  if i == 1
    fmup = [fmu(2,:) fmu(3,:)]';
    mup = [mu(2,:) mu(3,:)]';
  elseif i == 2
    fmup = [fmu(1,:) fmu(3,:) fmu(4,:)]';
    mup = [mu(1,:) mu(3,:) mu(4,:)]';
  elseif i == N-1
    fmup = [fmu(N-3,:) fmu(N-2,:) fmu(N,:)]';
    mup = [mu(N-3,:) mu(N-2,:) mu(N,:)]';
  elseif i == N
    fmup = [fmu(N-2,:) fmu(N-1,:)]';
    mup = [mu(N-2,:) mu(N-1,:)]';
  else
    fmup = [fmu(i-2,:) fmu(i-1,:) fmu(i+1,:) fmu(i+2,:)]';
    mup = [mu(i-2,:) mu(i-1,:) mu(i+1,:) mu(i+2,:)]';
  endif
  
endfunction

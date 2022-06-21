function [mup,fmup] = recherche_mup_bis(mu,fmu,i)
  [N,d] = size(mu);

  if i == 1
    fmup = [fmu(2,:)]';
    mup = [mu(2,:)]';
  elseif i == N
    fmup = [fmu(N-1,:)]';
    mup = [mu(N-1,:)]';
  else
    fmup = [fmu(i-1,:) fmu(i+1,:)]';
    mup = [mu(i-1,:) mu(i+1,:)]';
  endif
  
endfunction

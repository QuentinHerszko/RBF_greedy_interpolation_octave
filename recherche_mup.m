function [mup,fmup] = recherche_mup(mu,f,i)
  [N,d] = size(mu);

  if i == 1
    mup = [mu(2,:) mu(3,:)]';
    fmup = [f(2,:) f(3,:)]';
  elseif i == 2
    mup = [mu(1,:) mu(3,:) mu(4,:)]';
    fmup = [f(1,:) f(3,:) f(4,:)]';
  elseif i == N-1
    mup = [mu(N-3,:) mu(N-2,:) mu(N,:)]';
    fmup = [f(N-3,:) f(N-2,:) f(N,:)]';
  elseif i == N
    mup = [mu(N-2,:) mu(N-1,:)]';
    fmup = [f(N-2,:) f(N-1,:)]';
  else
    mup = [mu(i-2,:) mu(i-1,:) mu(i+1,:) mu(i+2,:)]';
    fmup = [f(i-2,:) f(i-1,:) f(i+1,:) f(i+2,:)]';
  endif
  
endfunction

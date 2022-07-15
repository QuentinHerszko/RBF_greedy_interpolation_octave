function [gamma] = recherche_poid(mu_tilde,fmu_tilde,sig,k)
  gamma = zeros(k,1);
  
  for i = 1 : 1 : k
    for j = 1 : 1 : k
      phi = RadialKernel('Gauss',sig(j));
      phiR = phi( sqrt( sum( (mu_tilde(i) - mu_tilde(j)).^2,2 ) ) );
      M(i,j) = phiR;
    endfor
  endfor
  F = zeros(size(M,1),1);
  F(1:k) = fmu_tilde(k);
  
  gamma = M\F;
  
endfunction
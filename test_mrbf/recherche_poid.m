function [gamma] = recherche_poid(mu,fmu,sig)
  [M,d] = size(mu);
  gamma = zeros(M,1);
  
  for i = 1 : 1 : M
    for j = 1 : 1 : M
      phi = RadialKernel('Gauss',sig(j));
      M(i,j) = phi(norm(mu(i) - mu(j),2));
    endfor
  endfor
  F = zeros(size(M,1),1);
  F = fmu;
  
  gamma = M\F;
  
endfunction
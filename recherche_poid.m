function [gamma] = recherche_poid(mu,fmu,sig,k)
  gamma = zeros(k,1);
  
  for i = 1 : 1 : k
    for j = 1 : 1 : k
      phi = RadialKernel('Gauss',sig(j));
      M(i,j) = phi(norm(mu(i) - mu(j),2));
    endfor
  endfor
  F = zeros(size(M,1),1);
  F(1:k) = fmu(1:k);
  
  gamma = M\F;
  
endfunction
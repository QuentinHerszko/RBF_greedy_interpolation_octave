function [yin] = rbf_val(gamma,sig,mu_tilde,mu_tildep,xin,k)
  [M,d] = size(xin);
  yin = zeros(M,1);
  for i = 1 : 1 : M
    norme = sqrt( sum((mu_tilde-xin(i,:)).^2,2 ) );
    for j = 1 : 1 : k
      phi = SpecialKernel(sig(j),mu_tildep(j));
      phiR = phi(norme(j));
      yin(i) += gamma(j) * phiR;
    endfor
  endfor
endfunction
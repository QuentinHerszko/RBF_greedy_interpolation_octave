function [gamma,sig] = rbf_coef(mu,fmu)
  [M,d] = size(mu);
  gamma = zeros(M,1);
  sig = zeros(1,M);

  for k = 1 : 1 : M
    % - Recherche des sigma
    sig(k) = recherche_sig_opt(sig,mu,fmu,k);
  endfor
  
  % - Coefficients de l'interpolation
  gamma = recherche_poid(mu,fmu,sig);

endfunction
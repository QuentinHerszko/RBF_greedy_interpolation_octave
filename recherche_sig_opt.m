function [sig_opt] = recherche_sig_opt(sig,mu_tilde,fmu_tilde,mup,fmup,k)
  var_sig = 0.1 : 0.1 : 10;
  err = zeros(1,length(var_sig));

  for i = 1 : 1 : length(var_sig)
    sig(k) = var_sig(i);
    % - construction de l'interpolation
    gamma = recherche_poid(mu_tilde,fmu_tilde,sig,k);
    Imup = rbf_val(gamma,sig,mu_tilde,mup,k);
    % - calcul de l'erreur
    err(i) = min(abs(fmup - Imup));
  endfor
  
  [e,h] = min(err);
  sig_opt = var_sig(h);
endfunction
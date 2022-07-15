<<<<<<< HEAD
function [sig_opt,gamma_opt] = recherche_sig_opt(sig,mu_tilde,fmu_tilde,mup,fmup,k)
  var_sig = 0.1 : 0.1 : 20;
=======
function [sig_opt,gamma_opt] = recherche_sig_opt(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k)
  var_sig = 0.1 : 0.1 : 10;
>>>>>>> ae169162acb5089465de6d364cbc28a27ec5c3ea
  err = zeros(1,length(var_sig));

  for i = 1 : 1 : length(var_sig)
    sig(k) = var_sig(i);
    % - construction de l'interpolation
    Imup = rbf_val(gamma,sig,mu_tilde,mup,k);
    % - calcul de l'erreur
    err(i) = min(abs(fmup - Imup));
  endfor
  
  [e,h] = min(err);
  sig_opt = var_sig(h);
endfunction
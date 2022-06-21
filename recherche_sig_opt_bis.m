function [sig_opt] = recherche_sig_opt_bis(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k)
  var_sig = 0;
  err = -1;

  while err < 0
    var_sig += 0.001;
    sig(k) = var_sig
    % - construction de l'interpolation
    Imup = rbf_val(gamma,sig,mu_tilde(1:k),mup,k);
    % - calcul de l'erreur
    err = min(fmup - Imup);
  endwhile

  sig_opt = sig(k);
endfunction
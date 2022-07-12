function [sig_opt] = recherche_sig_opt_bis(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k)
  var_sig = 0;
  seuil = 1e-2
  err = seuil + 1;

  while err > seuil
    var_sig += 0.001;
    sig(k) = var_sig
    % - construction de l'interpolation
    Imup = rbf_val(gamma,sig,mu_tilde(1:k),mup,k);
    % - calcul de l'erreur
    err = sqrt( sum(fmup - Imup).^2 / length(fmup));
  endwhile

  sig_opt = sig(k);
endfunction
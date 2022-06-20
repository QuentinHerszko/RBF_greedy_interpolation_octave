function [sig_opt] = recherche_sig_opt(sig,mu,fmu,k)
  var_sig = 0.1 : 0.1 : 10;
  err = zeros(1,length(var_sig));

  for i = 1 : 1 : length(var_sig)
    sig(k:end) = var_sig(i);
    % - coefficients gamma
    gamma = recherche_poid(mu,fmu,sig);
    % - construction de l'interpolation
    Imu = rbf_val(gamma,sig,mu(1:k),mu,k);
    % - calcul de l'erreur
    err(i) = min(abs(fmu - Imu));
  endfor
  
  [e,h] = min(err);
  sig_opt = var_sig(h);
endfunction
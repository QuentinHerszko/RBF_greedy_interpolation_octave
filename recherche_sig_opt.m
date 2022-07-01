function [sig_opt] = recherche_sig_opt(sig,gamma,mu_tilde,mup,fmup,f,k)
  var_sig = 0.1 : 0.1 : 10;
  err = zeros(1,length(var_sig));

  for i = 1 : 1 : length(var_sig)
    sig_opt = var_sig(i);

    % - évaluation
    phi = RadialKernel('Gauss',sig_opt);
    Imup = zeros(length(mup),1);
    for j = 1 : 1 : length(mup)
      phiR = phi( sqrt( sum( (mu_tilde(k) - mup(j)).^2,2 ) ) );
      Imup(j) = gamma(k) * phiR;
    endfor

    % - calcul de l'erreur
    err(i) = min(abs(fmup - Imup));

  endfor
  
  [e,h] = min(err);
  sig_opt = var_sig(h);
endfunction
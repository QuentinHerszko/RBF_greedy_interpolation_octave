function [var_sig] = recherche_sig_opt_bis(gamma,mu_tilde,mup,fmup,f,li,k)
  var_sig = 0;
  seuil = 1e-3;
  test = seuil + 1;
  itermax = 2000;
  iter = 0;

  % --- Recherche du param de forme tq l'interp passe par les pts d'interpolation
  while test > seuil && iter < itermax
    var_sig += 0.1;

    % - évaluation
    phi = RadialKernel('Gauss',var_sig);
    Imu1 = zeros(length(mu_tilde(1:k-1)),1);
    for j = 1 : 1 : k-1
      phiR = phi( sqrt( sum( (mu_tilde(k) - mu_tilde(j)).^2,2 ) ) );
      Imu1(j) = gamma(k) * phiR;
    endfor

    % - test
    test = max(abs(f(li(1:k-1)) - Imu1));
    iter += 1;
  endwhile

  % --- Recherche du param de forme tq cela épouse le plus possible la courbe
  phi = RadialKernel('Gauss',var_sig);
  Imup = zeros(length(mup),1);
  for j = 1 : 1 : length(mup)
    phiR = phi( sqrt( sum( (mu_tilde(k) - mup(j)).^2,2 ) ) );
    Imup(j) = gamma(k) * phiR;
  endfor
  errold = sqrt( sum(fmup - Imup).^2 / length(fmup));
  iter = 0;
  
  while iter < itermax
    var_sig += 0.1;
    phi = RadialKernel('Gauss',var_sig);
    Imup = zeros(length(mup),1);
    for j = 1 : 1 : length(mup)
      phiR = phi( sqrt( sum( (mu_tilde(k) - mup(j)).^2,2 ) ) );
      Imup(j) = gamma(k) * phiR;
    endfor
    errnew = sqrt( sum(fmup - Imup).^2 / length(fmup));

    iter += 1;

    if errold - errnew < 0
      break;
    endif

    errold =  errnew;
  endwhile

endfunction
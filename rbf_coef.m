function [gamma, sig, mu_tilde,k] = rbf_coef(mu,fmu)
  [M,d] = size(mu);
  gamma = zeros(M,1);
  sig = zeros(1,M);
  mu_tilde = zeros(M,d);
  fmu_tilde = zeros(M,1);
  [fmu_tilde(1),i] = max(fmu);
  mu_tilde(1) = mu(i);
  seuil = 1e-2;
  test = seuil + 1;
  k = 1;
  
  while test > seuil && k <= 3
    % - Recherche sig_opt et màj de gamma
    k
    mu_tilde
    [mup,fmup] = recherche_mup(mu,fmu,i);
    [sig(k),gamma(k)] = recherche_sig_opt(sig,mu_tilde,fmu_tilde,mup,fmup,k);

    % - Test
    Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
    [test,b] = max(abs(Imu - fmu))

    % - Prochain P.I
    if test > seuil && k != 3
      [mu_tilde(k+1),fmu_tilde(k+1),i] = ppi(gamma,sig,mu_tilde,mu,fmu,k);
    endif
    k = k + 1;
  endwhile
endfunction

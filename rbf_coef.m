function [gamma, sig, mu_tilde,k] = rbf_coef(mu,fmu)
  [M,d] = size(mu);
  gamma = zeros(M,1);
  sig = zeros(1,M);
  mu_tilde = zeros(M,d);
  fmu_tilde = zeros(M,1);
  Imu = zeros(M,1);
  Imu_tilde = zeros(M,1);
  seuil = 1e-2;
  test = seuil + 1;
  k = 1;
  
  while test > seuil && k <= 2

    % - Mise à jour de mu_tilde
    [mu_tilde(k),fmu_tilde(k),Imu_tilde(k),i] = ppi(mu,fmu,Imu);

    % - Mise à jour de gamma que sur le point d'interpolation en question
    gamma(k) = fmu_tilde(k) - Imu_tilde(k);

    % - Mise à jour de sigma en fonction des résultats précédents
    [mup,fmup] = recherche_mup(mu,fmu,i);
    sig(k) = recherche_sig_opt(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k);

    % - Test
    Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
    test = max(abs(fmu-Imu));

    k = k + 1;
  endwhile

  figure(2)
  plot(mu,Imu)
endfunction
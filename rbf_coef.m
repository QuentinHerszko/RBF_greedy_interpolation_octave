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
  
  while test > seuil && k <= M

  % - Recherche mu_tilde
  [mu_tilde(k), fmu_tilde(k), Imu_tilde(k), i] = ppi(mu,fmu,Imu);

  % - Calcul de gamma
  gamma(k) = fmu(i) - Imu(i);

  % - Mise à jour de sigma en fonction des résultats précédents
  [mup,fmup] = recherche_mup_bis(mu,fmu,i);
  mu_tilde
  if k ~= 1
    fmup = unique([fmup; fmu_tilde(1:k-1)]);
    mup = unique([mup; mu_tilde(1:k-1)])
  endif
  sig(k) = recherche_sig_opt(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k);

  % - test
  Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
  test = max(abs(fmu-Imu));
  figure(2)
  hold on
  grid on
  plot(mu,fmu-Imu)

  k = k + 1;

  endwhile
endfunction
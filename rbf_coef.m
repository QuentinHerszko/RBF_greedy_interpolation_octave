function [gamma, sig, mu_tilde,k] = rbf_coef(mu,fmu,x,y)
  [M,d] = size(mu);
  gamma = zeros(M,1);
  sig = zeros(1,M);
  mu_tilde = zeros(M,d);
  mi_tildep = zeros(M,d);
  fmu_tilde = zeros(M,1);
  Imu = zeros(M,1);
  Imu_tilde = zeros(M,1);
  I = zeros(length(x),1);
  seuil = 1e-2;
  test = seuil + 1;
  k = 1;

  % - erreur d'approximation
  err_approx = zeros(1,M);
  
  while test > seuil && k <= M

  figure(k+1)
  hold on
  grid on
  plot(x,y-I,'-r','linewidth',2)
  plot(mu,fmu-Imu,'*k','linewidth',2)

  % - Recherche mu_tilde
  [mu_tilde(k), fmu_tilde(k), Imu_tilde(k), i] = ppi(mu,fmu,Imu);

  % - Calcul de gamma
  gamma(k) = fmu(i) - Imu(i);

  % - Mise à jour de sigma en fonction des résultats précédents
  [mup,fmup] = recherche_mup_bis(mu,fmu,i);
  [m,p] = min(abs(mu_tilde(1:k) - mu(i)));
  mu_tildep(k) = mu_tilde(p);
  %if k ~= 1
  %  fmup = unique([fmup; fmu_tilde(1:k-1)]);
  %  mup = unique([mup; mu_tilde(1:k-1)])
  %endif
  sig(k) = recherche_sig_opt(sig,gamma,mu_tilde,fmu_tilde,mup,fmup,k);

  %if k ~= 1
  %  phi = RadialKernel('gauss',sig(k));
  %  gamma(1:k-1) = fmu_tilde(1:k-1) - gamma(k) * phi( sqrt( sum( (mu_tilde(k) - mu_tilde(1:k-1)).^2,2 ) ) )
  %endif

  % - test
  Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
  fmu - Imu
  test = max(abs(fmu-Imu));

  % - plot
  I = rbf_val(gamma,sig,mu_tilde,x,k);
  Ip = rbf_val(gamma(k),sig(k),mu_tilde(k),x,1);
  plot(x,Ip,'--b','linewidth',2)
  l = legend("f - I","I.P","I_k");
  set(l,"fontsize",15)
  set(gca,"fontsize",15)

  yin = rbf_val(gamma, sig, mu_tilde, x, k-1);
  err_approx(k) = sqrt( sum( (yin - y).^2 )/length(x) );

  k = k + 1;

  endwhile

  figure(10)
  grid on
  plot(1:k-1,err_approx(1:k-1),'*b','linewidth',2)
  xlabel("Nombre de points d'interpolation traité")
  ylabel("Erreur d'approximation")
  set(gca,'fontsize',15)

endfunction
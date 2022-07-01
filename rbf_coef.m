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
  li = zeros(1,M);
  
  while test > seuil && k <= M

    f = fmu - Imu;

    % - Recherche mu_tilde
    [mu_tilde(k), i] = ppi(f,mu)
    li(k) = i;
  
    % - Recherche de sigma
    %%% voisins (+ mu_tildes précédents)
    [mup,fmup] = recherche_mup(mu,f,i);
    %if k ~= 1
    %  mup = unique([mup; mu_tilde(1:k-1)]);
    %  fmup = unique([fmup; f(li(1:k-1))]);
    %endif

    %%% paramètre de forme et calcul des coefficients
    gamma(k) = f(i);
    sig(k) = recherche_sig_opt_bis(gamma,mu_tilde,mup,fmup,f,li,k);

    % - test
    Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
    test = max(abs(fmu-Imu));
    k = k + 1;
    
  endwhile

endfunction
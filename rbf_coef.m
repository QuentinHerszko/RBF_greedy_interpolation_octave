<<<<<<< HEAD
function [gamma, sig, mu_tilde,k] = rbf_coef(mu,fmu,x,y)
  % informations de base
  [M,d] = size(mu);
  Imu = zeros(M,1);
  g = fmu - Imu;

  % information à retenir
  mu_tilde = zeros(M,1);
  fmu_tilde = zeros(M,1);
  sig = zeros(1,M);
  gamma = zeros(M,1);

  % Donnée boucle
  seuil = 1e-2;
  test = seuil + 1;
  k = 1;
  
  % - Erreur d'approximation
  err_approx = zeros(1,M);

  while test > seuil && k <= M

    figure(k+1)
    hold on
    grid on
    plot(x,y-I,'-r','linewidth',2)
    plot(mu,g,'*k','linewidth',2)

    % - point d'interpolation à traiter :
    [m1,i] = max(g);
    
    % - enregistrement de la donnée :
    mu_tilde(k) = mu(i);
    fmu_tilde(k) = fmu(i);
    mu_tilde

    % - Recherche sig_opt et màj de gamma
    [mup,fmup] = recherche_mup(mu,fmu,i);

    var_sig = 0.1 : 0.1 : 20;
    err = zeros(1,length(var_sig));

    for j =  1 : 1 : length(var_sig)
      sig(k) = var_sig(j);
      % calcul de gamma :
      gammap = recherche_poid(mu_tilde,fmu_tilde,sig,k);
      gamma(k) = gammap(end);
      % - construction de l'interpolation
      Imup = rbf_val(gamma,sig,mu_tilde(1:k),mup,k);
      % - calcul de l'erreur
      err(j) = sqrt( sum(fmup - Imup).^2 / length(fmup));
    endfor

    [m3,q] = min(err);
    % enregistrement de la donnée
    sig(k) = var_sig(q);

    % - test
    Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
    g = fmu - Imu;
    test = max(abs(g));
    
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

err_approx
figure()
grid on
plot(1:10,err_approx,'*b','linewidth',2)
xlabel("Nombre de points d'interpolation traité")
ylabel("Erreur d'approximation")
set(gca,'fontsize',15)

endfunction
=======
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
endfunction
>>>>>>> ae169162acb5089465de6d364cbc28a27ec5c3ea

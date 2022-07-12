function [gamma, sig, mu_tilde, mu_int] = rbf_coef(mu,fmu,x,y)
  % informations de base
  [M,d] = size(mu);
  Imu = zeros(M,1);
  g = fmu - Imu;
  
  % information à retenir
  mu_tilde = zeros(M,1);
  sig = zeros(1,M);
  gamma = zeros(M,1);
  
  mu_int = zeros(M,1);

  % Donnée boucle
  seuil = 1e-2;
  test =  seuil + 1;
  k = 1;

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
    mu_tilde

    % calcul de gamma

    gamma(k) = fmu(i) - Imu(i);

    % - limite de sigma :
    if k == 1
      [m2,p] = min([abs(mu(i) - mu(1)), abs(mu(i) - mu(M))]);
      if p == 1
        mu_int(k) = mu(1);
      else
        mu_int(k) = mu(M);
      endif
    else
      [m2,p] = min(abs(mu(i) - mu_tilde(1:k-1)));
      mu_int(k) = mu_tilde(p);
    endif

    % - voisins du pt actuel :
    [mup,fmup] = recherche_mup(mu,fmu,i);

    % - recherche du paramètre de forme
    var_sig = 0.001 : 0.001 : m2;
    err = zeros(1,length(var_sig));

    for j = 1 : 1 : length(var_sig)
      sig(k) = var_sig(j);
      % - construction de l'interpolation
      Imup = rbf_val(gamma,sig,mu_tilde(1:k),mup,k);
      % - calcul de l'erreur
      err(j) = sqrt( sum(fmup - Imup).^2 / length(fmup));
    endfor
    
    err(1:10)

    if err == 0
      sig(k) = m2;
    else 
      [m3,q] = min(err);
      % enregistrement de la donnée
      sig(k) = var_sig(q);
    endif
    
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

    k += 1;

  endwhile
    
endfunction
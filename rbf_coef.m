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

  for k = 1 : 1 : 6

  figure(k)
  hold on
  grid on
  plot(x,y-I)
  plot(mu,g,'*k')
    
    % - point d'interpolation à traiter :
    [m1,i] = max(g);
    
    % - enregistrement de la donnée :
    mu_tilde(k) = mu(i);
    mu_tilde
    
    % - point d'interpolation qui définissent l'intervalle
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
    
    % - recherche du paramètre de forme le plus adapté
    var_sig = 0.1 : 0.1 : 2000;
    err = zeros(1,length(var_sig));
    
    Imu(i)
    
    for j = 1 : 1 : length(var_sig)
      
      sig(k) = var_sig(j);
      
      phi = SpecialKernel(var_sig(j),m2);
      
      if phi(0) ~= 0
        gamma(k) = (fmu(i) - Imu(i)) / phi(0);
        Imup = rbf_val(gamma,sig,mu_tilde,mu_int,mup,k);
        err(j) = sqrt( sum(fmup - Imup).^2 / length(fmup));
      else
        err(j) = 1e8;
      endif
      
    endfor
    
    [m3,q] = min(err);
    % enregistrement de la donnée
    sig(k) = var_sig(q);
    
    % - calcul du coeff gamma
    phi = SpecialKernel(sig(k),m2);
    gamma(k) = (fmu(i) - Imu(i)) / phi(0);
    
    % - mise à jour de g
    Imu = rbf_val(gamma,sig,mu_tilde,mu_int,mu,k);
    g = fmu - Imu;

    % - plot
    I = rbf_val(gamma,sig,mu_tilde,mu_int,x,k);
    Ip = rbf_val(gamma(k),sig(k),mu_tilde(k),mu_int(k),x,1);
    plot(x,Ip)
    
  endfor
    
endfunction
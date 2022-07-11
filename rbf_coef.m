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
    var_sig = 0.01 : 0.01 : m2;
    err = zeros(1,length(var_sig));
    
    % - calcul du coeff gamma
    gamma(k) = fmu(i) - Imu(i);
    
    for j = 1 : 1 : length(var_sig)
      
      sig(k) = var_sig(j);
      
      phi = SpecialKernel(var_sig(j),m2);
      
      Imup = rbf_val(gamma,sig,mu_tilde,mup,k);
      err(j) = sqrt( sum(fmup - Imup).^2 / length(fmup));
      
    endfor
    
    [m3,q] = min(err);
    % enregistrement de la donnée
    sig(k) = var_sig(q);
    
    % - mise à jour de g
    Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
    g = fmu - Imu;
    
    % - plot
    I = rbf_val(gamma,sig,mu_tilde,x,k);
    Ip = rbf_val(gamma(k),sig(k),mu_tilde(k),x,1);
    plot(x,Ip)

  endfor
    
endfunction
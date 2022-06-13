function [next_mu_tilde,next_fmu_tilde] = ppi(gamma,sig,mu_tilde,mu,fmu,k)
  Imu = rbf_val(gamma,sig,mu_tilde,mu,k);
  [m,i] = max(abs(fmu - Imu));
  next_mu_tilde = mu(i);
  next_fmu_tilde = fmu(i);
endfunction
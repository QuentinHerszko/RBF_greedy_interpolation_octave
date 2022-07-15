function [next_mu_tilde,next_fmu_tilde,i] = ppi(mu,fmu,Imu)
  [m,i] = max(abs(fmu - Imu));
  next_mu_tilde = mu(i);
  next_fmu_tilde = fmu(i);
endfunction
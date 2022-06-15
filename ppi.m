function [next_mu_tilde,next_fmu_tilde,next_Imu_tilde,i] = ppi(mu,fmu,Imu)
  [m,i] = max(abs(fmu - Imu));
  next_mu_tilde = mu(i);
  next_fmu_tilde = fmu(i);
  next_Imu_tilde = Imu(i);
endfunction
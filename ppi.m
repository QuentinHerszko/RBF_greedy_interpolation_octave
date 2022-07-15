<<<<<<< HEAD
function [next_mu_tilde,next_fmu_tilde,i] = ppi(mu,fmu,Imu)
=======
function [next_mu_tilde,next_fmu_tilde,next_Imu_tilde,i] = ppi(mu,fmu,Imu)
>>>>>>> ae169162acb5089465de6d364cbc28a27ec5c3ea
  [m,i] = max(abs(fmu - Imu));
  next_mu_tilde = mu(i);
  next_fmu_tilde = fmu(i);
  next_Imu_tilde = Imu(i);
endfunction
function [next_mu_tilde,i] = ppi(f,mu)
  [m,i] = max(abs(f));
  next_mu_tilde = mu(i);
endfunction
function [phi] = SpecialKernel(varargin)
  % --- Default
  if length(varargin) == 0
    sig = 3;
  else
    sig = varargin{1};
  endif

  if length(varargin) <= 1
    mu = 1;
  else
    mu = varargin{2};
  endif

  % --- Evaluate
  phi_aux = @(r,sig,mu) exp(-1 ./ (2 .* sig.^2 * (r-mu).^2 .* (r+mu).^2));
  phi = @(r) phi_aux(r,sig,mu);
endfunction
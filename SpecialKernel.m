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
  phi_aux = @(r,sig,mu) my_func(r,sig,mu);
  phi = @(r) phi_aux(r,sig,mu);
endfunction
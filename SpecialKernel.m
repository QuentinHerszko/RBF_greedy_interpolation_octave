function [phi] = SpecialKernel(varargin)
  % --- Default
  if length(varargin) == 0
    sig = 3;
  else
    sig = varargin{1};
  endif

  % --- Evaluate
  phi_aux = @(r,sig) my_func(r,sig);
  phi = @(r) phi_aux(r,sig);
endfunction
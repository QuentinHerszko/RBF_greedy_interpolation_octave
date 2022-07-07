function [f] = my_func(r,sig,mu)
  f = zeros(length(r),1);
  for i = 1 : 1 : length(r)
    if abs(r(i)) < mu
      f(i) = exp(-1 ./ (2 .* sig.^2 .* (r(i) - mu).^2 .* (r(i) + mu).^2));
    endif
  endfor
endfunction
function [f] = my_func(r,sig)
  f = zeros(length(r),1);
  for i = 1 : 1 : length(r)
    if abs(r(i)) < sig
      f(i) = (cos(r(i)*pi/sig) + 1)/2;
    endif
  endfor
endfunction
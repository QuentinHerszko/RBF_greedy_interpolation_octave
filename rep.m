% -*- coding: UTF-8 -*-
close all
clear all

% - set interval
xx = linspace(-4,4,2000);

figure(1)
hold on
grid on

sig = [0.1 0.15 0.3 1];

for i = 1 : 1 : length(sig)
  phi = SpecialKernel(sig(i),3);
  plot(xx,phi(xx),'-','linewidth',2)
endfor

l = legend("sig = 0.1","sig = 0.15","sig = 0.3","sig = 1")
title("mu = 3")
set(l,'fontsize',15)
set(gca,'fontsize',15)
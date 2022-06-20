% -*- coding: UTF-8 -*-
clear all
close all

% ====== ====== Modified interpolation illustration

% --- Set interval
mu_max = 1;
mu_min = 0;
mu_n = 30;
mu = [linspace(mu_min, mu_max, mu_n)]';
xx = [linspace(mu_min, mu_max, mu_n*200)]';

% --- Target function
f = @(x) exp(x .* cos(3*pi.*x)) ;
%f = @(x) (sin(2*pi.*x)).^4 ./ (x+1) ;
%f = @(x) abs(x) ;
%f = @(x) x .* sin(2*x + (pi/4)) + 1;
fmu = f(mu);

% --- Greedy RBF interpolation

[gamma,sig,mu_tilde,k] = rbf_coef(mu,fmu);
yin = rbf_val(gamma,sig,mu_tilde,xx,k-1);

% --- Valeur exacte
yex = f(xx);

% --- Polyfit
p = polyfit(mu, f(mu), length(mu)-1);
ep= polyval(p, xx);

% --- Display
figure(1)
clf
hold on

% - Plots
plot(xx, yex, '-r', 'linewidth', 2)
plot(xx, yin, '--b', 'linewidth', 2)
plot(xx, ep,  '--g', 'linewidth', 2)
plot(mu, f(mu), '*k', 'markersize', 5, 'linewidth', 2)

% - Legend
l=legend('f exact', 'I_f interp', 'Polyfit', 'I.P', 'Location', 'northwest');
set(l, 'fontsize', 15);

% - Overlay
xlabel('\mu');
ylabel('f(\mu)');
title('Greedy interpolation')
set(gca, 'fontsize', 15);
% -*- coding: UTF-8 -*-
close all
clear all

mu_max = 1;
mu_min = 0;
mu_n = 10;
mu = [linspace(mu_min, mu_max, mu_n)]';
xx = [linspace(mu_min, mu_max, mu_n*200)]';

f = @(x) exp(x .* cos(3*pi.*x));

Imu = zeros(mu_n,1);

fmu = f(mu);

g = fmu - Imu;




% Le travail commence ici

[m,i] = max(g);

phi = SpecialKernel(0.3,abs(mu(i) - mu(mu_n)));

gamma = g(i) / phi(0);

I = gamma * phi(xx - mu(i));

% - calcul de l'erreur

[mup,fmup] = recherche_mup(mu,g,i);

Imup = gamma * phi(mup - mu(i));

err = sqrt( sum(fmup - Imup).^2 / length(fmup))

figure(1)
hold on
grid on

plot(xx,f(xx),'r','linewidth',2)
plot(mu,fmu,'k*','linewidth',2)
plot(xx,I,'b--','linewidth',2)


Imu = gamma * phi(mu - mu(i));
g = g - Imu;

figure(2)
hold on
grid on
plot(mu,g,'r','linewidth',2)
plot(mu,g,'b*','linewidth',2)
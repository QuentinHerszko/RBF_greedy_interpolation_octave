%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [phi] = RadialKernel(varargin)
%
% This function is used to setup the kernel for radial functions with a
% shape parameter sigma. Several functions are implemented:
%   * 'Gaussian': exp(-2*sigma*r)
%   * 'Tronc': (1-r)^sigma, -1<r<1
%   * 'MQI': 1/sqrt( 1 + (sigma*r)^2 )
%   * 'Matern0': exp(-sigma*r)
%   * 'TPS': exp(-sigma*r)*( 1 + sigma*r)
%   * 'Matern4': exp(-sigma*r)*( 3 + 3*sigma*r + (sigma*r)^2 )
%
%  input: - varargin{1}: [string] label of the kernel
%         - varargin{1}: [real,optional] shape parameter
%
% output: - phi: radial function based on the wanted kernel
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [phi] = RadialKernel(varargin)
  % === Default
  if length(varargin)==0
    varargin{1} = 'Gaussian';
  end
  
  % === Shape parameter
  if length(varargin)<=1
    sigma = 3;
  else 
    sigma = varargin{2};
  end
  
  % === Switch
  switch varargin{1}
    % --- Gaussian
    case {'Gaussian', 'Gauss', 'gaussian', 'gauss'}
      Gauss = @(r,sigma) exp(-(1/2.*sigma^2)*(r.^2));
      phi = @(r) Gauss(r,sigma);
    
    % --- Troncated
    case {'Troncated', 'Tronc', 'troncated', 'tronc'}
      Tronc = @(r,sigma) ( (abs(1-r)).^sigma ) .* (abs(r)<=1);
      phi = @(r) Tronc(r, sigma);
      
    % --- Multiquadratic inverse
    case {'MQI', 'MultiquadraticInverse', 'mqi'}
      MQI = @(r,sigma) 1/(sqrt(1+(sigma.*r).^2));
      phi = @(r) MQI(r,sigma);
      
    % --- Matern C0
    case {'Matern0', 'matern0', 'Matern', 'matern', 'm0', 'M0'}
      Matern = @(r,sigma) exp(-sigma.*r);
      phi = @(r) Matern(r,sigma);
      
    % --- Thin plate Splin
    case {'TPS', 'ThinPlateSplin', 'tps'}
      TPS = @(r,sigma) exp(-sigma.*r).*(1+sigma.*r);
      phi = @(r) TPS(r,sigma);
      
    % --- Matern C4
    case {'Matern4', 'matern4', 'm4', 'M4'}
      Matern = @(r,sigma) exp(-sigma.*r) .* (3+3*sigma.*r+(sigma.*r).^2);
      phi = @(r) Matern(r,sigma);
      
  end
  
end
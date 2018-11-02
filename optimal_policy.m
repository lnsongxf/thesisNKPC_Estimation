clear;clc;close all;
%load ('varREE.mat');

load('varBLE3.mat');

paraGrid=20; 
%   phi_y_grid = linspace(0.13,0.97,paraGrid);
%   phi_pi_grid = linspace(0.84,1.98,paraGrid);
  
  phi_y_grid = linspace(0,200,paraGrid);
  phi_pi_grid = linspace(1,200,paraGrid);

omega=.90;%weight on inflation variance;

objective_BLE=gapVar_BLE*(1-omega)+infVar_BLE*omega;
%objective_REE=gapVar_REE*(1-omega)+infVar_REE*omega;

 %minREE=min(min(objective_REE));
 %[minREE_ind(1),minREE_ind(2)]=find(objective_REE==minREE);

minBLE=min(min(objective_BLE));
[minBLE_ind(1),minBLE_ind(2)]=find(objective_BLE==minBLE);

optimalPara_BLE=[phi_y_grid(minBLE_ind(1)),phi_pi_grid(minBLE_ind(2))];
 %optimalPara_REE=[phi_y_grid(minREE_ind(1)),phi_pi_grid(minREE_ind(2))];

 %figure;mesh(phi_y_grid,phi_pi_grid,objective_REE);
% hold on;
%figure;mesh(phi_y_grid,phi_pi_grid,objective_BLE);
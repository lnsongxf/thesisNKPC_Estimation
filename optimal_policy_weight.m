%1: estimated param,twice the estimated range(st. dev implied range),size??
%2: estimated param,over the range [0,200] for y and [1,200] for pi, size 200
%3 rho_y=rho_pi=0.43,[0,10] for y and [1,50] for pi, size 100
%4 rho_y=0.33,rho_pi=0.43,,[0,100],[1,50],size 20
clear;clc;close all;
load ('varREE2.mat');
load('varBLE4.mat');

omegaGrid=200; 
paraGrid=20; 
%   phi_y_grid = linspace(0.13,0.97,paraGrid);
%   phi_pi_grid = linspace(0.84,1.98,paraGrid);
  
  phi_y_grid = linspace(0,200,paraGrid);
  phi_pi_grid = linspace(1,200,paraGrid);
  
  omega_grid=linspace(0,.99999,omegaGrid);
  
  for jj=1:omegaGrid

omega=omega_grid(jj);%weight on inflation variance;

objective_BLE=gapVar_BLE*(1-omega)+infVar_BLE*omega;
objective_REE=gapVar_REE*(1-omega)+infVar_REE*omega;

 minREE=min(min(objective_REE));
 [minREE_ind(1),minREE_ind(2)]=find(objective_REE==minREE);

minBLE=min(min(objective_BLE));
[minBLE_ind(1),minBLE_ind(2)]=find(objective_BLE==minBLE);

optimalPara_BLE(jj,:)=[phi_y_grid(minBLE_ind(1)),phi_pi_grid(minBLE_ind(2))];
optimalPara_REE(jj,:)=[phi_y_grid(minREE_ind(1)),phi_pi_grid(minREE_ind(2))];

  end
  
 %SR_BLE_pi=diff(infVar_BLE(30,1:end)').\diff(gapVar_BLE(30,1:end)');%changes in variances along phi_pi dimension
 %SR_BLE_pi(SR_BLE_pi>0)=0;%set to 0 if there is no trade-off
 %SR_BLE_y=diff(infVar_BLE(1:end,30)).\diff(gapVar_BLE(1:end,30));%changes in variances along phi_y dimension 
 %SR_BLE_y(SR_BLE_y>0)=0;%set to 0 if there is no trade-off
 
 %SR_REE_pi=diff(infVar_REE(30,1:end)').\diff(gapVar_REE(30,1:end)');%changes in variances along phi_pi dimension
 %SR_REE_pi(SR_REE_pi>0)=0;%set to 0 if there is no trade-off
 %SR_REE_y=diff(infVar_REE(1:end,30)).\diff(gapVar_REE(1:end,30));%changes in variances along phi_y dimension 
 %SR_REE_y(SR_REE_y>0)=0;%set to 0 if there is no trade-off
 
 %figure('Name','Sacrifice Ratios');
 %subplot(2,1,1);
 %plot(SR_BLE_pi,'color','black');
 %hold on;
 %plot(SR_REE_pi,'color','red');
 %legend('BLE','REE');
 %title('along \phi_y dimension');
 %subplot(2,1,2);
 %plot(SR_BLE_y,'color','black');
 %hold on;
 %plot(SR_REE_y,'color','red');
 %legend('BLE','REE');
 %title('along \phi_{\pi} dimension');
  
  figure('Name','Optimal Taylor coefficients as a function of omega');
  subplot(2,1,1);
  plot(omega_grid,optimalPara_BLE(:,1),'color','black');
  hold on;
  plot(omega_grid,optimalPara_REE(:,1),'color','red');
  legend('BLE','REE');
  title('\phi_y');
  subplot(2,1,2);
  plot(omega_grid,optimalPara_BLE(:,2),'color','black');
  hold on;
  plot(omega_grid,optimalPara_REE(:,2),'color','red');
  legend('BLE','REE');
  title('\phi_{\pi}');
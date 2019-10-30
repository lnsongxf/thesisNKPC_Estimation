%computed the underlying fixed-point (BLE) for a
%given set of parameter values. Multiplicity of 
%fixed-points can be checked using a grid of initial
%values \beta_0. 

clear;
clc;


% waitMsg=waitbar(0,'Please wait...','CreateCancelBtn',...
%             'setappdata(gcbf,''canceling'',1)');
% setappdata(waitMsg,'canceling',0);
    
%parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)rho_r (9)sigma_y (10)sigma_pinf (11) sigma_r]
%cbo estimates, multiple eqm: 
%parameters=[ 3.02         0.99      0.035      0.43        0.32            0      1.01    0.65      0.7322        0.2908   0.29];
%calibrated values: 
% parameters=[  1      0.99      0.04     0.5     0.5         0.5      1.5            0       1 0.5 0];
 parameters=[ 2.65         0.99      0.024      0.42        0.31            0.35       1.35      0.88      0.74        0.29   0.29];

%hp-filtered estimates: 
%parameters=[ 3.02         0.99      0.037      0.4267        0.3085            0.36        1.3609      0.85      0.7322        0.2908   0.29];


varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];
% varCovar=[parameters(8)^2,0;0,parameters(9)^2];
varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);
numVar=5;
grid1=30;

refLine=linspace(0,.99,grid1);

paraGrid=10;
auxVector=linspace(0.01,.5,paraGrid);
m=1;



[A, B, C, D]=NKPC_matrixConverter(parameters);


auxiliary_function=@(beta) function_g(beta,A,B,C,D,varCovar);

%  options=optimoptions('lsqnonlin',...
%      'algorithm','trust-region-reflective',...
%      'MaxFunEvals',9999,'maxIter',999,...
%  'tolFun',10e-10);


 options=optimoptions('lsqnonlin',...
     'MaxFunEvals',9999,'maxIter',999,...
 'tolFun',10e-15);


numSimul=1000;

soln=nan(numVar,numSimul);

for jj=1:numSimul
    disp(jj);
    
 soln(:,jj)=lsqnonlin(auxiliary_function,rand(numVar,1),...
    0*ones(numVar,1),ones(numVar,1),options);



end


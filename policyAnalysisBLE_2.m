
clear;
clc;


%parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)rho_r (9)sigma_y (10)sigma_pinf (11) sigma_r]
%estimated parameters:  rho_y=0.4267,rho_pinf=0.3085
%parameters=[ 3.02       0.99      0.037     0.4267     0.3085       0.4903      1.3609      0     0.7322    0.2908      0] ;
%calibrated parameters:
parameters=[  3.02           0.99      0.037      0.53         0.43            0.4         1.5      0      0.7322        0.2908   0];
numVar=5;
paraGrid=20; 
%   phi_y_grid = linspace(0.13,0.97,paraGrid);
%   phi_pi_grid = linspace(0.84,1.98,paraGrid);
  
  phi_y_grid = linspace(0,200,paraGrid);
  phi_pi_grid = linspace(1,200,paraGrid);
  
    varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];
    varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);

N=100;

gapVar_BLE=zeros(paraGrid);
infVar_BLE=zeros(paraGrid);

for y_index=1:paraGrid
    for pi_index=1:paraGrid
      
     beta=0*ones(numVar,numVar,N);
     beta(:,:,1)=0.5*eye(numVar);
    parameters(6)=phi_y_grid(y_index);
    parameters(7)=phi_pi_grid(pi_index);
    

[Atotal, Btotal, Ctotal, Dtotal]=NKPC_matrixConverter(parameters);
gamma1=Atotal\Btotal;
gamma2=Atotal\Ctotal;
gamma3=Atotal\Dtotal;




    
for i=1:N
    
    betaAux = beta(:,:,i);
%     betaAux(m,m)=beta_grid(k);
    M=gamma1+gamma2*betaAux^2;
    
vec0=(eye(numVar^2)-kron(M,M))\kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*betaAux^2))*vec0;


    for j=1:2
        beta(j,j,i+1)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
    end


end


gapVar_BLE(y_index,pi_index)=vec0(1);%first variablem variance is 1st term
infVar_BLE(y_index,pi_index)=vec0(numVar+2);%second variable, variance is 7th(2+numVar) term
ble(:,y_index,pi_index)=diag(beta(1:2,1:2,end));
disp('VARIANCES:');
disp([vec0(1) vec0(numVar+2)]);

disp('BLE:');
disp(ble(:,y_index,pi_index)');

    disp('ITERATION INDEX:')
      disp([y_index,pi_index]);
    end
       

end

    
gapVar_BLE(gapVar_BLE<0)=Inf;
infVar_BLE(infVar_BLE<0)=Inf;

    save varBLE3.mat gapVar_BLE infVar_BLE;
    


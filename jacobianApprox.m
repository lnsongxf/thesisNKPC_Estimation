clear;
clc;
 %parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)rho_r (9)sigma_y (10)sigma_pinf (11) sigma_r]
parameters=[  1        0.99      0.04     0.5      0.5       0.5       1.5           0     0.5         0.25             0] ;
varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];

varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);
numVar=5;
[Atotal, Btotal, Ctotal, Dtotal]=NKPC_matrixConverter(parameters);
gamma1=Atotal^(-1)*Btotal;
gamma2=Atotal^(-1)*Ctotal;
gamma3=Atotal^(-1)*Dtotal;
numSimul=100;
betaGrid=linspace(0,1,numSimul);
N=50;h=10e-5;
for m=1:numSimul
beta= betaGrid(m)  *diag( ones(numVar,1));

M=gamma1+gamma2*beta^2;
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*beta^2))*vec0;
for j=1:2 normalG(j)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);end

for i=1:2
    beta= betaGrid(m)  *diag( ones(numVar,1));
beta(i,i)= h+betaGrid(m) ;
M=gamma1+gamma2*beta^2;
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*beta^2))*vec0;
for j=1:2 
    perturbedG(j,i)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
   jacobian(m,j,i)=(perturbedG(j,i)-normalG(j))/h;
end
end

end
    figure
    subplot(2,2,1)
    plot(jacobian(:,1,1))
    title('G_1 \beta_1');
    subplot(2,2,2)
    plot(jacobian(:,1,2))
    title('G_2 \beta_1');
    subplot(2,2,3)
    plot(jacobian(:,2,1))
    title('G_1 \beta_2');
    subplot(2,2,4)
    plot(jacobian(:,2,2))
title('G_2 \beta_2');

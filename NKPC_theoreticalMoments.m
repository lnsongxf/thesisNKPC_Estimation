clear;
clc;

%parameters 

eps_y=1;   %sigma_1 in the paper
eps_pi=2; % sigma_2 in the paper
rho=0.5;
lambda=0.99; % fixed
psi=1; % 1/tau in the paper
gamma=0.04;
phi_pi=1.5;
phi_y=0.5; 
beta_y=0.9592;     %beta 1 in the paper 
beta_pi=0.9;   % beta 2 in the paper

eig_sum = (beta_y^2 +(gamma*psi+lambda+lambda*psi*phi_y)*beta_pi^2)/(1+gamma*psi*phi_pi+psi*phi_y);
eig_mult= (lambda*beta_y^2*beta_pi^2)/(1+gamma*psi*phi_pi+psi*phi_y);

f1 = eps_y^2* ((rho+eig_sum-lambda*beta_pi^2)*(1-lambda*beta_pi^2*(rho+eig_sum))+(lambda*beta_pi^2*(rho*eig_sum+eig_mult)-...
    rho*eig_mult)*((rho*eig_sum+eig_mult)-lambda*beta_pi^2*rho*eig_mult)) + ...
    eps_pi^2 * ((psi*phi_pi*(rho+eig_sum)-psi*beta_pi^2)*(psi*phi_pi-psi*beta_pi^2*(rho+eig_sum))+(psi*beta_pi^2*(rho*eig_sum+eig_mult)-...
psi*phi_pi*rho*eig_mult)*(psi*phi_pi*(rho*eig_sum+eig_mult)-psi*beta_pi^2*rho*eig_mult));

f2= eps_y^2 *(gamma^2*((rho+eig_sum)-rho*eig_mult*(rho*eig_sum+eig_mult)))+eps_pi^2*(((1+psi*phi_y)*(rho+eig_sum)-beta_y^2)...
    *((1+psi*phi_y)-beta_y^2*(rho+eig_sum))+(beta_y^2*(rho*eig_sum+eig_mult)-(1+psi*phi_y)*rho*eig_mult)*...
    ((1+psi*phi_y)*(rho*eig_sum+eig_mult)-beta_y^2*rho*eig_mult));


g1=eps_y^2*(((1+lambda^2*beta_pi^4)-2*lambda*beta_pi^2*(rho+eig_sum)+(1+lambda^2+beta_pi^4)*(rho*eig_sum+eig_mult))...
    -rho*eig_mult*((1+lambda^2*beta_pi^4)*(rho+eig_sum)-2*lambda*beta_pi^2*(rho*eig_sum+eig_mult)+(1+lambda^2*beta_pi^4)*rho*eig_mult))...
    +eps_pi^2*((((psi*phi_pi)^2+psi^2*beta_pi^4)-2*psi*phi_pi*psi*beta_pi^2*(rho+eig_sum)+((psi*phi_pi)^2+psi^2*beta_pi^4)*(rho*eig_sum+eig_mult))...
    -rho*eig_mult*(((psi*phi_pi)^2+psi^2*beta_pi^4)*(rho+eig_sum)-2*psi*phi_pi*psi*beta_pi^2*(rho*eig_sum+eig_mult)+((psi*phi_pi)^2+psi^2*beta_pi^4)*rho*eig_mult))








acfY = f1/g1
%  acfPi= f2/g2;
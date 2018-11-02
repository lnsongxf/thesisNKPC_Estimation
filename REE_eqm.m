 tau=5.38;
 gamma=0.06;
 rho_y=0.97;
 rho_pi=0.9;
 phi_y=0.6;
 phi_pi=1.1;
 eta_y=0.89;
 eta_pi=0.05;
 lambda=0.99;




b_coef= (1+gamma/tau*phi_pi+phi_y/tau)^-1;
 b_11 = 1;
 b_12 = (1-lambda*phi_pi)/tau;
 b_21 = gamma;
 b_22 = gamma/tau + lambda*(1+phi_y/tau);
 
 B = b_coef*[b_11,b_12;b_21,b_22];
 
 c_coef = (1+gamma/tau*phi_pi+phi_y/tau);
 c_11 = 1;
 c_12 =- phi_pi/tau;
 c_21 = gamma;
 c_22 = 1+phi_y/tau;
 C=c_coef*[c_11,c_12;c_21,c_22];
 rho=[rho_y,0;0,rho_pi];
 
 REE= ( eye(2)-rho*B)^-1*C
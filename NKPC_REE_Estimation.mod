var y pi r u_y u_pi ;
varexo eps_y eps_pi eps_r;
parameters  kappa tau phi_pi phi_y rho_y rho_pi rho_r ;
    
//estimated parameters
kappa= 0.0069; tau=4.2645;  rho_y =0.8839 ; rho_pi =0.8702; rho_r=0.85 ;
phi_y=0.4779;phi_pi=1.3773;
shocks;
var eps_y ; stderr 0.1570;
var eps_pi; stderr 0.0391;
var eps_r ; stderr 0.2991;
end;

//calibrated parameters
/*kappa= 0.04; tau=1;  rho_y =0.5 ; rho_pi =0.5; rho_r=0; 
phi_y=0.5;phi_pi=1.5;
shocks;
var eps_y ; stderr 0.5;
var eps_pi; stderr 0.25;
var eps_r ; stderr 0;
end;*/

load('policyParametersREE.mat');
phi_y=policy1;
phi_pi=policy2;

    




model(linear);
#beta=0.99;
y=y(+1)-(1/tau)*(r-pi(+1))+u_y;
pi=beta*pi(+1)+kappa*y+u_pi;
r=rho_r*r(-1)+(1-rho_r)*(phi_pi*pi+phi_y*y)+eps_r;
u_y=rho_y*u_y(-1)+eps_y;
u_pi=rho_pi*u_pi(-1)+eps_pi;

end;




stoch_simul(ar=10,nograph);



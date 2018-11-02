var y pi r u_y u_pi;
varexo eps_y eps_pi eps_r;
parameters  kappa tau phi_pi phi_y rho_y rho_pi rho_r 
beta_y beta_pi;

kappa= 0.0377 ; tau=3.0246;  rho_r =0.8547; rho_y =0.4267 ; rho_pi =0.3085; 
load('LearningNKPC.mat');
//beta_y=learningNKPC(1);
//beta_pi=learningNKPC(2);

//load('policyParametersBLE.mat');

//phi_y=policy1;
//phi_pi=policy2;

//phi_y=0.3;phi_pi=0.5;
beta_y=0.8706;beta_pi=0.7916;

phi_y=0.4903;phi_pi=1.3609;
shocks;
var eps_y ; stderr 0.7322;
var eps_pi; stderr 0.2950 ;
var eps_r ; stderr 0.2908 ;
end;




model(linear);
#beta=0.99;
#y_forecast=beta_y^2*y(-1);
#pi_forecast=beta_pi^2*pi(-1);
y=y_forecast-(1/tau)*(r-pi_forecast)+u_y;
pi=beta*pi_forecast+kappa*y+u_pi;
r=rho_r*r(-1)+(1-rho_r)*(phi_pi*pi+phi_y*y)+eps_r;
u_y=rho_y*u_y(-1)+eps_y;
u_pi=rho_pi*u_pi(-1)+eps_pi;
end;




stoch_simul(ar=10,nograph);

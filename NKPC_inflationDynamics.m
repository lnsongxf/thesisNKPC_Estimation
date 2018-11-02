clear;


beta_y  = 0.95;
beta_pi = 0.8;


tau=1;
gamma=0.04;
rho_y=0.67;
rho_pi=0.28;
rho_r=0;
phi_y=0.09;
phi_pi=5;
pi_bar=0.74;
y_bar=0.43;
r_bar=1.04;
lambda=1/(1+r_bar/100);

lagged_pi=(beta_pi^2*lambda+gamma/tau)/(1+gamma/tau*(1-rho_r)*phi_pi);
output=-(gamma/tau*(1-rho_r)*phi_y)/(1+gamma/tau*(1-rho_r)*phi_pi);
lagged_output=(gamma*beta_y^2)/(1+gamma/tau*(1-rho_r)*phi_pi);
lagged_r=- (gamma/tau)*rho_r/(1+gamma/tau*(1-rho_r)*phi_pi);
shock_pi=1/(1+gamma/tau*(1-rho_r)*phi_pi);
shock_y= -(gamma*rho_r)/(1+gamma/tau*(1-rho_r)*phi_pi);
shock_r=(-gamma/tau)/(1+gamma/tau*(1-rho_r)*phi_pi);

[lagged_pi output lagged_output lagged_r shock_pi shock_y shock_r]
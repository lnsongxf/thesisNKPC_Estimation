var 
h y pinf mc l r //latent endogenous variables>>habit, output, inflation, marg.cost, labor, interest
eps_d eps_s //exogenous shocks>>demand shock, supply shock
dy pinfobs robs; //observables>> output growth, inflation, interest rate

varexo eta_d eta_s eta_r;//exogenous shock variances>>demand,supply,policy

parameters lambda sigma_c sigma_l xi_p rho r_pi r_dy pi_bar gamma r_bar rho_d rho_s;

lambda=0.7;sigma_c=1.5;sigma_l=2;xi_p=0.75;rho=0.8;r_pi=1.5;r_dy=0.1;pi_bar=0.5;gamma=0.5;r_bar=1;rho_d=0.75;rho_s=0.75;

varobs dy pinfobs robs;
model(linear);
#beta=0.99;
y=lambda*y(-1)+(1-lambda)*h;
h=(-1/sigma_c)*(r-pinf(+1)+eps_d(+1)-eps_d)+h(+1);
pinf=beta*pinf(+1)+((1-beta*xi_p)*(1-xi_p)/xi_p)*mc;
mc=sigma_c*h+sigma_l*l-eps_s;
l=y-eps_s;
r=rho*r(-1)+(1-rho)*(r_pi*pinf+r_dy*(y-y(-1)))+eta_r;
eps_s=rho_s*eps_s(-1)+eta_s;
eps_d=rho_d*eps_d(-1)+eta_d;
dy=gamma+(y-y(-1));
pinfobs=pi_bar+pinf;
robs=r_bar+r;
end;
steady;
resid(1);

estimated_params;
stderr eta_d,0.5,0.01,20,INV_GAMMA_PDF,0.2,2;
stderr eta_s,0.5,0.01,20,INV_GAMMA_PDF,0.4,2;
stderr eta_r,0.5,0.01,20,INV_GAMMA_PDF,0.1,2;
lambda, 0.5,0,1,BETA_PDF,0.7,0.1;
sigma_c, 1.5,0,5,NORMAL_PDF,1,0.375;
sigma_l, 2,0,10,NORMAL_PDF,2,0.75;
xi_p,0.7,0,1,BETA_PDF,0.75,0.15;
r_pi,1.5,1.0,3,NORMAL_PDF,1.5,0.25;
rho,0.8258,0.5,0.975,BETA_PDF,0.8,0.10;
r_dy,0.12,0.001,0.5,NORMAL_PDF,0.125,0.05;
r_bar, 1,0,10,GAMMA_PDF,1.5,0.25;
pi_bar,0.7,0,10,GAMMA_PDF,0.5,0.15;
gamma,0.4,0,10,GAMMA_PDF,0.75,0.15;
rho_d,0.5,0,1,BETA_PDF,0.5,0.2;
rho_s,0.5,0,1,BETA_PDF,0.5,0.2;
end;





estimation(
	nograph,
	nodiagnostic,
	optim=('Algorithm','active-set'),
	datafile='newest_dataset' ,
	mode_compute=1,
	first_obs=44,
	//presample=1,
   //lik_init=1,
	prefilter=0,
    mh_replic=0,
    mh_nblocks=2,
    mh_jscale=0.55,
    mh_drop=0.2
);
stoch_simul(nograph,ar=10) ;





%%  Multiple Equilibrium Analysis
fixedPoint_1dim;
clearvars -except betaConverged;

parameters=[ 0.99       0.075     0.0004 0.9     0.01         0.003162] ;
beta_Star= [.3066;.7417;.9961];

delta=parameters(1); gamma=parameters(2); a=parameters(3) ; rho=parameters(4); sigma_eps=parameters(5); sigma_u=parameters(6);


F = @(beta) delta*beta^2 + (gamma^2*rho*(1-delta^2*beta^4) )...
    / (gamma^2*(delta*beta^2*rho+1)+(1-rho^2)*(1-delta*beta^2*rho)*(sigma_u^2/sigma_eps^2));

N=50;
h=10e-5;
numGrid=100;
beta_initGrid=linspace(0,0.9999,numGrid);
convergencePlot=figure;


beta=0*ones(N,1);

  for j=1:numGrid
   
   fBeta(j)=F(beta_initGrid(j));   
   
  end

plot(fBeta,beta_initGrid);
hold on
plot(beta_initGrid,beta_initGrid);
hold on

for j=1:length(betaConverged)
    scatter(betaConverged(j,:),betaConverged(j,:),'black');
    hold on
end



% Multiple Equilibrium Analysis for the 1-dimensional
%NKPC example in Hommes \& Zhu. This file includes
%both the Newton iteration (which computes all roots
%of G(\beta)=\beta), and the fixed-point iteration 
%(which computes only the E-stable roots). Parameter
%values are set to the calibration in the original
%pape. 

clear;
clc;

parameters=[ 0.99       0.075     0.0004 0.9     0.01         0.003162] ;
beta_Star= [.3066;.7417;.9961];

delta=parameters(1); gamma=parameters(2); a=parameters(3) ; rho=parameters(4); sigma_eps=parameters(5); sigma_u=parameters(6);


F = @(beta) delta*beta^2 + (gamma^2*rho*(1-delta^2*beta^4) )...
    / (gamma^2*(delta*beta^2*rho+1)+(1-rho^2)*(1-delta*beta^2*rho)*(sigma_u^2/sigma_eps^2));

N=200;
h=1e-8;
numGrid=100;
beta_initGrid=linspace(0.5,0.7,numGrid);
betaConverged=nan(numGrid,1);
convergencePlot=figure;

for j=1:numGrid
    disp(j)
beta=0*ones(N,1);
beta(1) = beta_initGrid(j);
  for i=1:N
 dampingFactor=0.1;
 %Naive Iteration     
 % beta(i+1)=F(beta(i));     
 % beta(i+1)=beta(i) + dampingFactor*(F(beta(i))-beta(i));     
 
%Newtonian Iteration 
 fPrime= (F(beta(i)+h)-F(beta(i)) )/h;
 beta(i+1)=beta(i)-(1-fPrime)^(-1)*(beta(i)-F(beta(i)));
 %beta(i+1)=(1-fPrime^(-1))^(-1)*(beta(i)-fPrime^(-1)*F(beta(i)));
%beta(beta>1)=nan;
%beta(beta<-1)=nan;

  end
betaConverged(j)=beta(end);
figure(convergencePlot)  
plot(beta,'lineWidth',1.5,'color','black');
ylim([0 1]);
drawnow;
hold on

end
figure(convergencePlot)
scatter([N;N;N],beta_Star,100,'o','filled','red');
xlabel('Number of Iterations');
ylabel('\beta_{\pi}');
ylim([0 1]);

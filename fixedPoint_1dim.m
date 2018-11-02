%%  Multiple Equilibrium Analysis

clear;
clc;

parameters=[ 0.99       0.075     0.0004 0.9     0.01         0.003162] ;
beta_Star= [.3066;.7417;.9961];

delta=parameters(1); gamma=parameters(2); a=parameters(3) ; rho=parameters(4); sigma_eps=parameters(5); sigma_u=parameters(6);


F = @(beta) delta*beta^2 + (gamma^2*rho*(1-delta^2*beta^4) )...
    / (gamma^2*(delta*beta^2*rho+1)+(1-rho^2)*(1-delta*beta^2*rho)*(sigma_u^2/sigma_eps^2));

N=1000;
h=10e-5;
numGrid=500;
beta_initGrid=linspace(0,0.99,numGrid);
convergencePlot=figure;

for j=1:numGrid
beta=0*ones(N,1);
beta(1) = beta_initGrid(j);
  for i=1:N
 dampingFactor=0.1;
 %Naive Iteration     
 % beta(i+1)=F(beta(i));     
 % beta(i+1)=beta(i) + dampingFactor*(F(beta(i))-beta(i));     
 
%Newtonian Iteration 
 fPrime= (F(beta(i)+h)-F(beta(i)) )/h;
 beta(i+1)=(1-fPrime^(-1))^(-1)*(beta(i)-fPrime^(-1)*F(beta(i)));
if beta(i+1)>1 || beta(i+1)<-1
    beta=nan;
    break;
end
  end
betaConverged(j,:)=beta;
figure(convergencePlot)  
plot(beta,'lineWidth',1.5,'color','black');
drawnow;
hold on

end
figure(convergencePlot)
scatter([N;N;N],beta_Star,100,'o','filled','red');
xlabel('Number of Iterations');
ylabel('\beta_{\pi}');

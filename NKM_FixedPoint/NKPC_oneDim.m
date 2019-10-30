clear;
clc;close all;

%initialize variables:
N = 10000;
% pi= NaN * zeros(N,1); %inflation
% %pi_expected = NaN * zeros(N,1) % one-period ahead expectation
% y = NaN * zeros(N,1) ; %output gap
% alpha = NaN*zeros(N,1);
% beta = NaN*zeros(N,1);
% R = NaN*zeros(N,1);
%  
delta = 0.99; %subjective discount factor
gamma = 0.075; %price stickiness
rho = 0.9 ; %persistence
a = 0.0004 ;
sigma_epsilon = 0.01 ;
sigma_u = 0.003162 ;
crit=10e3;
%betas at these values: 0.3066, 0.9961
burnIn=50;
numSimulations=1;







index=1;


% h=waitbar(0,'Computing MC Simulations...');
for j=1:numSimulations
    
    
    for i=1:N
epsilon(i) =normrnd(0,sigma_epsilon); %demand shock
u(i) =normrnd(0,sigma_u) ; %mark-up shock
end
    

 initial = 1*(rand(5,1)-0.5*ones(5,1));

% pi(1) = 0.5;
% y(1) = 0.5;
% alpha(1) = pi(1);
% beta(1) = 0;
% R(1) = 0;   


pi(1)=initial(1);
y(1)=initial(2);
alpha=initial(3);
beta=initial(4);
R = initial(5);



dist=1;

i=2;
%  while dist>10e-8
     for i=2:N
         gain=0.01;
     
 oldNorm=abs(alpha)+abs(beta);    
  
 y(i) = a+rho*y(i-1)+epsilon(i) ;
 pi(i) = delta*(alpha+ (beta^2)*(pi(i-1)-alpha))+gamma*y(i)+u(i);  
 
 
 %[alpha,beta]=learning_update(pi,i);
 [alpha,beta,R]=sac_cgl_learning(pi(i),pi(i-1),alpha,beta,R,gain);
 learning(i,:)=[alpha,beta];
 
%   [alpha,beta,R]=recursive_update(pi,i,alpha,beta,R);

%  alpha(i) =alpha(i-1)+(1/(i))*(pi(i)-alpha(i-1));
%  R(i)= R(i-1)+ (1/(i))*(   ((i-1)/(i))*(pi(i)-alpha(i-1))^2-R(i-1));
%  beta(i)=beta(i-1)+(1/(i))*(1/R(i))*(              (pi(i)-alpha(i-1))*(          pi(i-1)+pi(1)/(i)-(((i-1)^2+3*(i-1)+1)/(i)^2)*alpha(i-1)-pi(i)/((i)^2)) - ((i-1)/i)*beta(i-1)*(pi(i)-alpha(i-1))^2 );
%     




newNorm=abs(alpha)+abs(beta);

dist= abs(oldNorm-newNorm);

% i=i+1;
% if i>N-10
%     break
% end
disp(j);
disp(i);



    
end
 

% if i<N-10
    
 alphaConverged(index) = alpha;
 betaConverged(index)  = beta ; 
 index=index+1;
% end
 
 %clearvars alpha beta R y pi oldNorm newNorm ;
%  waitbar(j/numSimulations);
 
 
end

%REE
for i=2:N
    pi_REE(i)=(gamma*delta*a)/((1-delta)*(1-delta*rho))+y(i)*gamma/(1-delta*rho)+u(i);
end
plot(pi(end-500:end),'-','lineWidth',2)
hold on;
plot(pi_REE(end-500:end),':','lineWidth',2,'color','green');
legend('BLE','REE');
xlim([0 500]);

figure;
subplot(2,1,1);
plot(learning(:,1));
subplot(2,1,2);
plot(learning(:,2));
% close(h);
% alphaConverged=alphaConverged+mean(alphaConverged)
% 
% 
% 
% betaTh=[0.3066 0.9961];
% figure
% subplot(2,1,1)
% hist(alphaConverged);
% hold on
% xlim([-1 1]);
% ylim([0 250]);
% 
% hold on
% plot([0.03 0.03],[0 250]);
% subplot(2,1,2)
% hist(betaConverged,20);
% hold on
% plot([betaTh(1) betaTh(1)],[0 150]);
% hold on
% plot([betaTh(2) betaTh(2)],[0 150]);
% xlim([-1 1])
% % 
% % 
% 




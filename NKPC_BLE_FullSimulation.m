clear;
clc;
tic

%parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)sigma_y (9)sigma_pinf]
parameters=[    1      0.9900   0.035     0.43          0.32       0.49       1.36        0.5           1 ]

% grid=20;
numSimulations=1;

% rho_pinf_grid = linspace(1,2,grid);

% for j=1:grid
    
%     parameters(7)=rho_pinf_grid(j);

sigma_y = parameters(end-1);
sigma_pinf=parameters(end);

[Atotal Btotal Ctotal Dtotal]= NKPC_matrixConverter(parameters);
N=10000;





for m=1:numSimulations
    seed=m;
rng(seed);
    

Xtotal(:,1)=rand(5,1);

auxLearning=rand(6,1);

alpha1=auxLearning(1), beta1=auxLearning(2), r1=auxLearning(3);
alpha2=auxLearning(4), beta2=auxLearning(5), r2=auxLearning(6);


learning1(1,:)= [alpha1,beta1];
learning2(1,:)= [alpha2,beta2];



alpha=[alpha1;alpha2];
beta=diag([beta1;beta2]);

betaShocks=zeros(2,1);

alphaTotal=[alpha',0,0,0]';
betaTotal=[beta,zeros(2,3);zeros(3,5)]';
       
eps_y = normrnd(0,sigma_y,[N,1]);
eps_pinf = normrnd(0,sigma_pinf,[N,1]);      

errors=[eps_y eps_pinf]' ; 

Atotal_inv = Atotal^(-1);
dist=2;
t=2;



%    while dist>10e-5
for t=2:N
disp(t);
      Xtotal(:,t) =  Atotal_inv * ( Btotal*Xtotal(:,t-1)+Ctotal*(alphaTotal+betaTotal^2*(Xtotal(:,t-1)-alphaTotal))+...
      Dtotal*errors(:,t)     ) ;
  
  
%     oldMag=norm(beta1)+norm(beta2);
    oldMag=norm(beta1)+norm(beta2)+norm(alpha1)+norm(alpha2);
 
 
%  [alpha1,beta1,r1]=recursive_update(Xtotal(1,:),t,alpha1,beta1,r1);
%  [alpha2,beta2,r2]=recursive_update(Xtotal(2,:),t,alpha2,beta2,r2);
 
 [alpha1,beta1]=learning_update(Xtotal(1,:),t);
 [alpha2,beta2]=learning_update(Xtotal(2,:),t);
 
alpha=[alpha1;alpha2];
beta=diag([beta1;beta2]);
 
alphaTotal=[alpha',0,0,0]';
betaTotal=[beta,zeros(2,3);zeros(3,5)]';



learning1(t,:)= [alpha1,beta1];
learning2(t,:)= [alpha2,beta2];

% newMag = norm(beta1)+norm(beta2);
newMag = norm(beta1)+norm(beta2)+norm(alpha1)+norm(alpha2);

dist=norm(oldMag-newMag);
%    t=t+1;
%  if newMag>10e2
%      break
%  end
% 
%         Determinacy_x= Atotal_inv *(Btotal + Ctotal*betaTotal.^2);
%        eigenvalues_x(t) = abs((eigs(Determinacy_x,1)));

     
   end
 
   
   
acfY(m,:)=autocorr(Xtotal(1,:),10);
acfPinf(m,:)=autocorr(Xtotal(2,:),10);
meanY(m)=mean(Xtotal(1,:));
meanPinf(m)=mean(Xtotal(2,:));
     
end


[alpha' beta(1,1) beta(2,2) var(Xtotal(1,:)) var(Xtotal(2,:))]
% 
% 
% figure
%  plot(eigenvalues_x(10:N)); 
%  hold on
%  plot(ones(N-10+1));
%  xlabel('t');
%          title('Largest Eigenvalue of the System (In Absolute Value)');
% ylim([0.98 1]);

% alphaTh=[0 0];
% betaTh=[0.9 0.9592];
% subplot(2,2,1)
% hist(acfY(:,2))
% hold on
% plot([betaTh(1) betaTh(1)], [0 600]);
% xlim([0 1])
% 
% subplot(2,2,2)
% hist(acfPinf(:,2))
% hold on
% plot([betaTh(1) betaTh(1)], [0 800]);
% xlim([0 1])
% 
% subplot(2,2,3)
% hist(meanY)
% hold on
% plot([alphaTh(1) alphaTh(1)], [0 600]);
% xlim([-2 2])
% 
% subplot(2,2,4)
% hist(meanPinf)
% hold on
% plot([alphaTh(2) alphaTh(2)], [0 600]);
% xlim([-2 2])
% 
% [median(acfY(:,2)), median(acfPinf(:,2)), mean(meanY), mean(meanPinf)]
% 
% [mean(acfY(:,2)), mean(acfPinf(:,2)), mean(meanY), mean(meanPinf)]
% 
% transitionFunc(j)=mean(acfPinf(:,2));
% 
% % end
% plot(transitionFunc);
toc

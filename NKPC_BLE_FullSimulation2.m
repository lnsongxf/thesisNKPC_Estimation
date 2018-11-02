clear;
clc;
tic
%parameters=[(1)tau (2)gamma (3)rho_y (4)rho_pinf (5) rho_r (6) phi_y 
%(7)phi_pinf (8)pi_bar (9)y_bar (10)r_bar  (11) sigma_y (12) sigma_pinf (13) sigma_r]

parameters=[  3.02       0.99      0.035     0.43      0.32       0.49      1.36      0.85     0.73    0.29       0.29] ;


numSimulations=1000;
alphaTh=[0,0];
betaTh=[0.8835,0.8944];

sigma_y = parameters(end-2);
sigma_pinf=parameters(end-1);
sigma_r=parameters(end);

[Atotal Btotal Ctotal Dtotal]= NKPC_matrixConverter(parameters);
N=10000;
 gain=0.001;





for m=1:numSimulations
    disp(m)
    seed=m^2;
rng(seed);
    

Xtotal(:,1)=zeros(5,1);

auxLearning=rand(6,1);

alpha1=0; beta1=(1-0.25*rand(1)); r1=100;
alpha2=0; beta2=(1-0.25*rand(1)); r2=100;


learning1(1,:)= [alpha1,beta1];
learning2(1,:)= [alpha2,beta2];



alpha=[alpha1;alpha2];
beta=diag([beta1;beta2]);

betaShocks=zeros(2,1);

alphaTotal=[alpha',0,0,0]';
betaTotal=[beta,zeros(2,3);zeros(3,5)]';
       
eps_y = normrnd(0,sigma_y,[N,1]);
eps_pinf = normrnd(0,sigma_pinf,[N,1]);    
eps_r = normrnd(0,sigma_r,[N,1]);

errors=[eps_y eps_pinf eps_r]' ; 

Atotal_inv = Atotal^(-1);



    for t=2:N
% gain=1/t;

      Xtotal(:,t) =  Atotal_inv * ( Btotal*Xtotal(:,t-1)+Ctotal*(alphaTotal+betaTotal^2*(Xtotal(:,t-1)-alphaTotal))+...
      Dtotal*errors(:,t)     ) ;
  

%  
%  [alpha1,beta1,r1]=recursive_update(Xtotal(1,1:t),t,alpha1,beta1,r1);
%  [alpha2,beta2,r2]=recursive_update(Xtotal(2,1:t),t,alpha2,beta2,r2);
[alpha1,beta1,r1]=cgl_learning_recursive(Xtotal(1,t),Xtotal(1,t-1),alpha1,beta1,r1,gain);
 [alpha2,beta2,r2]=cgl_learning_recursive(Xtotal(2,t),Xtotal(2,t-1),alpha2,beta2,r2,gain);
% alpha1=0;alpha2=0;
%  [alpha1,beta1]=learning_update(Xtotal(1,:),t);
%  [alpha2,beta2]=learning_update(Xtotal(2,:),t);
 
alpha=[alpha1;alpha2];
beta=diag([beta1;beta2]);
 
alphaTotal=[alpha',0,0,0]';
betaTotal=[beta,zeros(2,3);zeros(3,5)]';



learning1(t,:)= [alpha1,beta1];
learning2(t,:)= [alpha2,beta2];


     
   end
 
   
   
acfY(m)=mean(learning1(end-500:end,2));
acfPinf(m)=mean(learning2(end-500:end,2));
meanY(m)=mean(learning1(end-500:end,1));
meanPinf(m)=mean(learning2(end-500:end,1));
     disp([alpha1 alpha2 beta1 beta2]);
end

[dip,p_value_Y, xlow_y,xup_y]=HartigansDipSignifTest(acfY,1000);
[dip,p_value_pi, xlow_pi,xup_pi]=HartigansDipSignifTest(acfPinf,1000);

peak=0.2;
 subplot(2,1,1);
[f,xi] = ksdensity(acfY);

histogram(acfY,'normalization','probability','FaceColor','black');
yy=ylim;yy=yy(2);
hold on;
plot(xi,f*yy/max(f));
 hold on
 yy=ylim;
plot([betaTh(1) betaTh(1)],yy,'color','red','lineStyle','--');


% ylim([ymin ymax]);
%xlim([0 1])

subplot(2,1,2)
[f,xi] = ksdensity(acfPinf);

% plot(xi,f/100,'lineWidth',3);
% hold on
% histfit(acfPinf);
% hold on;
histogram(acfPinf,'normalization','probability','FaceColor','black');
yy=ylim;yy=yy(2);
hold on;
plot(xi,f*yy/max(f));

yy=ylim;
hold on
plot([betaTh(2) betaTh(2)],yy,'color','red','lineStyle','--');
xx=xlim;xlow=xx(1);
xlim([xlow,1]);


fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'NKPC_MC_cgl','-dpdf');









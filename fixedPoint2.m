%  Multiple Equilibrium Analysis
%
% the script for plotting the betas on top of fixedPoint.m
    % for i=1:20
    % betaY_naive(i)=beta2Copy(1,1,i);betaPi_naive(i)=beta2Copy(2,2,i);
    % betaY_newt(i)=betaCopy(1,1,i);betaPi_newt(i)=betaCopy(2,2,i);
    % end
    % fig=gcf;
    % figure(fig)
    % plot(betaY_newt,betaPi_newt,'green','lineWidth',1.5);hold on;scatter(betaY_newt,betaPi_newt,25,'x','green')
    % plot(betaY_naive,betaPi_naive,'black','lineWidth',1.5);hold on;scatter(betaY_naive,betaPi_naive,25,'o','filled','black');
%
clear;
clc;

% waitMsg=waitbar(0,'Please wait...','CreateCancelBtn',...
%             'setappdata(gcbf,''canceling'',1)');
% setappdata(waitMsg,'canceling',0);
    load('estimatedPara.mat');%order in this file: y_bar pi_bar r_bar kappa tau phi_pi phi_y rho_y rho_pi rho_r
    
 it=7;
parameters = [estimatedPara(8,it) 0.99 estimatedPara(7,it) estimatedPara(11,it) estimatedPara(12,it) estimatedPara(10,it) estimatedPara(9,it)...
    estimatedPara(13,it) estimatedPara(1,it) estimatedPara(2,it) estimatedPara(3,it)];
%parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)rho_r (9)sigma_y (10)sigma_pinf (11) sigma_r]
%parameters=[  2.99        0.99      0.032     0.42      0.31       0.48       1.36           0.85     0.73         0.29             0.3] ;
% parameters=[  1      0.99      0.04     0.5     0.5         0.5      1.5            0       0.25 ];

varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];
% varCovar=[parameters(8)^2,0;0,parameters(9)^2];
varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);
numVar=5;
grid1=15;
beta_y_naive=figure;beta_pi_naive=figure;beta_y_newt=figure;beta_pi_newt=figure;

refLine=linspace(0,.99,grid1);
beta_grid=linspace(0,.99,grid1);
paraGrid=10;
auxVector=linspace(0.01,.5,paraGrid);
m=1;

phi_y_grid=linspace(0.2,.99,grid1);
phi_pi_grid=linspace(1,5,grid1);


betaGapConverged=zeros(grid1,grid1);
betaPiConverged=zeros(grid1,grid1);
varGapConverged=zeros(grid1,grid1);
varPiConverged=zeros(grid1,grid1);
k=1;l=1;
% 
% for k=1:grid1
%     for l=1:grid1
%         waitbar((grid1*k+l)/grid1^2);
%         
%     if getappdata(waitMsg,'canceling')
%           delete(waitMsg);      
%         break
%        
%     end
        
%         parameters(6)=phi_y_grid(k);
%         parameters(7)=phi_pi_grid(l);

[Atotal, Btotal, Ctotal, Dtotal]=NKPC_matrixConverter(parameters);
gamma1=Atotal^(-1)*Btotal;
gamma2=Atotal^(-1)*Ctotal;
gamma3=Atotal^(-1)*Dtotal;


% Convergence Analysis

N=500;
grid=1;
beta=0*ones(numVar,numVar,N);
beta2=0*ones(numVar,numVar,N);
betaGrid=linspace(0,0.99,grid);
for k=1:grid
    
% beta(:,:,1) = betaGrid(k) *diag( ones(numVar,1));
% beta2(:,:,1)= betaGrid(k)  *diag( ones(numVar,1));
% beta(:,:,1) = 0.5 *diag( ones(numVar,1));
% beta2(:,:,1)= 0.5  *diag( ones(numVar,1));


% % for m=1:2
%     for k=1:grid1
    
    
for i=1:N
    
    betaAux1 = beta(:,:,i);
%     betaAux(m,m)=beta_grid(k);
    M1=gamma1+gamma2*betaAux1^2;
    
vec0_1=(eye(numVar^2)-kron(M1,M1))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1_1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*betaAux1^2))*vec0_1;

    betaAux2 = beta2(:,:,i);
%     betaAux(m,m)=beta_grid(k);
    M2=gamma1+gamma2*betaAux2^2;
    
vec0_2=(eye(numVar^2)-kron(M2,M2))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1_2=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*betaAux2^2))*vec0_2;


DGbeta(:,:,i) = jacobianSolver( beta,gamma1,gamma2,gamma3,varCovar_vec,i ); 
miniJacobian=DGbeta(1:2,1:2,i);
JacobianInverse=miniJacobian^(-1);
 

% for j=3:numVar
% beta(j,j,i+1)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
% end

tempBeta=(eye(2)-JacobianInverse)^(-1)* ...
    ([beta(1,1,i);beta(2,2,i)]-JacobianInverse*[vec1_1( (1-1)*numVar+1)/vec0_1( (1-1)*numVar+1);vec1_1( (2-1)*numVar+2)/vec0_1( (2-1)*numVar+2)]);
beta(1,1,i+1)=tempBeta(1);beta(2,2,i+1)=tempBeta(2);




    
% for j=1:numVar
%     if i>1
%    dx=(beta(j,j,i)-beta(j,j,i-1)+10e-5 )/(beta(j,j,i)-beta(j,j,1)+10e-5);else dx=5;
%     end
% 
%     beta(j,j,i+1)=dx/(1+dx)*(beta(j,j,i) +1/dx*(vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j)));
%     
% end
    
% for j=1:numVar
%     if i>2
%     beta(j,j,i+1)=(1/(1+beta(j,j,i)-beta(j,j,i-1)))* (vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j))...
%         +(1-1/(1+beta(j,j,i)-beta(j,j,i-1)))*beta(j,j,i);
%     else    beta(j,j,i+1)=0.5* (vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j))...
%         +0.5*beta(j,j,i);
%     end
% end
    
     for j=1:numVar
      beta2(j,j,i+1)=vec1_2( (j-1)*numVar+j)/vec0_2( (j-1)*numVar+j);
     
     end
end

for j=1:2
for i=1:N
    betaTemp2(i,j,k)=beta(j,j,i);
    betaTemp1(i,j,k)=beta2(j,j,i);
    
    if betaTemp2(i,j,k)<-1 || betaTemp2(i,j,k)>1 
        betaTemp2(:,j,k)=nan;
    end
    
    if betaTemp1(i,j,k)<-1 || betaTemp1(i,j,k)>1 
        betaTemp1(:,j,k)=nan;
    end
    
end
end
figure(beta_y_naive)
plot(betaTemp1(:,1,k),'black','lineWidth',1.5);
% title('Naive Iteration');
xlabel('Number of Iterations','fontSize',15);
ylabel('\beta_y','fontSize',15);
hold on
figure(beta_pi_naive)
plot(betaTemp1(:,2,k),'black','lineWidth',1.5);
%title('Naive Iteration');
xlabel('Number of Iterations','fontSize',15)
ylabel('\beta_{\pi}','fontSize',15);
hold on
figure(beta_y_newt)
%title('Newtonian Iteration');
plot(betaTemp2(:,1,k),'black','lineWidth',1.5);
xlabel('Number of Iterations','fontSize',15);
ylabel('\beta_y','fontSize',15);
hold on
figure(beta_pi_newt)
%title('Newtonian Iteration');
plot(betaTemp2(:,2,k),'black','lineWidth',1.5);
xlabel('Number of Iterations','fontSize',15);
ylabel('\beta_{\pi}','fontSize',15);
hold on

end


    
[beta(1,1,end) beta(2,2,end)]
[beta2(1,1,end) beta2(2,2,end) ]
% if m==1
%     piStar(k)=beta(2,2,end);
% else gapStar(k)=beta(1,1,end);
% end
% 
%     end
% end
% figure
% plot(beta_grid,piStar);
% hold on
% plot(gapStar,beta_grid);
% xlim([0 beta_grid(end)]);ylim([0 beta_grid(end)]);
% 
% star1=[beta_grid;piStar];star1=star1';
% star2=[gapStar;beta_grid];star2=star2';
% 
% 
% 
% BLE=InterX(star1',star2')

% end
% 
% betaGapConverged(k,l)=beta(1,1,N);
% betaPiConverged(k,l)=beta(2,2,N);
% 
% varGapConverged(k,l)= vec0(numVar*(1-1)+1);
% varPiConverged(k,l) = vec0(numVar*(2-1)+2);
% %     end
% % end
% % delete(waitMsg);
% 
% [betaGapConverged(k,l),betaPiConverged(k,l),varGapConverged(k,l),varPiConverged(k,l)]
% 
% % infVar_BLE=varPiConverged;
% % gapVar_BLE=varGapConverged;
% % save varBLE.mat infVar_BLE gapVar_BLE;
% 
% 
% % 
% %         figure
%       
% %            subplot(1,2,1);
% % surf(phi_pi_grid,phi_y_grid,varPiConverged,'faceColor',[0 0 1]);
% %      
% %            zlim([0 Inf]);
% %            xlim([min(phi_pi_grid) max(phi_pi_grid)])
% %            ylim([min(phi_y_grid) max(phi_y_grid)])
% %           xlabel('\phi_{\pi}');
% %           ylabel('\phi_{y}');
% %           zlabel('Variance of Inflation');
% % 
% %            
% %            title('Variance of Inflation');
% %            subplot(1,2,2);
% %       
% %            surf(phi_pi_grid,phi_y_grid,varGapConverged,'faceColor',[0 0 1]);
% %            title('Variance of Output Gap');
% %   
% %            zlim([0 Inf]);
% %            xlim([min(phi_pi_grid) max(phi_pi_grid)])
% %            ylim([min(phi_y_grid) max(phi_y_grid)])
% %           xlabel('\phi_{\pi}');
% %           ylabel('\phi_{y}');
% %           zlabel('Variance of Output Gap');
% 
% 
% %  subplot(paraGrid/5,paraGrid/4,k)
% % 
% % plot(beta_pi_grid,betaPiConverged);
% % hold on
% % plot(beta_y_grid,refLine);
% % 
% % ylim([0 1])
% 
% % end
% 
% 
% 
% % plot(beta_pi_grid,betaPiConverged);
% % hold on
% % plot(beta_pi_grid,refLine);
% % 
% % ylim([0 1])
% 
% 
% 
% % 
% % % plot beta_y and beta_pinf respectively: These plots are for illustrative
% % % purposes to show convergence
% % for i=1:N
% % beta_y(i)=beta(1,1,i);
% % beta_pi(i)=(beta(2,2,i));
% % end
% % 
% % plot(beta_y)
% % hold on
% % plot(beta_pi)
% legend('beta y', 'beta pinf');



% % 
% for i=1:grid1
%     for j=1:grid1
% %     
%     betaAux=diag([beta_y_grid(i) beta_pi_grid(j) 0 0 0]);
% %     
%      M=gamma0+gamma1*betaAux^2;
%      vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma2,gamma2)*varCovar_vec;
%      vec1=(kron(eye(numVar),gamma0)+kron(eye(numVar),gamma1*betaAux^2))*vec0;
% % 
% % 
%    for k=1:numVar
%       betaResult(k,k,(i-1)*grid1+j)=vec1( (k-1)*numVar+k)/vec0( (k-1)*numVar+k);
%    end
% %      
% 
% beta_y(i,j) = betaResult(1,1,(i-1)*grid1+j)
% beta_pi(i,j)= betaResult(2,2,(i-1)*grid1+j)
% 
% end
% end
% 
% 
% [minGap,minGapInd]=min(beta_y-repmat(refLine,[grid1,1])')
% [minInf,minInfInd]=min(beta_pi'-repmat(refLine,[grid1,1])')
% 
% for i=1:grid1
% 
%     starGap(i) = beta_y(minGapInd(i),i);
%     starInf(i) = beta_pi(i,minInfInd(i));
% end
% 
% starGap=smooth(starGap);
% starGap=smooth(starGap);
% starInf=smooth(starInf);
% starInf=smooth(starInf);
% 
% 
%  subplot(paraGrid/5,paraGrid/2,g)
% 
% plot(beta_pi_grid,starInf);
% hold on
% plot(starGap,beta_y_grid);
% hold on
% ylim([0 1])
% 
% 
% end

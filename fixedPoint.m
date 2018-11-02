%  Multiple Equilibrium Analysis

clear;
clc;


% waitMsg=waitbar(0,'Please wait...','CreateCancelBtn',...
%             'setappdata(gcbf,''canceling'',1)');
% setappdata(waitMsg,'canceling',0);
    
%parameters=[(1)tau (2)lambda (3)gamma (4)rho_y (5)rho_pinf (6)phi_y (7)phi_pinf (8)rho_r (9)sigma_y (10)sigma_pinf (11) sigma_r]
parameters=[  3.02       0.99      0.035     0.43      0.312       0.49      1.36      0.7     0.73    0.29       0.3] ;
% parameters=[  1      0.99      0.04     0.5     0.5         0.5      1.5            0       0.25 ];

varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];
% varCovar=[parameters(8)^2,0;0,parameters(9)^2];
varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);
numVar=5;
grid1=20;


refLine=linspace(0,.99,grid1);

paraGrid=10;
auxVector=linspace(0.01,.5,paraGrid);
m=1;



[Atotal, Btotal, Ctotal, Dtotal]=NKPC_matrixConverter(parameters);
gamma1=Atotal^(-1)*Btotal;
gamma2=Atotal^(-1)*Ctotal;
gamma3=Atotal^(-1)*Dtotal;


% Convergence Analysis

N=200;
numBetaGrid=30;
beta_grid=linspace(0,0.99,numBetaGrid);
beta_y=nan(N,numBetaGrid);
beta_pi=nan(N,numBetaGrid);

    for mm=1:numBetaGrid
        disp(mm)
        beta=0*ones(numVar,numVar,N);
beta(:,:,1) = beta_grid(mm)   *diag( ones(numVar,1));
    
for i=1:N
    
    betaAux = beta(:,:,i);
%     betaAux(m,m)=beta_grid(k);
    M=gamma1+gamma2*betaAux^2;
    
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*betaAux^2))*vec0;


    for j=1:2
        beta(j,j,i+1)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
    end


end
beta_y(:,mm)=squeeze(beta(1,1,1:end-1));
beta_pi(:,mm)=squeeze(beta(2,2,1:end-1));

    end
    
figure;
subplot(1,2,1);
for jj=1:numBetaGrid;
    plot(beta_y(:,jj),'color','black');
    hold on;
end
xlim([0 N]);
hold off;

subplot(1,2,2);
for jj=1:numBetaGrid;
    plot(beta_pi(:,jj),'color','black');
    hold on;
end
xlim([0 N]);
hold off;

fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'NKPC_estimated_fixedPoint_iter','-dpdf');
    
    
% 
% varGapConverged(k,l)= vec0(numVar*(1-1)+1);
% varPiConverged(k,l) = vec0(numVar*(2-1)+2);

%     end
% % end
% infVar_BLE=varPiConverged;
% gapVar_BLE=varGapConverged;
% save varBLE.mat infVar_BLE gapVar_BLE;
% gapVar_BLE(1,1) 
% infVar_BLE(1,1)
% figure;
% subplot(2,1,1)
% plot(squeeze(beta(1,1,:)));
% subplot(2,1,2);
% plot(squeeze(beta(2,2,:)));

% figure
% plot(beta_grid,piStar,'lineWidth',2.5);
% hold on
% plot(gapStar,beta_grid,'lineWidth',2.5);
% xlim([0 beta_grid(end)]);ylim([0 beta_grid(end)]);
% 
% star1=[beta_grid;piStar];star1=star1';
% star2=[gapStar;beta_grid];star2=star2';



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
% infVar_BLE=varPiConverged;
% gapVar_BLE=varGapConverged;
% save varBLE.mat infVar_BLE gapVar_BLE;
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

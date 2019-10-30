
%parameters=[beta y_bar pi_bar r_bar kappa tau phi_pi phi_y rho_y rho_pi rho_r
%eps_y eps_pi eps_r
clear;clc;%close all;
paraNo=3;
gridLength=20;
gridUpper=0.05;
gridLower=0.001;
paraGrid=linspace(gridLower,gridUpper,gridLength);
% parameters=[0.5880 0.6671 0.8063 0.01 3 1.5 0.55 0.75 0.75 0.8 0.7 0.3 0.3];
%parameters=[ 2.65         0.99      0.024     0.42       0.31      0.36       1.41      0.88      0.74        0.29  0.29];%CBO ESTIMATES
%parameters=[ 2.92         0.99      0.017     0.42       0.31      0.22       1.44      0.88      0.78        0.3   0.3];%de-trended output
%parameters=[ 3.02         0.99      0.035    0.43        0.32      0.49       1.36      0.85      0.73        0.29  0.29];%hp-filtered---baseline
 parameters=[ 2.65         0.99      0.024     0.43       0.32      0.36       1.41      0.88      0.74        0.29  0.29];%CBO ESTIMATES




varCovar=[parameters(9)^2,0,0;0,parameters(10)^2,0;0,0,parameters(11)^2];
varCovar_vec=reshape(varCovar,[length(varCovar)^2,1]);
numVar=5;
N=500;
numSimul=10;
betaGrid=linspace(0.5,0.99,numSimul);
betaPiFinal=nan(numSimul,gridLength);
betaYFinal=nan(numSimul,gridLength);




 options=optimoptions('lsqnonlin',...
     'MaxFunEvals',999,'maxIter',999,...
 'tolFun',10e-15);



for BB=1:gridLength
    disp(BB);
    parameters(paraNo)=paraGrid(BB);


[Atotal, Btotal, Ctotal, Dtotal]=NKPC_matrixConverter(parameters);

auxiliary_function=@(beta) function_g(beta,Atotal,Btotal,Ctotal,Dtotal,varCovar);

gamma1=Atotal^(-1)*Btotal;
gamma2=Atotal^(-1)*Ctotal;
gamma3=Atotal^(-1)*Dtotal;

betaY=nan(N+1,numSimul);betaPi=nan(N+1,numSimul);
for k=1:numSimul

beta_init=betaGrid(k)*diag( ones(numVar,1));
    
    
beta=zeros(numVar,numVar,N);
beta(:,:,1) =    betaGrid(k)*diag( ones(numVar,1));
for i=1:N
    
    betaAux = beta(:,:,i);

    M=gamma1+gamma2*betaAux^2;
    
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
    vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*betaAux^2))*vec0;
    
    for j=1:numVar
     beta(j,j,i+1)=vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
    
    end
end

%   soln=lsqnonlin(auxiliary_function,diag(beta_init),...
%     -999*ones(numVar,1),999*ones(numVar,1),options);
% 
% beta(:,:,1)=diag(soln);


    betaY(:,k)=beta(1,1,end);
    betaPi(:,k)=beta(2,2,end);
    varY(:,k)=vec0(1);
    varPi(:,k)=vec0(7);

end
betaYFinal(:,BB)=betaY(end,:);
betaPiFinal(:,BB)=betaPi(end,:);
varYFinal(:,BB)=varY(end,:);
varPiFinal(:,BB)=varPi(end,:);
end





figure('Name','persistence coefficients','units','normalized','outerposition',[0 0 1 1]);
for k=1:numSimul
    subplot(1,2,1);
scatter(paraGrid,betaPiFinal(k,:),100,'c','filled','MarkerFaceColor','black')
set(gca,'FontSize',40)
xlabel('\phi_{\pi}','FontSize',40);
ylabel('\beta_{\pi}^{*}','FontSize',40);
    hold on;
    subplot(1,2,2);
     scatter(paraGrid,betaYFinal(k,:),100,'c','filled','MarkerFaceColor','black')
set(gca,'FontSize',40)
xlabel('\phi_{y}','FontSize',40);
ylabel('\beta_{y}^{*}','FontSize',40);
    hold on;
end
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'phi_pi_persistence','-dpdf');

figure('Name','variances','units','normalized','outerposition',[0 0 1 1]);
for k=1:numSimul
    subplot(1,2,1);
scatter(paraGrid,varPiFinal(k,:),100,'c','filled','MarkerFaceColor','black')
set(gca,'FontSize',40)
xlabel('\phi_{y}','FontSize',40);
ylabel('\sigma^2_{\pi}','FontSize',40);
    hold on;
    subplot(1,2,2);
     scatter(paraGrid,varYFinal(k,:),100,'c','filled','MarkerFaceColor','black')
set(gca,'FontSize',40)
xlabel('\phi_{y}','FontSize',40);
ylabel('\sigma^2_y','FontSize',40);
    hold on;
end
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'phi_y_variance','-dpdf');
    

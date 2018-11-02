 clear;
 clc;
 delete learningNKPC.mat;
 grid1=20;
 i=1;
 j=1;
 

beta_pi_grid=linspace(0,1,grid1);
beta_y_grid=linspace(0,1,grid1);
persistenceInf = nan(grid1,grid1);
persistenceGap = nan(grid1,grid1);
 

     for i=1:grid1
%     
             
%          learningNKPC(1)=beta_y_grid(i);
          learningNKPC(2)=beta_pi_grid(i);
         
         
         
         delete learningNKPC.mat;
         save learningNKPC.mat learningNKPC;
         delete multipleEqmStuff.mat;
         save multipleEqmStuff.mat i beta_pi_grid beta_y_grid grid1 persistenceInf persistenceGap;
         dynare NKPC_BLE_Estimation;
         load multipleEqmStuff.mat;
         
         
         auxACF = oo_.autocorr{1,1};
         
         persistenceInf(i) = auxACF(2,2);
%         persistenceGap(i) = auxACF(1,1);
     end
 

 refLine=linspace(0,1,grid1);
  plot(beta_pi_grid,persistenceInf)
    hold on
%     plot(persistenceGap,beta_y_grid)
%  plot(beta_y_grid,persistenceGap)
    hold on
plot(beta_pi_grid,refLine);
ylim([0 1])
grid on



% [minGap,minGapInd]=min(persistenceGap'-repmat(refLine,[grid1,1])')
% [minInf,minInfInd]=min(persistenceInf-repmat(refLine,[grid1,1])')
% 
% for i=1:grid1
% %     starGap(i) = persistenceGap(i,minGapInd(i));
% %     starInf(i) = persistenceInf(minInfInd(i),i);
%     starGap(i) = persistenceGap(i,minGapInd(i));
%     starInf(i) = persistenceInf(minInfInd(i),i);
% end
% 
% plot(beta_pi_grid,starInf);
% hold on
% plot(starGap,beta_y_grid);
%  grid on
%  grid minor
%     
    
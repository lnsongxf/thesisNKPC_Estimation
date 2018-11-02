              clear;
              clc;
  grid1=50;                
  phi_y_grid = linspace(0,2,grid1);
  phi_pi_grid = linspace(1.5,10,grid1);

  
  
           load('varREE.mat');
           load('varBLE.mat');
           
           figure
      
           subplot(1,2,1);
           surf(phi_pi_grid,phi_y_grid,infVar_REE,'faceColor',[1 0 0 ]);
      
           hold on
           surf(phi_pi_grid,phi_y_grid,infVar_BLE,'faceColor',[0 0 1]);
     
                 zlim([0 Inf]);
           xlim([min(phi_pi_grid) max(phi_pi_grid)])
           ylim([min(phi_y_grid) max(phi_y_grid)])
          xlabel('\phi_{\pi}','fontweight','bold','FontSize',15);
          ylabel('\phi_{y}','fontweight','bold','FontSize',15);
          zlabel('Variance of Inflation','fontweight','bold','FontSize',15);
zlim([0 Inf]);
           
           title('Variance of Inflation','FontSize', 15,'fontweight','bold','FontSize',15);
 alpha 0.6
           subplot(1,2,2);
           surf(phi_pi_grid,phi_y_grid,gapVar_REE,'faceColor',[1 0 0 ]);
           hold on
           surf(phi_pi_grid,phi_y_grid,gapVar_BLE,'faceColor',[0 0 1]);
           title('Variance of Output Gap','FontSize', 15,'fontweight','bold','FontSize',15);
           legend('RE','Learning','fontweight','bold','FontSize',15);
    
                  zlim([0 Inf]);
           xlim([min(phi_pi_grid) max(phi_pi_grid)])
           ylim([min(phi_y_grid) max(phi_y_grid)])
                  xlabel('\phi_{\pi}','fontweight','bold','FontSize',15);
          ylabel('\phi_{y}','fontweight','bold','FontSize',15);
          zlabel('Variance of Output Gap','fontweight','bold','FontSize',15);
alpha 0.6

for jj=2:grid1
diffInfVar_BLE1(:,jj-1)=infVar_BLE(jj,:)-infVar_BLE(jj-1,:);
diffInfVar_REE1(:,jj-1)=infVar_REE(jj,:)-infVar_REE(jj-1,:);
diffgapVar_BLE1(:,jj-1)=gapVar_BLE(jj,:)-gapVar_BLE(jj-1,:);
diffgapVar_REE1(:,jj-1)=gapVar_REE(jj,:)-gapVar_REE(jj-1,:);
end

for jj=2:grid1
diffInfVar_BLE2(:,jj-1)=infVar_BLE(:,jj)-infVar_BLE(:,jj-1);
diffInfVar_REE2(:,jj-1)=infVar_REE(:,jj)-infVar_REE(:,jj-1);
diffgapVar_BLE2(:,jj-1)=gapVar_BLE(:,jj)-gapVar_BLE(:,jj-1);
diffgapVar_REE2(:,jj-1)=gapVar_REE(:,jj)-gapVar_REE(:,jj-1);
end


sr_REE1=diffgapVar_REE1./diffInfVar_REE1;
sr_BLE1=diffgapVar_BLE1./diffInfVar_BLE1;
sr_REE1=reshape(sr_REE1,[size(sr_REE1,1)*size(sr_REE1,2),1]);
sr_BLE1=reshape(sr_BLE1,[size(sr_BLE1,1)*size(sr_BLE1,2),1]);

sr_REE2=diffgapVar_REE2./diffInfVar_REE2;
sr_BLE2=diffgapVar_BLE2./diffInfVar_BLE2;
sr_REE2=reshape(sr_REE2,[size(sr_REE2,1)*size(sr_REE2,2),1]);
sr_BLE2=reshape(sr_BLE2,[size(sr_BLE2,1)*size(sr_BLE2,2),1]);


% figure;
% subplot(2,1,1);
% hist(sr_REE1);
% subplot(2,1,2);
% hist(sr_BLE1);
% 
% figure;
% subplot(2,1,1);
% hist(sr_REE2);
% subplot(2,1,2);
% hist(sr_BLE2);
% 
% 
% figure;
% subplot(2,1,1);
% hist([sr_REE1;sr_REE2]);
% subplot(2,1,2);
% hist([sr_BLE1;sr_BLE2]);
% 


   
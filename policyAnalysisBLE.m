clear;
clc;

total=10;
iterations=0;

    
 phi_y_grid = linspace(0.13,0.97,total);
  phi_pi_grid = linspace(0.84,1.98,total);

% 
% infVar_BLE=zeros(total,total,total,rhoTot);
% gapVar_BLE=zeros(total,total,total,rhoTot);
% intVar_BLE=zeros(total,total,total,rhoTot);
% dyVar_BLE=zeros(total,total,total,rhoTot);
% gapGrVar_BLE=zeros(total,total,total,rhoTot) ;

infVar_BLE=zeros(total,total);
gapVar_BLE=zeros(total,total);
dyVar_BLE=zeros(total,total);

infPers_BLE=zeros(total,total);
gapPers_BLE=zeros(total,total);
dyPers_BLE=zeros(total,total);

save varBLE.mat infVar_BLE gapVar_BLE dyVar_BLE;
save policyGridBLE.mat phi_y_grid phi_pi_grid;

learningNKPC=0.5*ones(2,1)';
old_paraNKPC=0.5*ones(2,1)';




   for ind1=1:total
       for ind2=1:total


                 clearvars infVar_BLE gapVar_BLE dyVar_BLE infPers_BLE gapPers_BLE dyPers_BLE phi_y_grid phi_pi_grid;
           
            load('policyGridBLE.mat');

            
           
            
            delete('policyParametersBLE.mat');
            delete('policyIndicesBLE.mat');
            
            policy1 = phi_y_grid(ind1);
            policy2 = phi_pi_grid(ind2);

       
            save policyParametersBLE.mat policy1 policy2;
            save policyIndicesBLE.mat ind1 ind2 iterations total;
            
           
             
             
            
            NKPC_BLE_main;
           
            varMatrix = oo_.var;
            persMatrix=oo_.autocorr{1,1};
            
            
            load('policyIndicesBLE.mat');
            load('varBLE.mat');
            
            infVar_BLE(ind1,ind2) = varMatrix(2,2); %inflation variance
            gapVar_BLE(ind1,ind2) = varMatrix(1,1); %output gap variance
            %dyVar_BLE(ind1,ind2)  =varMatrix(6,6); %output growth variance
            infPers_BLE(ind1,ind2)= persMatrix(2,2);
            gapPers_BLE(ind1,ind2)=persMatrix(1,1);
            %dyPers_BLE(ind1,ind2)=persMatrix(6,6);
            
            [infVar_BLE(ind1,ind2)...
                gapVar_BLE(ind1,ind2)...
                dyVar_BLE(ind1,ind2)]
            
            [infPers_BLE(ind1,ind2) gapPers_BLE(ind1,ind2)]; %dyPers_BLE(ind1,ind2)];
            
            delete('varBLE.mat');

            save varBLE.mat infVar_BLE gapVar_BLE dyVar_BLE infPers_BLE gapPers_BLE; %dyPers_BLE;
            
            iterations=iterations+1;  
            disp('Remaining Iterations:');
            disp( total - iterations) ;
            
            
       end
   end
           
%               clear;
%               
%   total=10;                
%   phi_y_grid = linspace(0.01,0.99,total);
%   phi_pi_grid = linspace(1,3,total);
%            load('varBLE.mat');
%            figure
%            surf(phi_y_grid,phi_pi_grid,infVar_BLE);
% zlim([0 1]);
%            
%            title('Variance of Inflation');
%            figure
%            surf(phi_y_grid,phi_pi_grid,gapVar_BLE);
%            title('Variance of Output Gap');
%            zlim([0 10]);
%            
%            figure
%            surf(phi_y_grid,phi_pi_grid,dyVar_BLE);
%            title('Variance of Output Growth');
%    zlim([0 1]);
   
%        end
%    end
% end
%             
            
            
            
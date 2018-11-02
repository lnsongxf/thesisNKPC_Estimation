clear;
clc;

total=50;
iterations=0;

 
    

  phi_y_grid = linspace(0.13,0.97,total);
  phi_pi_grid = linspace(0.84,1.98,total);

infVar_REE=zeros(total,total);
gapVar_REE=zeros(total,total);
dyVar_REE=zeros(total,total);

save varREE2.mat infVar_REE gapVar_REE dyVar_REE;
save policyGridREE.mat phi_y_grid phi_pi_grid;




   for ind1=1:total
       for ind2=1:total


                 clearvars infVar_REE gapVar_REE dyVar_REE phi_y_grid phi_pi_grid;
            
            load('policyGridREE.mat');

            
           
            
            delete('policyParametersREE.mat');
            delete('policyIndicesREE.mat');
            
            policy1 = phi_y_grid(ind1);
            policy2 = phi_pi_grid(ind2);

       
            save policyParametersREE.mat policy1 policy2;
            save policyIndicesREE.mat ind1 ind2 iterations total;
            
           
             
             
            
           dynare NKPC_REE_Estimation nolog;
           
            varMatrix = oo_.var;
            
            load('policyIndicesREE.mat');
            load('varREE2.mat');
            
            infVar_REE(ind1,ind2) = varMatrix(2,2); %inflation variance
            gapVar_REE(ind1,ind2) = varMatrix(1,1); %output gap variance
            %dyVar_REE(ind1,ind2)  =varMatrix(6,6); %output growth variance
            
            [infVar_REE(ind1,ind2)...
                gapVar_REE(ind1,ind2)...
                dyVar_REE(ind1,ind2)]
            
            delete('varREE2.mat');

            save varREE2.mat infVar_REE gapVar_REE dyVar_REE;
            
            iterations=iterations+1;  
            disp('Remaining Iterations:');
            disp( total^2 - iterations) ;
            
            
       end
   end
           
%               clear;
%               
%   total=20;                
%     phi_y_grid = linspace(0.13,0.97,total);
%   phi_pi_grid = linspace(0.82,1.96,total);
% 
%            load('varREE.mat');
%            figure
%            surf(phi_y_grid,phi_pi_grid,infVar_REE);
% % zlim([0 1]);
%            
%            title('Variance of Inflation');
%            figure
%            surf(phi_y_grid,phi_pi_grid,gapVar_REE);
%            title('Variance of Output Gap');
% %            zlim([0 10]);
%            
% %            figure
% %            surf(phi_y_grid,phi_pi_grid,dyVar_REE);
% %            title('Variance of Output Growth');
% %    zlim([0 1]);
%    
% %        end
% %    end
% % end
% %             
       
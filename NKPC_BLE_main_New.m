clear;
clc;

 
old_paraNKPC = [0.5,0.5];

  distanceNKPC(1) = 10;
   learningNKPC = [0.5,0.5];
   indexNKPC=1;
   
 while distanceNKPC(indexNKPC)>10e-4
     
delete('learningNKPC.mat');
delete('old_paraNKPC.mat');
delete('indexNKPC.mat');
delete('distanceNKPC.mat');
    
     	
     
    %Current period: (t)
    
    save learningNKPC.mat learningNKPC;        %learning parameters from period (t-1)
    save old_paraNKPC.mat old_paraNKPC;     %learning parameters from period (t-1).Same as learning? 
    save indexNKPC.mat indexNKPC;
    save distanceNKPC.mat distanceNKPC;
    
    clear;
    
dynare NKPC_BLE_Estimation_New ;  % Model estimation using parameters from (t-1).

%(t-1) stuff wiped out. Estimation results for period (t) available. 

clearvars learningNKPC old_paraNKPC;
    
   NKPC_LearningUpdate;        %update the learning parameters based on simulations of period (t). 
                                   %Hence learning parameters (t) available
                                   %in the workspace as 'learning'.
                                   
   
   load('old_paraNKPC.mat');        %load learning parameters from period (t-1). Hence (t-1) learining parameters 
                                   %available in the workspace as
                                   %'learningOld'.
   load('indexNKPC.mat');
   load('distanceNKPC.mat');
   
   indexNKPC=indexNKPC+1;
  

distanceNKPC(indexNKPC) = norm(abs(learningNKPC-old_paraNKPC));

 old_paraNKPC=learningNKPC;


distanceNKPC

 end
   
%  auxPara= oo_.posterior.optimization.mode;
%  parameters(1)=auxPara(3);
%  parameters(2)=lambda;
%  parameters(3:7)=auxPara(4:8)
%  parameters(8:9)=auxPara(1:2);
%  parameters



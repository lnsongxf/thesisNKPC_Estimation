function [ Atotal Btotal Ctotal Dtotal ] = NKPC_matrixConverter( parameters )



syms y pinf int u_y u_pinf...
     yp pinfp intp u_yp u_pinfp...
     ym pinfm intm u_ym u_pinfm...
     eps_y eps_pinf eps_r;
% syms y pinf int u_y u_pinf...
%      yp pinfp intp u_yp u_pinfp...
%      ym pinfm intm u_ym u_pinfm...
%      eps_y eps_pinf ;
 
 


NumVar= 5;
NumShock=3;

tau=  parameters(1);
lambda=parameters(2);
gamma=parameters(3);

rho_y=parameters(4) ;
rho_pinf=parameters(5);
phi_y=parameters(6) ;
    
phi_pinf=parameters(7) ;
rho_r=parameters(8);

eq1= y - yp + (1/tau)*(int-pinfp)-u_y==0;
eq2= pinf-lambda*pinfp-gamma*(y)-u_pinf==0;
eq3= int - rho_r*intm-(1-rho_r)*(phi_pinf*pinf)-(1-rho_r)*phi_y*(y)-eps_r==0;

% eq1= y - yp + (1/tau)*(int-pinfp)-u_y==0;
% eq2= pinf-lambda*pinfp-gamma*(y)-u_pinf==0;
% eq3= int -phi_pinf*pinf-phi_y*(y)==0;


err1=u_y-rho_y*u_ym-eps_y==0;
err2=u_pinf-rho_pinf*u_pinfm-eps_pinf==0;





	



  
    F = [eq1 eq2 eq3...
        err1,err2];
 
    
    Contemp = [y pinf int u_y u_pinf ];
           
     Expectation=[ yp pinfp intp u_yp u_pinfp ];
     
     Lagged=[ ym pinfm intm u_ym u_pinfm ];
     
     Shocks = [eps_y eps_pinf eps_r];
%    Shocks = [eps_y eps_pinf];
  
         
    
A = equationsToMatrix(F, Contemp);   
B = equationsToMatrix(F, Lagged);
C = equationsToMatrix(F, Expectation);
D = equationsToMatrix(F, Shocks);


    
    for i=1:NumVar
        for j=1:NumVar
            
            Atotal(i,j) = double(A(i,j));
            Btotal(i,j) = double(B(i,j));
            Ctotal(i,j) = double(C(i,j));
            
        end
    end
    
    for i=1:NumVar
        for j=1:NumShock
            
            Dtotal(i,j) = double(D(i,j));
         
      end
    end
    
 Btotal=-Btotal;
 Ctotal=-Ctotal;
 Dtotal=-Dtotal;
%Atotal=-Atotal;

    













end


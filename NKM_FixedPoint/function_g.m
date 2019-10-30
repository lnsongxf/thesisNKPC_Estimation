function[f]=function_g(beta,A,B,C,D,sigma)

beta=diag(beta);
numVar=5;
Ainv=A^(-1);gamma1=Ainv*B;gamma2=Ainv*C;gamma3=Ainv*D;
sigma_vec=reshape(sigma,[length(sigma)^2,1]);
    
 M= gamma1+gamma2*beta.^2;  
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*sigma_vec;
vec1= (kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*beta^2))*vec0;

g=zeros(numVar,1);
f=diag(beta);
for j=1:numVar
   g(j)= vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j);
   f(j)=g(j)-beta(j,j);
end




end
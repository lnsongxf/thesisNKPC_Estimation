function [ DGbeta] = jacobianSolver( beta,gamma1,gamma2,gamma3,varCovar_vec,k )

h=10e-2;
numVar=length(beta(:,:,1));
jacobian=nan(numVar,numVar);
normalG=nan(numVar,1);
perturbedG=nan(numVar,numVar);
%retrieve current beta
current_beta=(beta(1:numVar,1:numVar,k));

M=gamma1+gamma2*(current_beta)^2;
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*current_beta^2))*vec0;

for j=1:numVar
normalG(j)=(vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j)); 
end

for i=1:numVar
    current_beta(i)=current_beta(i)+h;
   
 M=gamma1+gamma2*(current_beta)^2;   
vec0=(eye(numVar^2)-kron(M,M))^(-1)*kron(gamma3,gamma3)*varCovar_vec;
vec1=(kron(eye(numVar),gamma1)+kron(eye(numVar),gamma2*current_beta^2))*vec0;

%Compute element of Jacobian: column i, row j
for j=1:numVar
  perturbedG(j,i)=(vec1( (j-1)*numVar+j)/vec0( (j-1)*numVar+j));   
    jacobian(j,i)=(perturbedG(j,i)-normalG(j))/h;
end





end

DGbeta=jacobian;
end
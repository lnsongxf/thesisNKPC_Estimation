function [alpha beta r] =cgl_learning_recursive(x,xOld,alphaOld,betaOld,rOld,gain)
%constant gain sample autocorrelation learning with AR(1) rule, recursive
%form.
alpha= alphaOld+gain*(x-alphaOld);

r = rOld+gain*((x-alphaOld)^2-rOld);

beta= betaOld+ gain*r^(-1)*((x-alphaOld)*(xOld-alphaOld)-betaOld*(x-alphaOld)^2);



end
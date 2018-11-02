function [alpha beta r] =sac_cgl_learning(x,xOld,alphaOld,betaOld,rOld,gain)

alpha= alphaOld+gain*(x-alphaOld);

r = rOld+gain*((x-alphaOld)^2-rOld);

beta= betaOld+ gain*r^(-1)*((x-alphaOld)*(xOld-alphaOld)-betaOld*(x-alphaOld)^2);



end
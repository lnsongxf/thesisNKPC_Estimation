


acfMatrix = oo_.autocorr{1,1};



beta_y = acfMatrix(1,1);


beta_pi=acfMatrix(2,2);

beta_g  =acfMatrix(3,3);


learningNKPC=[beta_y,beta_pi,beta_g];
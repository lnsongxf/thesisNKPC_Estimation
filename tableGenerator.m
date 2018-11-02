

for j=1:10
 
aux=oo_.autocorr(1,j);
aux=cell2mat(aux);

acf_y(j) = aux(1,1);
acf_pi(j) = aux(2,2);
acf_u_y(j) = aux(3,3);
acf_u_pi(j) = aux(4,4);
acf_i(j) =  aux(5,5);


 
 end
 
 cross_corr = oo_.autocorr(1,1);
 cross_corr = cell2mat(cross_corr);
 
 cross_corr= round(cross_corr,2);
 

 mean1 = oo_.posterior_mean.parameters;
 mean1= struct2cell(mean1);
 mean1= cell2mat(mean1);
 mean1=round(mean1,2);
 
 mean2 = oo_.posterior_mean.shocks_std;
 mean2= struct2cell(mean2);
 mean2= cell2mat(mean2);
 mean2=round(mean2,2);
 
 mode1 = oo_.posterior_mode.parameters;
 mode1= struct2cell(mode1);
 mode1= cell2mat(mode1);
 mode1=round(mode1,2);
 
  mode2 = oo_.posterior_mode.shocks_std;
 mode2= struct2cell(mode2);
 mode2= cell2mat(mode2);
 mode2=round(mode2,2);
 
%  stdev = oo_.posterior_std.parameters;
%  stdev= struct2cell(stdev);
%  stdev= cell2mat(stdev);
%  stdev=round(stdev,2);
 
 hpd5= oo_.posterior_hpdinf.parameters ;
 hpd5= struct2cell(hpd5);
 hpd5= cell2mat(hpd5);
 hpd5=round(hpd5,2);
 
 hpd52= oo_.posterior_hpdinf.shocks_std ;
 hpd52= struct2cell(hpd52);
 hpd52= cell2mat(hpd52);
 hpd52=round(hpd52,2);
 
 hpd95=oo_.posterior_hpdsup.parameters ;
 hpd95= struct2cell(hpd95);
 hpd95= cell2mat(hpd95);
 hpd95=round(hpd95,2);
 
 hpd952=oo_.posterior_hpdsup.shocks_std ;
 hpd952= struct2cell(hpd952);
 hpd952= cell2mat(hpd952);
 hpd952=round(hpd952,2);
 
 likelihood = oo_.MarginalDensity.LaplaceApproximation;
 likelihood2=oo_.MarginalDensity.ModifiedHarmonicMean;
 
 acf_y = round(acf_y,2);
 acf_pi = round(acf_pi,2);
 acf_u_y = round(acf_u_y,2);
 acf_u_pi = round(acf_u_pi,2);
 acf_i = round(acf_i,2);
 

  
  output_file='ResultsNKPC.csv';
  output_sheet='ResultsNKPC';
  xlswrite(output_file,mean1,output_sheet,'c20');
  xlswrite(output_file,mode1,output_sheet,'b20');
  
 xlswrite(output_file,mean2,output_sheet,'c30');
  xlswrite(output_file,mode2,output_sheet,'b30');

  xlswrite(output_file,hpd5,output_sheet,'d20');
  xlswrite(output_file,hpd95,output_sheet,'e20');
  
    xlswrite(output_file,hpd52,output_sheet,'d30');
  xlswrite(output_file,hpd952,output_sheet,'e30');
  
  
  xlswrite(output_file,likelihood,output_sheet,'b34');
xlswrite(output_file,likelihood2,output_sheet,'b35');

  xlswrite(output_file,acf_y',output_sheet,'a38');
  xlswrite(output_file,acf_pi',output_sheet,'b38');

%  
%  
% plot(distanceNKPC(2:length(distanceNKPC)));
% title('Norm distance between the consecutive persistence values');
% xlabel('Number of steps');
% ylabel('Norm distance');
% print('distance_cont_est','-depsc');
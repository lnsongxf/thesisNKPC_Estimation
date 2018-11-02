%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'NKPC_REE_Estimation';
M_.dynare_version = '4.5.4';
oo_.dynare_version = '4.5.4';
options_.dynare_version = '4.5.4';
%
% Some global variables initialization
%
global_initialization;
diary off;
M_.exo_names = 'eps_y';
M_.exo_names_tex = 'eps\_y';
M_.exo_names_long = 'eps_y';
M_.exo_names = char(M_.exo_names, 'eps_pi');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_pi');
M_.exo_names_long = char(M_.exo_names_long, 'eps_pi');
M_.exo_names = char(M_.exo_names, 'eps_r');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_r');
M_.exo_names_long = char(M_.exo_names_long, 'eps_r');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'pi');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi');
M_.endo_names_long = char(M_.endo_names_long, 'pi');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'u_y');
M_.endo_names_tex = char(M_.endo_names_tex, 'u\_y');
M_.endo_names_long = char(M_.endo_names_long, 'u_y');
M_.endo_names = char(M_.endo_names, 'u_pi');
M_.endo_names_tex = char(M_.endo_names_tex, 'u\_pi');
M_.endo_names_long = char(M_.endo_names_long, 'u_pi');
M_.endo_partitions = struct();
M_.param_names = 'kappa';
M_.param_names_tex = 'kappa';
M_.param_names_long = 'kappa';
M_.param_names = char(M_.param_names, 'tau');
M_.param_names_tex = char(M_.param_names_tex, 'tau');
M_.param_names_long = char(M_.param_names_long, 'tau');
M_.param_names = char(M_.param_names, 'phi_pi');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_pi');
M_.param_names_long = char(M_.param_names_long, 'phi_pi');
M_.param_names = char(M_.param_names, 'phi_y');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_y');
M_.param_names_long = char(M_.param_names_long, 'phi_y');
M_.param_names = char(M_.param_names, 'rho_y');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_y');
M_.param_names_long = char(M_.param_names_long, 'rho_y');
M_.param_names = char(M_.param_names, 'rho_pi');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_pi');
M_.param_names_long = char(M_.param_names_long, 'rho_pi');
M_.param_names = char(M_.param_names, 'rho_r');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_r');
M_.param_names_long = char(M_.param_names_long, 'rho_r');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 5;
M_.param_nbr = 7;
M_.orig_endo_nbr = 5;
M_.aux_vars = [];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('NKPC_REE_Estimation_static');
erase_compiled_function('NKPC_REE_Estimation_dynamic');
M_.orig_eq_nbr = 5;
M_.eq_nbr = 5;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 4 9;
 0 5 10;
 1 6 0;
 2 7 0;
 3 8 0;]';
M_.nstatic = 0;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 5;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(5, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(7, 1);
M_.NNZDerivatives = [20; 0; -1];
M_.params( 1 ) = 0.0069;
kappa = M_.params( 1 );
M_.params( 2 ) = 4.2645;
tau = M_.params( 2 );
M_.params( 5 ) = 0.8839;
rho_y = M_.params( 5 );
M_.params( 6 ) = 0.8702;
rho_pi = M_.params( 6 );
M_.params( 7 ) = 0.85;
rho_r = M_.params( 7 );
M_.params( 4 ) = 0.4779;
phi_y = M_.params( 4 );
M_.params( 3 ) = 1.3773;
phi_pi = M_.params( 3 );
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.1570)^2;
M_.Sigma_e(2, 2) = (0.0391)^2;
M_.Sigma_e(3, 3) = (0.2991)^2;
load('policyParametersREE.mat');
M_.params( 4 ) = policy1;
phi_y = M_.params( 4 );
M_.params( 3 ) = policy2;
phi_pi = M_.params( 3 );
options_.ar = 10;
options_.nograph = 1;
var_list_ = char();
info = stoch_simul(var_list_);
save('NKPC_REE_Estimation_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('NKPC_REE_Estimation_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end

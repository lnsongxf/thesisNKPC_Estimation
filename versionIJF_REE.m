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
M_.fname = 'versionIJF_REE';
M_.dynare_version = '4.5.1';
oo_.dynare_version = '4.5.1';
options_.dynare_version = '4.5.1';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('versionIJF_REE.log');
M_.exo_names = 'eta_d';
M_.exo_names_tex = 'eta\_d';
M_.exo_names_long = 'eta_d';
M_.exo_names = char(M_.exo_names, 'eta_s');
M_.exo_names_tex = char(M_.exo_names_tex, 'eta\_s');
M_.exo_names_long = char(M_.exo_names_long, 'eta_s');
M_.exo_names = char(M_.exo_names, 'eta_r');
M_.exo_names_tex = char(M_.exo_names_tex, 'eta\_r');
M_.exo_names_long = char(M_.exo_names_long, 'eta_r');
M_.endo_names = 'h';
M_.endo_names_tex = 'h';
M_.endo_names_long = 'h';
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'pinf');
M_.endo_names_tex = char(M_.endo_names_tex, 'pinf');
M_.endo_names_long = char(M_.endo_names_long, 'pinf');
M_.endo_names = char(M_.endo_names, 'mc');
M_.endo_names_tex = char(M_.endo_names_tex, 'mc');
M_.endo_names_long = char(M_.endo_names_long, 'mc');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names_long = char(M_.endo_names_long, 'l');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'eps_d');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_d');
M_.endo_names_long = char(M_.endo_names_long, 'eps_d');
M_.endo_names = char(M_.endo_names, 'eps_s');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_s');
M_.endo_names_long = char(M_.endo_names_long, 'eps_s');
M_.endo_names = char(M_.endo_names, 'dy');
M_.endo_names_tex = char(M_.endo_names_tex, 'dy');
M_.endo_names_long = char(M_.endo_names_long, 'dy');
M_.endo_names = char(M_.endo_names, 'pinfobs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pinfobs');
M_.endo_names_long = char(M_.endo_names_long, 'pinfobs');
M_.endo_names = char(M_.endo_names, 'robs');
M_.endo_names_tex = char(M_.endo_names_tex, 'robs');
M_.endo_names_long = char(M_.endo_names_long, 'robs');
M_.endo_partitions = struct();
M_.param_names = 'lambda';
M_.param_names_tex = 'lambda';
M_.param_names_long = 'lambda';
M_.param_names = char(M_.param_names, 'sigma_c');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_c');
M_.param_names_long = char(M_.param_names_long, 'sigma_c');
M_.param_names = char(M_.param_names, 'sigma_l');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_l');
M_.param_names_long = char(M_.param_names_long, 'sigma_l');
M_.param_names = char(M_.param_names, 'xi_p');
M_.param_names_tex = char(M_.param_names_tex, 'xi\_p');
M_.param_names_long = char(M_.param_names_long, 'xi_p');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names_long = char(M_.param_names_long, 'rho');
M_.param_names = char(M_.param_names, 'r_pi');
M_.param_names_tex = char(M_.param_names_tex, 'r\_pi');
M_.param_names_long = char(M_.param_names_long, 'r_pi');
M_.param_names = char(M_.param_names, 'r_dy');
M_.param_names_tex = char(M_.param_names_tex, 'r\_dy');
M_.param_names_long = char(M_.param_names_long, 'r_dy');
M_.param_names = char(M_.param_names, 'pi_bar');
M_.param_names_tex = char(M_.param_names_tex, 'pi\_bar');
M_.param_names_long = char(M_.param_names_long, 'pi_bar');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'r_bar');
M_.param_names_tex = char(M_.param_names_tex, 'r\_bar');
M_.param_names_long = char(M_.param_names_long, 'r_bar');
M_.param_names = char(M_.param_names, 'rho_d');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_d');
M_.param_names_long = char(M_.param_names_long, 'rho_d');
M_.param_names = char(M_.param_names, 'rho_s');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_s');
M_.param_names_long = char(M_.param_names_long, 'rho_s');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 11;
M_.param_nbr = 12;
M_.orig_endo_nbr = 11;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'dy'};
options_.varobs(2)  = {'pinfobs'};
options_.varobs(3)  = {'robs'};
options_.varobs_id = [ 9 10 11  ];
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
erase_compiled_function('versionIJF_REE_static');
erase_compiled_function('versionIJF_REE_dynamic');
M_.orig_eq_nbr = 11;
M_.eq_nbr = 11;
M_.ramsey_eq_nbr = 0;
M_.lead_lag_incidence = [
 0 5 16;
 1 6 0;
 0 7 17;
 0 8 0;
 0 9 0;
 2 10 0;
 3 11 18;
 4 12 0;
 0 13 0;
 0 14 0;
 0 15 0;]';
M_.nstatic = 5;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 1;
M_.nsfwrd   = 3;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(11, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(12, 1);
M_.NNZDerivatives = [38; 0; -1];
M_.params( 1 ) = 0.7;
lambda = M_.params( 1 );
M_.params( 2 ) = 1.5;
sigma_c = M_.params( 2 );
M_.params( 3 ) = 2;
sigma_l = M_.params( 3 );
M_.params( 4 ) = 0.75;
xi_p = M_.params( 4 );
M_.params( 5 ) = 0.8;
rho = M_.params( 5 );
M_.params( 6 ) = 1.5;
r_pi = M_.params( 6 );
M_.params( 7 ) = 0.1;
r_dy = M_.params( 7 );
M_.params( 8 ) = 0.5;
pi_bar = M_.params( 8 );
M_.params( 9 ) = 0.5;
gamma = M_.params( 9 );
M_.params( 10 ) = 1;
r_bar = M_.params( 10 );
M_.params( 11 ) = 0.75;
rho_d = M_.params( 11 );
M_.params( 12 ) = 0.75;
rho_s = M_.params( 12 );
steady;
resid(1);
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.var_exo = [estim_params_.var_exo; 1, 0.5, 0.01, 20, 4, 0.2, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, 0.5, 0.01, 20, 4, 0.4, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, 0.5, 0.01, 20, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, 0.5, 0, 1, 1, 0.7, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, 1.5, 0, 5, 3, 1, 0.375, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, 2, 0, 10, 3, 2, 0.75, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, 0.7, 0, 1, 1, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, 1.2, 1.0, 3, 3, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, 0.8258, 0.5, 0.975, 1, 0.8, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, 0.12, 0.001, 0.5, 3, 0.125, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, 0.5, 0, 10, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, 0.7, 0, 10, 2, 0.5, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, 0.4, 0, 10, 2, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, 0.5, 0, 1, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, 0.5, 0, 1, 1, 0.5, 0.2, NaN, NaN, NaN ];
options_.mh_drop = 0.2;
options_.mh_jscale = 0.55;
options_.mh_nblck = 2;
options_.mh_replic = 0;
options_.mode_compute = 1;
options_.nodiagnostic = 1;
options_.nograph = 1;
options_.prefilter = 0;
options_.datafile = 'newest_dataset';
options_.optim_opt = '''Algorithm'',''active-set''';
options_.first_obs = 44;
options_.order = 1;
var_list_ = char();
oo_recursive_=dynare_estimation(var_list_);
options_.ar = 10;
options_.nograph = 1;
var_list_ = char();
info = stoch_simul(var_list_);
save('versionIJF_REE_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('versionIJF_REE_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('versionIJF_REE_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('versionIJF_REE_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('versionIJF_REE_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('versionIJF_REE_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('versionIJF_REE_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

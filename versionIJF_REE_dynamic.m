function [residual, g1, g2, g3] = versionIJF_REE_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(11, 1);
beta__ = 0.99;
T19 = (-1)/params(2);
lhs =y(6);
rhs =params(1)*y(1)+(1-params(1))*y(5);
residual(1)= lhs-rhs;
lhs =y(5);
rhs =T19*(y(10)-y(17)+y(18)-y(11))+y(16);
residual(2)= lhs-rhs;
lhs =y(7);
rhs =y(17)*beta__+(1-beta__*params(4))*(1-params(4))/params(4)*y(8);
residual(3)= lhs-rhs;
lhs =y(8);
rhs =y(5)*params(2)+params(3)*y(9)-y(12);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =y(6)-y(12);
residual(5)= lhs-rhs;
lhs =y(10);
rhs =params(5)*y(2)+(1-params(5))*(y(7)*params(6)+params(7)*(y(6)-y(1)))+x(it_, 3);
residual(6)= lhs-rhs;
lhs =y(12);
rhs =params(12)*y(4)+x(it_, 2);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =params(11)*y(3)+x(it_, 1);
residual(8)= lhs-rhs;
lhs =y(13);
rhs =y(6)-y(1)+params(9);
residual(9)= lhs-rhs;
lhs =y(14);
rhs =y(7)+params(8);
residual(10)= lhs-rhs;
lhs =y(15);
rhs =y(10)+params(10);
residual(11)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(11, 21);

  %
  % Jacobian matrix
  %

  g1(1,5)=(-(1-params(1)));
  g1(1,1)=(-params(1));
  g1(1,6)=1;
  g1(2,5)=1;
  g1(2,16)=(-1);
  g1(2,17)=T19;
  g1(2,10)=(-T19);
  g1(2,11)=T19;
  g1(2,18)=(-T19);
  g1(3,7)=1;
  g1(3,17)=(-beta__);
  g1(3,8)=(-((1-beta__*params(4))*(1-params(4))/params(4)));
  g1(4,5)=(-params(2));
  g1(4,8)=1;
  g1(4,9)=(-params(3));
  g1(4,12)=1;
  g1(5,6)=(-1);
  g1(5,9)=1;
  g1(5,12)=1;
  g1(6,1)=(-((1-params(5))*(-params(7))));
  g1(6,6)=(-((1-params(5))*params(7)));
  g1(6,7)=(-((1-params(5))*params(6)));
  g1(6,2)=(-params(5));
  g1(6,10)=1;
  g1(6,21)=(-1);
  g1(7,4)=(-params(12));
  g1(7,12)=1;
  g1(7,20)=(-1);
  g1(8,3)=(-params(11));
  g1(8,11)=1;
  g1(8,19)=(-1);
  g1(9,1)=1;
  g1(9,6)=(-1);
  g1(9,13)=1;
  g1(10,7)=(-1);
  g1(10,14)=1;
  g1(11,10)=(-1);
  g1(11,15)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],11,441);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],11,9261);
end
end
end
end

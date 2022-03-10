% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
%close all
clear all
clc

% set problem (minimal requirement: name of problem)
problem.name = 'Rosenbrock';

% set method (minimal requirement: name of method)
method.name = 'GradientDescent';
method.options.step_type = 'Backtracking';
% method.options.constant_step_size = 1e-2;

% set options
options.term_tol = 1e-6;
options.max_iterations = 100;

% run method and return x^* and f^*
[x,f] = optSolver_Zheng_Han(problem,method,options);
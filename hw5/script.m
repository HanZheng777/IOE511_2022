% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng 4/19/2022

% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
%close all

clear all
clc

% turn off display warning when using global varaibles
warning('off', 'all');

% set problem (minimal requirement: name of problem)
problem.name = 'problem1';

% set method (minimal requirement: name of method)
% method.name = 'Quadratic Penalty';
method.name = 'Sequential Quadratic Programming';


% method.options.constant_step_size = 1e-2;

% set options
options.term_tol = 1e-5;
options.max_iterations = 1000;

% run method and return x^* and f^*
[x,f,norm_c] = optSolverConst_Zheng_Han(problem,method,options);


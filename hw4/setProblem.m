% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that specifies the problem. Specifically, a way to compute: 
%    (1) function values; (2) gradients; and, (3) Hessians (if necessary).
%
%           Input: problem (struct), required (problem.name)
%           Output: problem (struct)
%
% Error(s): 
%       (1) if problem name not specified;
%       (2) function handles (for function, gradient, Hessian) not found
%
function [problem] = setProblem(problem)

% check is problem name available
if ~isfield(problem,'data_name')
    error('Problem Data name not defined!!!')
end

if ~isfield(problem,'loss_name')
    error('Problem Loss name not defined!!!')
end

% set function handles according the the selected problem
switch problem.data_name
    
    % load Mushroom data set
    case 'Mushroom'
        problem.X_train = load("data/mushroom.mat").X_train;
        problem.X_test = load("data/mushroom.mat").X_test;
        problem.y_train = load("data/mushroom.mat").y_train;
        problem.y_test = load("data/mushroom.mat").y_test;
        problem.X_train_size = size(problem.X_train);
        problem.X_total_size = 5500;
        problem.w0 = zeros(problem.X_train_size(2),1);
        
        % set loss & gradient function
        switch problem.loss_name
            case "LS"
            problem.compute_f = @compute_f_LS;
            problem.compute_g = @compute_g_LS;
            problem.f_star = load("data/f_star_LS_mushroom.mat").f_star;
            case "LR"
            problem.compute_f = @compute_f_LR;
            problem.compute_g = @compute_g_LR;
            
            problem.f_star = load("data/f_star_LR_mushroom.mat").f_star;
        end
        
    % load Australian data set
    case 'Australian'
        problem.X_train = load("data/australian.mat").X_train;
        problem.X_test = load("data/australian.mat").X_test;
        problem.y_train = load("data/australian.mat").y_train;
        problem.y_test = load("data/australian.mat").y_test;
        problem.X_train_size = size(problem.X_train);
        problem.X_total_size = 621;
        problem.w0 = zeros( problem.X_train_size(2),1);
        
        % set loss & gradient function
        switch problem.loss_name
            case "LS"
            problem.compute_f = @compute_f_LS;
            problem.compute_g = @compute_g_LS;
            problem.f_star = load("data/f_star_LS_australian.mat").f_star;
            case "LR"
            problem.compute_f = @compute_f_LR;
            problem.compute_g = @compute_g_LR;

            problem.f_star = load("data/f_star_LR_australian.mat").f_star;
        end
        
    otherwise
        
        error('Problem not defined!!!')
end
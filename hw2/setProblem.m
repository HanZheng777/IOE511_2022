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
if ~isfield(problem,'name')
    error('Problem name not defined!!!')
end

% set function handles according the the selected problem
switch problem.name
    
    % function value, gradient and Hessian for Rosenbrock problem
    case 'Rosenbrock'
        problem.x0 = [1.2; 1.2];
        problem.n = length(problem.x0);
        problem.compute_f = @(x) (1-x(1))^2 + 100*(x(2)-x(1)^2)^2;
        problem.compute_g = @(x) [400*x(1)^3 - 400*x(1)*x(2) + 2*x(1) - 2; 200*(x(2)-x(1)^2)];
        problem.compute_H = @(x) [1200*x(1)^2 - 400*x(2) + 2, -400*x(1); -400*x(1), 200];

        problem.x_star = [1;1];
    
    % function value, gradient and Hessian for 2*2 quadratic form
    case 'Quadratic2'
        problem.x0 = load('quadratic2.mat').x_0;
        problem.n = length(problem.x0);
        A = load('quadratic2.mat').A;
        b = load('quadratic2.mat').b;
        c = load('quadratic2.mat').c;
        problem.compute_f = @(x) 0.5*x.'*A*x + b.'*x + c;
        problem.compute_g = @(x) 0.5*(A.'+A)*x + b;
        problem.compute_H = @(x) 0.5*(A.'+A);

        problem.x_star = load('quadratic2.mat').x_star;

    % function value, gradient and Hessian for 10*10 quadratic form
    case 'Quadratic10'
        problem.x0 = load('quadratic10.mat').x_0;
        problem.n = length(problem.x0);
        A = load('quadratic10.mat').A;
        b = load('quadratic10.mat').b;
        c = load('quadratic10.mat').c;
        problem.compute_f = @(x) 0.5*x.'*A*x + b.'*x + c;
        problem.compute_g = @(x) 0.5*(A.'+A)*x + b;
        problem.compute_H = @(x) 0.5*(A.'+A);

        problem.x_star = load('quadratic10.mat').x_star;
        
    otherwise
        
        error('Problem not defined!!!')
end
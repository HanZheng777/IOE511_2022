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
        problem.x0 = [-1.2; 1];
        problem.n = length(problem.x0);
        problem.compute_f = @(x) (1-x(1))^2 + 100*(x(2)-x(1)^2)^2;
        problem.compute_g = @(x) [400*x(1)^3 - 400*x(1)*x(2) + 2*x(1) - 2; 200*(x(2)-x(1)^2)];
        problem.compute_H = @(x) [1200*x(1)^2 - 400*x(2) + 2, -400*x(1); -400*x(1), 200];

        problem.x_star = [1;1];
        
    % function value, gradient and Hessian for function2
    case 'function2'
        problem.x0 = [1;1];
        problem.n = length(problem.x0);
        
        problem.compute_f = @(x) (x(1)*(x(2) - 1) + 3/2)^2 + (x(1)*(x(2)^2 - 1) + 9/4)^2 + (x(1)*(x(2)^3 - 1) + 21/8)^2;

        problem.compute_g = @(x) [2*(x(2)^2 - 1)*(x(1)*(x(2)^2 - 1) + 9/4) + 2*(x(2)^3 - 1)*(x(1)*(x(2)^3 - 1) + 21/8) + 2*(x(1)*(x(2) - 1) + 3/2)*(x(2) - 1);
                                  2*x(1)*(x(1)*(x(2) - 1) + 3/2) + 6*x(1)*x(2)^2*(x(1)*(x(2)^3 - 1) + 21/8) + 4*x(1)*x(2)*(x(1)*(x(2)^2 - 1) + 9/4)];

        problem.compute_H = @(x) [2*(x(2) - 1)^2 + 2*(x(2)^2 - 1)^2 + 2*(x(2)^3 - 1)^2, 4*x(2)*(x(1)*(x(2)^2 - 1) + 9/4) + 6*x(2)^2*(x(1)*(x(2)^3 - 1) + 21/8) + 4*x(1)*(x(2) - 1) + 4*x(1)*x(2)*(x(2)^2 - 1) + 6*x(1)*x(2)^2*(x(2)^3 - 1) + 3 ;
                                  4*x(2)*(x(1)*(x(2)^2 - 1) + 9/4) + 6*x(2)^2*(x(1)*(x(2)^3 - 1) + 21/8) + 4*x(1)*(x(2) - 1) + 4*x(1)*x(2)*(x(2)^2 - 1) + 6*x(1)*x(2)^2*(x(2)^3 - 1) + 3, 8*x(1)^2*x(2)^2 + 18*x(1)^2*x(2)^4 + 4*x(1)*(x(1)*(x(2)^2 - 1) + 9/4) + 2*x(1)^2 + 12*x(1)*x(2)*(x(1)*(x(2)^3 - 1) + 21/8)];


    % function value, gradient and Hessian for function 3 with different
    % problem size
    case 'function3'
        switch problem.size
            case "2"
                problem.x0 = [1;0];
            case "10"
                x0 = zeros(10,1);
                x0(1) = 1;
                problem.x0 = x0;
            case "100"
                x0 = zeros(100,1);
                x0(1) = 1;
                problem.x0 = x0;
            case "1000"
                x0 = zeros(1000,1);
                x0(1) = 1;
                problem.x0 = x0;
        end

        problem.n = length(problem.x0);
        problem.compute_f = @function3_f;
        problem.compute_g = @function3_g;
        problem.compute_H = @function3_H;
             
    otherwise
        
        error('Problem not defined!!!')
end
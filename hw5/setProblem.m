% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng, 4/19/2022

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
        
    % function value, Jacobian(gradient) and Hessian for obejctive function and
    % constrains
    case 'problem1'

        problem.x0 = [2;2];
        problem.x_star = [-1;-1]; % optimal solution
        problem.n = length(problem.x0);
        
        problem.compute_f = @(x) x(1) + x(2);
        problem.compute_f_g = @(x) [1;1];
        problem.compute_f_H = @(x) [0,0;0,0];

        problem.compute_c = @(x) x(1)^2 + x(2)^2 -2;
        problem.c_m = 1;
        problem.compute_c_J = @(x) [2*x(1), 2*x(2)]; 
        problem.compute_c_H = @(x) [2,0;0,2];
        

     % function value, Jacobian(gradient) and Hessian for obejctive function and
    % constrains
    case 'problem2'

        problem.x0 = [-1.8;1.7;1.9;-0.8;-0.8];
        problem.x_star = [-1.71;1.59;1.82;-0.763;-0.763]; % optimal solution
        problem.n = length(problem.x0);

        problem.compute_f = @(x) exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 1/2*(x(1)^3+x(2)^3+1)^2;
        problem.compute_f_g = @(x) [x(2)*x(3)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 3*x(1)^2*(x(1)^3 + x(2)^3 + 1);
                                    x(1)*x(3)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 3*x(2)^2*(x(1)^3 + x(2)^3 + 1);
                                    x(1)*x(2)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                   x(1)*x(2)*x(3)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                   x(1)*x(2)*x(3)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5))];
        
        problem.compute_f_H = @(x) [x(2)^2*x(3)^2*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 6*x(1)*(x(1)^3 + x(2)^3 + 1) - 9*x(1)^4, x(3)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 9*x(1)^2*x(2)^2 + x(1)*x(2)*x(3)^2*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(2)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(2)*x(3)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)^2*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(2)*x(3)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)^2*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                    x(3)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 9*x(1)^2*x(2)^2 + x(1)*x(2)*x(3)^2*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)^2*x(3)^2*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)) - 6*x(2)*(x(1)^3 + x(2)^3 + 1) - 9*x(2)^4, x(1)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(3)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)^2*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(3)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)^2*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                    x(2)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)),   x(1)^2*x(2)^2*x(4)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                    x(2)*x(3)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)^2*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(3)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)^2*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)*x(4)*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)^2*x(2)^2*x(3)^2*x(5)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(3)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)^2*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5));
                                    x(2)*x(3)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)*x(2)^2*x(3)^2*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(3)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)*x(3)^2*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(4)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)*x(4)^2*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)), x(1)*x(2)*x(3)*exp(x(1)*x(2)*x(3)*x(4)*x(5)) + x(1)^2*x(2)^2*x(3)^2*x(4)*x(5)*exp(x(1)*x(2)*x(3)*x(4)*x(5)),  x(1)^2*x(2)^2*x(3)^2*x(4)^2*exp(x(1)*x(2)*x(3)*x(4)*x(5))];

        problem.compute_c = @(x) [x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(5)^2 - 10;
                                  x(2)*x(3) - 5*x(4)*x(5);
                                  x(1)^3 + x(2)^3 + 1];
        problem.c_m = 3;
        problem.compute_c_J = @(x) [2*x(1),2*x(2),2*x(3),2*x(4),2*x(5);
                                    0,x(3),x(2),-5*x(5),-5*x(4);
                                    3*x(1)^2,3*x(2)^2,0,0,0]; % Jacobian (m*n)

        problem.compute_c_H = @(x) cat(3, ...
                                        [2,0,0,0,0;
                                         0,2,0,0,0;
                                         0,0,2,0,0;
                                         0,0,0,2,0;
                                         0,0,0,0,2], ...
                                        [0,0,0,0,0; ...
                                         0,0,1,0,0; ...
                                         0,1,0,0,0; ...
                                         0,0,0,0,-5; ...
                                         0,0,0,-5,0], ...
                                        [6*x(1),0,0,0,0; ...
                                        0,6*x(2),0,0,0; ...
                                        0,0,0,0,0; ...
                                        0,0,0,0,0; ...
                                        0,0,0,0,0]); % a 3D tensor (m*n*n)
                                 
             
    otherwise
        
        error('Problem not defined!!!')
end
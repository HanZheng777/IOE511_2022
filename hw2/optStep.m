% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,d,alpha] = optStep(x,f,g,problem,method,options)

% determine search direction for different optimization methods
switch method.name
    case 'GradientDescent'
        d = -g;
    case 'Newton'
        H = problem.compute_H(x);
        d = -H\g;
end

% determine step size for different step size searching methods
switch method.options.step_type
    case 'Constant'
        alpha = method.options.constant_step_size;
        

    case 'Backtracking'
        alpha = method.options.inital_step_size;
        tol = method.options.tol;
        c_1 = method.options.c_1;
        
        % backtracking line search
        while problem.compute_f(x + alpha*d) > f + c_1*alpha*g.'*d
            alpha = tol*alpha;
        end

    otherwise
        error('Name of learning rate searching method is not defined!!')

end

x_new = x + alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);

end


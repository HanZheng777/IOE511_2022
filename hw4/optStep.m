% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: w, k, batch_size, problem, method, options
%           Outputs: w_new, f_train, f_test
%
function [w_new, f_train, f_test] = optStep(w, k, batch_size, problem, method, options)

% obtain train loss, test loss, and gradient
f_train = problem.compute_f(problem.X_train, problem.y_train, w);
f_test = problem.compute_f(problem.X_test, problem.y_test, w);
g = problem.compute_g(problem.X_train, problem.y_train, w, batch_size, method.full_gradient);

d = -g;

% determine step size for different step size searching methods
switch method.options.step_type
    case 'Constant'
        alpha = method.options.constant_step_size;
    
    case 'Diminishing'
        alpha = method.options.init_step_size/k;

    case 'Backtracking'
        alpha = method.options.init_step_size;
        tol = method.options.tol;
        c_1 = method.options.c_1;
        
        % backtracking line search
        while 1
            f = problem.compute_f(problem.X_train, problem.y_train, w+alpha*d);
         
            if f <= f_train+ c_1*alpha*g'*d
                break
            end
            
            alpha = tol*alpha;
        end

    otherwise
        error('Name of learning rate searching method is not defined!!')

end

% update weight
w_new = w + alpha*d;

    

end


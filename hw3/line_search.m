function [x_new,f_new,g_new,alpha] = line_search(x,f,g,d,problem,method)
%LINE_SEARCH Summary of this function goes here
%   constant & Backtracking Line Search

switch method.options.step_type
    % constant step size
    case 'constant'
        alpha = method.options.constant_step_size;
    case 'Backtracking'
        alpha = method.options.inital_step_size;
        tol = method.options.tol;
        c_1 = method.options.c_1;
        
        % backtracking line search for step size
        while problem.compute_f(x + alpha*d) > f + c_1*alpha*g.'*d
            alpha = tol*alpha;
        end
    otherwise
        error('Name of learning rate searching method is not defined!!')
end
 % update x, function value and gradient 
 x_new = x + alpha*d;
 f_new = problem.compute_f(x_new);
 g_new = problem.compute_g(x_new);



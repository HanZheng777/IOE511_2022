% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f] = optSolver_Zheng_Han(problem,method,options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);
H = problem.compute_H(x);
norm_g = norm(g,inf);
norm_g_0 = norm(g,inf);

f_star = problem.compute_f(problem.x_star);

% set initial iteration counter
k = 0;

% plotting stuff
% k_plot = [];
% diff_plot = [];

% termination condition"
while norm_g > options.term_tol*max(norm_g_0, 1) & k < options.max_iterations
    
    % execute optimization step
    [x_new,f_new,g_new,d,alpha] = optStep(x,f,g,problem,method,options);

    % update old and new function values
    x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf);
    
    % increment iteration counter
    k = k + 1;
    diff = f - f_star;

    %plotting stuff
%     k_plot(end+1) = k;
%     diff_plot(end+1) = diff;
    
end

% plotting stuff
% plot(k_plot,diff_plot,'m.')
% set(gca, 'YScale', 'log')
% hold on


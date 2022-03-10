% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f] = optSolver_Zheng_Han(problem,method,options)

% globalized method as its contents would change when calling it in other
% functions in this function file
global method

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);

norm_g = norm(g,inf);
norm_g_0 = norm(g,inf);

% f_star = problem.compute_f(problem.x_star);

% additional info for all methods
switch method.name
    case "GradientDescent"
        method.info = [];
    case "modified Newton"
        method.info = [];
    case "BFGS"
        method.info.H_inv = eye(problem.n);
    case "L-BFGS"
        method.info.s = zeros(problem.n,method.options.memory);
        method.info.y = zeros(problem.n,method.options.memory);
        method.info.r = g;
end
        
% set initial iteration counter
method.info.k = 0;
time = 0;


% plotting stuff
k_plot = [];
t_plot = [];
f_plot = [];

% termination condition"
while norm_g > options.term_tol*max(norm_g_0, 1) & method.info.k < options.max_iterations
    

    %plotting stuff
    k_plot(end+1) = method.info.k;
    f_plot(end+1) = f;

    % execute optimization step
    tic
    [x_new,f_new,g_new,d,alpha] = optStep(x,f,g,problem,method,options);
    dt = toc;
    % update old and new function values
%     x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf);
    
    method.info.k = method.info.k + 1;
    
    time = time + dt;
    t_plot(end+1) = time;

    
end

% plotting stuff
subplot(1,2,1)
plot(k_plot,f_plot,'r.')
set(gca, 'YScale', 'log')
hold on
subplot(1,2,2)
plot(t_plot,f_plot,'r.')
set(gca, 'YScale', 'log')
hold on




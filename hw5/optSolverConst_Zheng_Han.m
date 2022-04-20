% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng 4/19/2022

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) final function value (f) and final
%           l2 norm of the constrain
function [x,f,norm_c] = optSolverConst_Zheng_Han(problem,method,options)

% globalized method as its contents would change when calling it in other
% functions in this function file

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% plotting stuff
k_plot = [];
f_plot = [];
x_star = problem.x_star;
f_star = problem.compute_f(x_star);

% initial obejective info
x_0 = problem.x0;
f_0 = problem.compute_f(x_0);
f_g_0 = problem.compute_f_g(x_0);

% inital constrain info
c_0 = problem.compute_c(x_0);
norm_c_0 = norm(c_0, "inf");
c_J_0 = problem.compute_c_J(x_0);
% inital Lagrangian info
lamda_0 = -c_J_0'\f_g_0;
norm_L_g_0 = norm((f_g_0 + lamda_0'*c_J_0),"inf");

% inital outer counter
k = 0;
norm_L_g = inf;
norm_c = inf;

switch method.name

    case "Quadratic Penalty"
        % inital penalty parameter
        v = method.options.v_0;
        x_bar = x_0;
        k_inner = 0; % counter for # inner iteration of Newton's method with
                        % backtracking line search
     
        while (norm_L_g > options.term_tol*max(norm_L_g_0,1) || norm_c > options.term_tol*max(norm_c_0,1)) && (k < options.max_iterations)  % Approximated KKT as termination condition 
            
            % step update
            [x_bar_new, f_bar_new, c_bar_new, f_g_bar_new, c_J_bar_new, k_inner_new] = optStep_QP(x_bar,v,k_inner,problem,method,options);
            
            lamda_new = -c_J_bar_new'\f_g_bar_new; % least squares solution to compute the Lagrangian multipliers
             % termination info update
            norm_L_g = norm((f_g_bar_new + c_J_bar_new'*lamda_new),"inf");
            norm_c = norm(c_bar_new, "inf");

            x_bar = x_bar_new;
            v = method.options.gamma * v; % update penlaty parameter
            k = k+1; % update outer counter

            % plotting stuff
            k_plot(end+1) = k;
            f_plot(end+1) = f_star - f_bar_new;
        end
        
        % final result
        x = x_bar_new;
        f = f_bar_new;
        norm_c = norm_c;
     
    
    case "Sequential Quadratic Programming"
        x = x_0;
        lamda = lamda_0;  % inital Lagrangian multipliers
        while (norm_L_g > options.term_tol*max(norm_L_g_0,1) || norm_c > options.term_tol*max(norm_c_0,1)) && (k < options.max_iterations) % Approximated KKT as termination condition 
            
            % step update
            [x_new,f_new,c_new,f_g_new, c_J_new, lamda_new] = optStep_SQP(x, lamda, problem,method,options);
            
            % termination info update
            norm_L_g = norm((f_g_new + c_J_new'*lamda_new),"inf");
            norm_c = norm(c_new, "inf");
            
            lamda = lamda_new; % update Lagrangian multipliers
            x = x_new;
            k = k+1;
            
            % % plotting stuff
            k_plot(end+1) = k;
            f_plot(end+1) = f_star - f_new;
        end
        % final result
        x = x_new;
        f = f_new;
        norm_c = norm_c;
end




% plotting stuff
% subplot(1,2,1)
% plot(k_plot,f_plot,'m.','MarkerSize',15)
% set(gca, 'YScale', 'log')
% xlabel('iteration')
% ylabel('f^* - f')
% title('SQP - Problem 1 with H_k = I')
% hold on
% subplot(1,2,2)
% plot(k_plot,f_plot,'m.','MarkerSize',15)
% set(gca, 'YScale', 'log')
% xlabel('iteration')
% ylabel('f^* - f')
% title('SQP - Problem 2 with H_k = I')




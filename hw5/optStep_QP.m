% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng, 4/19/2022

% Function that: Quadratic Penalty Method
                
% 
%           Inputs: x_bar, problem, method, options
%           Outputs: x_bar_new, f_new, g_new, v_new
%
function [x_bar_new, f_bar_new, c_bar_new, f_g_bar_new, c_J_bar_new, k_inner_new] = optStep_QP(x_bar,v,k_inner,problem,method,options)

% globalized method as its contents would change when calling it in other
% functions in this function file

    phi_g_norm = inf;
    x = x_bar;

    % inner interation of optimization the surrogate problem with penalty
    % function add to the original objective function

    while phi_g_norm > 1/v % inner interation ternimation condition
         % computes relevent values with objective function and constrains
        k_inner = k_inner + 1;
        f = problem.compute_f(x);
        f_g = problem.compute_f_g(x);
        f_H = problem.compute_f_H(x);
    
        c = problem.compute_c(x);
        c_J = problem.compute_c_J(x);
        c_H = problem.compute_c_H(x);
        
        % Newton's method with backtracking line search for optimization of
        % the surrogate objective phi(x,v)
        phi = f + v/2*norm(c)^2;
        phi_g = f_g + v*c_J'*c;
        phi_H = f_H + v*c_J'*c_J + v*vec_mul_tensor(c,c_H);
        phi_g_norm = norm(phi_g);

        % optimization direction
        phi_d = -phi_H\phi_g;
        
        % backtracking line search
        alpha = line_search(x,phi,phi_g,phi_d,v,problem,method);   
        x = x + alpha*phi_d;

    end
    % output for next outer QP iteration
    x_bar_new = x;
    f_bar_new = f;
    c_bar_new = c;
    f_g_bar_new = f_g;
    c_J_bar_new = c_J;
    k_inner_new = k_inner;
 
end


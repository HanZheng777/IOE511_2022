% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng, 4/19/2022

% Function that: Sequential Quadratic Programming Method
                
% 
%           Inputs: x, lambda, problem,method,options
%           Outputs: x_new, f_new, c_new, f_g_new, c_g_new, lamda_new
%
function [x_new, f_new, c_new, f_g_new, c_g_new, lamda_new] = optStep_SQP(x, lambda, problem,method,options)

    % computes relevent values with objective function and constrains
    f = problem.compute_f(x);
    f_g = problem.compute_f_g(x);
    f_H = problem.compute_f_H(x);
    
    zero = zeros(problem.c_m);
    c = problem.compute_c(x);
    c_J = problem.compute_c_J(x);
    c_H = problem.compute_c_H(x);

    % different choice of the H_k matrix in sovling the linear system in
    % SQP
%     H = eye(problem.n);
    H = f_H + vec_mul_tensor(lambda, c_H);
    
    % solve the linear system
    A = [H, c_J'; c_J, zero];
    b = -[f_g;c];
    sol = A\b;
    % get search dirction d and new Lagrangian l
    d = sol(1:problem.n);
    l = sol(problem.n+1:problem.n+problem.c_m);
    
    % output for next SQP iteration
    x_new = x + d;
    f_new = problem.compute_f(x_new);
    c_new = problem.compute_c(x_new);
    f_g_new = problem.compute_f_g(x_new);
    c_g_new = problem.compute_c_J(x_new);
    lamda_new = l;
end


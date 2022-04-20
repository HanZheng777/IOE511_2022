% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng
function alpha = line_search(x,phi,phi_g,phi_d,v,problem,method)

% Backtracking Line Search for optimizing the surrogate problem in Penalty Algorithm

alpha = method.options.ls_inital_step_size;
tol = method.options.ls_tol;
c_1 = method.options.ls_c_1;

phi_new = phi;

while phi_new > phi + c_1*alpha*phi_g.'*phi_d
    alpha = tol*alpha;
    f_new = problem.compute_f(x+alpha*phi_d);
    c_new = problem.compute_c(x+alpha*phi_d);
    phi_new = f_new + v/2*norm(c_new)^2;
end

end


 



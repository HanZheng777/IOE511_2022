% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that specifies the method and method specific options. 
% 
%           Input: method (struct); required (method.name)
%           Output: method (struct)
%
% Error(s): 
%   (1) if method not specified
%
function [method] = setMethod(method)

% check is method name specified
if ~isfield(method,'name')
    error('Method not specified!!!')
end

switch method.name
    case "GradientDescent"

    case "modified Newton"
        method.options.beta = 1e-6;
    case "BFGS"
        method.options.epsi = 1e-6;
    case "L-BFGS"
        method.options.epsi = 1e-6;
        method.options.memory = 10;
        method.options.H_k0 = @(size) eye(size);
end

% set the configs for step size searching method w.r.t optimization methods
switch method.options.step_type

    case 'Backtracking'
        method.options.inital_step_size = 1;
        method.options.tol = 0.5;
        method.options.c_1 = 1e-4;

    otherwise
        error('Name of step size searching method is not defined!!')

end


end
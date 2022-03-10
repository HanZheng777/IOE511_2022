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

% set the configs for step size searching method w.r.t optimization methods
switch method.options.step_type

    case 'Constant'
        method.options.constant_step_size = 1e-3;

    case 'Backtracking'
        method.options.inital_step_size = 1;
        method.options.tol = 0.5;
        method.options.c_1 = 1e-4;

    otherwise
        error('Name of step size searching method is not defined!!')

end


end
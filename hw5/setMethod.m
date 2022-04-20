% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng 4/19/2022

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

    case "Quadratic Penalty"
        method.options.gamma = 10;
        method.options.v_0 = 1e-4;

        method.options.ls_inital_step_size = 1;
        method.options.ls_tol = 0.5;
        method.options.ls_c_1 = 1e-4;

    case "Sequential Quadratic Programming"
        
end


end
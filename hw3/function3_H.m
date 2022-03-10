function [H] = function3_H(x)
%FUNCTION3_H Summary of this function goes here
%   computes the Hessian for function3
n = length(x);
H = eye(n);
H(1,1) = exp(-x(1))/10 - (2*exp(2*x(1)))/(exp(x(1)) + 1)^2 + exp(x(1))/(exp(x(1)) + 1) - (exp(x(1))*(exp(x(1)) - 1))/(exp(x(1)) + 1)^2 + (2*exp(2*x(1))*(exp(x(1)) - 1))/(exp(x(1)) + 1)^3;
for i = 2:n
    H(i,i) = 12*(x(i)-1)^2;
end

end


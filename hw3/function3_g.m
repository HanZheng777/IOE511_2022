function [g] = function3_g(x)
%FUNCTION3_G Summary of this function goes here
%  computes the gradient for function 3
n = length(x);
g = zeros(n,1);
g(1) = exp(x(1))/(exp(x(1)) + 1) - exp(-x(1))/10 - (exp(x(1))*(exp(x(1)) - 1))/(exp(x(1)) + 1)^2;

for i = 2:n
    g(i) = 4*(x(i)-1)^3;
end

end


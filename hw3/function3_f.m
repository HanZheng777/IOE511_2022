function [f] = function3_f(x)
%FUNCTION3_F Summary of this function goes here
%   computes the function value for function 3
n = length(x);
f = (exp(x(1))-1)/(exp(x(1))+1) + 0.1*exp(-x(1));
for i=2:n
    f = f + (x(i)-1)^4;
end

end


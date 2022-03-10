% IOE 511 HW1 Q9 - Han Zheng

x1 = -1;
x2 = 0.5;
f_x = x1 * exp(-0.5*(x1^2 + x2^2));
[d1,d2] = meshgrid(-.2:.01:.2, -.2:.01:.2);
% Compute the gradient & Hessian at given point
grad = [(1-x1^2)*exp(-0.5*(x1^2 + x2^2)); -x1*x2*exp(-0.5*(x1^2 + x2^2))];
Hess = [(x1^3-3*x1)*exp(-0.5*(x1^2 + x2^2)), -x2*(1-x1^2)*exp(-0.5*(x1^2 + x2^2));
    -x2*(1-x1^2)*exp(-0.5*(x1^2 + x2^2)), (x1*x2^2-x1)*exp(-0.5*(x1^2 + x2^2))];
% Taylor expansion (broadcasting)
len = size(d1);
F_bar = [];
for i = 1:len
    f_bar = f_x + grad'*[d1(1,:);d2(i,:)] + diag(0.5*[d1(1,:);d2(i,:)]'*Hess*[d1(1,:);d2(i,:)])';
    F_bar = [F_bar; f_bar];
end
% Plotting
surf(x1+d1,x2+d2,F_bar);
hold on 
[X1,X2] = meshgrid(-1.5:.1:-0.5, -1:.1:1); 
F = X1 .* exp(-0.5*(X1.^2 + X2.^2)); 
surf(X1,X2,F);
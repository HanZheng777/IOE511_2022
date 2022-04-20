% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng, 4/19/2022
function result_matix = vec_mul_tensor(vec, tensor)
% a helper function for multiply a 3D tensor with a 1D vector
n = length(tensor);
m = length(vec);
result_matix = zeros(n);
for i = 1:m
    product = vec(i) * tensor(:,:,i);
    result_matix = result_matix + product;
end


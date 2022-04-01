% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

function g = compute_g_LR(data, label, w, batch_size, full_gradient)

% computes the gradient for logistic regression loss

data_size = size(data);

% set batch data
if full_gradient == true
    data_batch = data;
    label_batch = label;
else
    index = randi([1,data_size(1)],batch_size,1);
    data_batch = data(index,:);
    label_batch = label(index,:);
end

g = zeros(data_size(2),1);
for i = 1:batch_size
    gi = -exp(-label_batch(i,:)*data_batch(i,:)*w)/(1+exp(-label_batch(i,:)*data_batch(i,:)*w))*label_batch(i,:)*data_batch(i,:)';
    g = g + gi;
end


g = g/batch_size;
end
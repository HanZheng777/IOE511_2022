% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

function  g = compute_g_LS(data, label, w, batch_size, full_gradient)
% computes the gradient for linear least square loss

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
    gi = data_batch(i,:)'*(data_batch(i,:)*w - label_batch(i,:));
    g = g + gi;
end

g = g/batch_size;

end


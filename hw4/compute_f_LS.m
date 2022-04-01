% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

function f = compute_f_LS(data, label, w)
% computes the loss value for linear least square loss

data_size = size(data);
f = 0;
for i = 1:data_size(1)
    fi = 1/2*(data(i,:)*w - label(i,:))^2;
    f = f + fi;
end

f = f/data_size(1);

end
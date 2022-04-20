

function f = compute_f_LR(data, label, w)

data_size = size(data);
f = 0;

for i = 1:data_size(1)
    fi = log(1+exp(-label(i,:)*data(i,:)*w));
    f = f + fi;
end

f = f/data_size(1);

end
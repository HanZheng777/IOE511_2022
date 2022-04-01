% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final weight, training loss, training accuracy, testing loss, testing accuracy

function [w,f_tr,acc_tr,f_te,acc_te] = optSolverML_Zheng_Han(problem,method,options)

% set batch size
switch method.name
    case "GD"
        batch_size = problem.X_train_size(1);
    case "SGD"
        batch_size = method.options.SGD_batch_size;
end

% initalization
w = problem.w0;
f_star = problem.f_star;

% set initial iteration counter
k = 1;

% plotting stuff
k_plot = [];
diff_tr_plot = [];
f_te_plot = [];
acc_tr_plot = [];
acc_te_plot = [];

k_interval = 1:batch_size;

% termination condition"
while batch_size*k < options.max_num_eval
    
    % execute optimization step
    [w_new, f_tr, f_te] = optStep(w,k,batch_size,problem,method,options);

    % update old and new function values
    w = w_new;
    % increment iteration counter
    k = k + 1;

    % compute optimality gap
    diff_tr = f_tr - f_star;

    % evaluate accuracy
    [acc_tr, acc_te] = evaluate(problem.X_train, problem.y_train, problem.X_test, problem.y_test, w);
    
    %plotting stuff
    k_plot = cat(2, k_plot, (k-2)*batch_size+k_interval);
    diff_tr_plot = cat(2, diff_tr_plot, diff_tr*ones(1, batch_size));
    f_te_plot = cat(2, f_te_plot, f_te*ones(1, batch_size)); 
    acc_tr_plot = cat(2, acc_tr_plot, acc_tr*ones(1, batch_size));    
    acc_te_plot = cat(2, acc_te_plot, acc_te*ones(1, batch_size));

end

% plotting stuff
% color = 'm.';
% subplot(2,2,1)
% plot(k_plot,diff_tr_plot,color)
% hold on
% subplot(2,2,2)
% plot(k_plot,f_te_plot,color)
% hold on
% subplot(2,2,3)
% plot(k_plot,acc_tr_plot,color)
% hold on
% subplot(2,2,4)
% plot(k_plot,acc_te_plot,color)
% hold on

% set(gca, 'YScale', 'log')



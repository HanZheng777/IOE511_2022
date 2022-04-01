% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
%close all
clear all
clc

% set problem (minimal requirement: name of problem)
problem.data_name = 'Australian'; % data set name
problem.loss_name = 'LS'; % loss function name


% set method (minimal requirement: name of method)
method.name = 'SGD';
method.options.step_type = 'Constant';
method.options.SGD_batch_size = 128;

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);

% set options, computational budget
options.max_num_eval = 20*problem.X_train_size(1);

% run method and weight, training loss, training accuracy, testing loss, testing accuracy
[w,f_tr,acc_tr,f_te,acc_te] = optSolverML_Zheng_Han(problem,method,options);

% plotting stuff
% subplot(2,2,1)
% title("Australian data with LS loss - Optimality Gap")
% xlabel("num gradient eval")
% ylabel("F_t_r_a_i_n - F*")
% legend('batch size=1 & \alpha = 0.01','batch size=16 \alpha = 0.01','batch size=128 & \alpha = 0.01')
% 
% subplot(2,2,2)
% title("Australian data with LS loss - testing loss")
% xlabel("num gradient eval")
% ylabel("F_t_e_s_t")
% legend('batch size=1 & \alpha = 0.01','batch size=16 \alpha = 0.01','batch size=128 & \alpha = 0.01')
% 
% 
% subplot(2,2,3)
% title("Australian data with LS loss - training accuracy")
% xlabel("num gradient eval")
% ylabel("accuracy")
% legend('batch size=1 & \alpha = 0.01','batch size=16 \alpha = 0.01','batch size=128 & \alpha = 0.01')
% 
% 
% subplot(2,2,4)
% title("Australian data with LS loss - testing accuracy")
% xlabel("num gradient eval")
% ylabel("accuracy")
% legend('batch size=1 & \alpha = 0.01','batch size=16 \alpha = 0.01','batch size=128 & \alpha = 0.01')


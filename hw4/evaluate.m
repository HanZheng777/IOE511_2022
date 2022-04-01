function [train_acc, test_acc] = evaluate(X_train, y_train, X_test, y_test, w)
% computes the accuracy on training and testing data

num_correct_train = 0;
num_correct_test = 0;

% on training data
for i = 1:length(X_train)
    value = X_train(i,:)*w;
    label = y_train(i,:);
    if value >=0 && label == 1
        num_correct_train = num_correct_train + 1;
    elseif value <0 && label == -1
        num_correct_train = num_correct_train + 1;
    end

end

% on testing data
for i = 1:length(X_test)
    value = X_test(i,:)*w;
    label = y_test(i,:);
    
    if value >=0 && label == 1
        num_correct_test = num_correct_test + 1;
    elseif value <0 && label == -1
        num_correct_test = num_correct_test + 1;
    end


end

train_acc = num_correct_train/length(X_train);
test_acc = num_correct_test/length(X_test);

    
end


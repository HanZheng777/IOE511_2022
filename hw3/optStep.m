% IOE 511/MATH 562, University of Michigan
% Code written by: Han Zheng

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,d,alpha] = optStep(x,f,g,problem,method,options)

% globalized method as its contents would change when calling it in other
% functions in this function file
global method

switch method.name
    % GD with back tracking
    case 'GradientDescent'
        % optimization direction
        d = -g;
        [x_new, f_new, g_new, alpha] = line_search(x,f,g,d,problem,method);  

    % Modified Newton
    case 'modified Newton'
        
        H = problem.compute_H(x);
        % find the minimal diagonal element
        min_H = H(1,1);
        for i = 2:problem.n
            if H(i,i) < min_H
                min_H = H(i,i);
            end
        end
        
        if min_H > 0
            yeta = 0;
        else
            yeta = -min_H + method.options.beta;
            
        end
        % Cholesky factorization
        while true
            [R, flag] = chol(H+yeta*eye(problem.n));
            if flag == 0
                break
            else
                yeta = max(2*yeta, method.options.beta);
            end
        end
        % track if H is modified
        if yeta ~= 0
            fprintf("H is modified \n")
        end

        H = H + yeta*eye(problem.n);
        % optimization direction
        d = -H\g;

        [x_new, f_new, g_new, alpha] = line_search(x,f,g,d,problem,method);   
        
    
    % BFGS with skip 
    case 'BFGS'
        % optimzation direction 
        d = - method.info.H_inv*g;
        [x_new, f_new, g_new, alpha] = line_search(x,f,g,d,problem,method);   
        
        s = x_new - x;
        y = g_new - g;
        
        % BFGS update with skipp condition
        if s'*y > method.options.epsi*norm(s)*norm(y)
            method.info.H_inv = (eye(problem.n) - s*y'/(s'*y)) * method.info.H_inv * (eye(problem.n) - y*s'/(s'*y)) + s*s'/(s'*y);
        else
            % track if an update is skipped
            fprintf("update skipped \n")
        end


    % L-BFGS with skip
    case 'L-BFGS'
        % optimization direction
        d = -method.info.r;
        [x_new, f_new, g_new, alpha] = line_search(x,f,g,d,problem,method);  

        s = x_new - x;
        y = g_new - g;
        
        % copy (m-1) old pairs and store the newest pair
        method.info.s = method.info.s(:,2:method.options.memory);
        method.info.y = method.info.y(:,2:method.options.memory);
        method.info.s(:,end+1) = s;
        method.info.y(:,end+1) = y;

        % two loop L-BFGS update with skipp condition
        if s'*y > method.options.epsi*norm(s)*norm(y)
            % only use k+1 pairs when stored pairs in memory is less
            % than m
            if method.info.k + 1 < method.options.memory
                size = method.info.k + 1;
            
            else 
                size = method.options.memory;
            end
            valid_s = method.info.s(:,method.options.memory-size+1:end);
            valid_y = method.info.y(:,method.options.memory-size+1:end);
            
            % loop #1
            H_k0 = method.options.H_k0(problem.n);
            q = g_new;
            a_s = zeros(1, size);
            for i = size:-1:1
                a_i = 1/(valid_s(:,i)'*valid_y(:,i)) * valid_s(:,i)' * q;
                a_s(i) = a_i;
                q = q - a_i*valid_y(:,i);
            end
            % loop #2
            r = H_k0*q;
            for i = 1:size
                beta = 1/(valid_s(:,i)'*valid_y(:,i)) * valid_y(:,i)' * r;
                r = r + (a_s(i) - beta)*valid_s(:,i);
            end
            method.info.r = r;
        else
            % track if an update is skipped
            fprintf("update skipped \n")
   
        end
        
end

end


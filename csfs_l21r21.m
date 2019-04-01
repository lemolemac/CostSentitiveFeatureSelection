function [W, objs] = csfs_l21r21( X, Y, V, lambda, NIter)
% 21-norm loss with 21-norm regularization
% X: dim*n
% Y: n*c label matrix
% V: n*c cost matrix
% W: dim*c projection matrix
% lambda : hyper_parameter

% Formulation:
% min_W  || (X'W - Y)oV ||_21 + lambda * ||W||_21  where o represents hadamard product
%  H=(X'W - Y)oV

[dim, n] = size(X);
[n, c] = size(Y);

% Initialize W0 for iterative optimization
% W0 = ones(dim, c);


% Prepare for iteration
W = zeros(dim, c);

% Wi = sqrt(sum(W0.*W0,2)+eps);
% d = 2* Wi;
% D = diag(d);
%
% H = (X' * W0 - Y) .* V;
% Hi = sqrt(sum(H.*H,2)+eps);
% g = 0.5 ./ Hi;
% G = diag(g);

d = ones(dim, 1);
g = ones(n, 1);


objs = zeros(NIter,1);

%--------------------------------------------------------------------------------------
% matrix inverse for smaller dimension
%--------------------------------------------------------------------------------------
if dim < n
    fprintf('CSFS subproblem iterating...\n');
    for iter = 1 : NIter
        %in each iteration, get new W
        D = spdiags(d, 0, dim,  dim);
        G = spdiags(g, 0, n, n);
        for k = 1 : c
            E = spdiags(V(:,k),0, n, n);
            %         sum_gvvxx = X*E * G *  E * X'  ;
            %         sum_gvvxy =  X*E * G *  E * Y(:,k) ;
            %         W( :,k ) = ( lambda*D + sum_gvvxx)\sum_gvvxy;
            DXEGE = D * X* E * G *  E;
            W( :,k ) = ( lambda*eye(dim) +DXEGE * X')\( DXEGE*Y(:,k) );
        end
        
        % finished current iteration, use new W to generate d, g, H etc.
        Wi = sqrt(sum(W.*W , 2)+eps);
        d = 2* Wi;
        
        
        H = (X' * W - Y) .* V;
        Hi = sqrt(sum(H.*H , 2)+eps);
        g = 0.5 ./ Hi;
        
        
        objs(iter) = sum(Hi) + lambda * sum(Wi);
        % fprintf('iter_obj_values(%d) is %f\n', iter, objs(iter));
    end;
else
    fprintf('CSFS subproblem iterating...\n');
    for iter = 1 : NIter
        %in each iteration, get new W
        D = spdiags(d, 0, dim,  dim);
        G = spdiags(g, 0, n, n);
        for k = 1 : c
            E = spdiags(V(:,k),0, n, n);
            %         sum_gvvxx = X*E * G *  E * X'  ;
            %         sum_gvvxy =  X*E * G *  E * Y(:,k) ;
            %         W( :,k ) = ( lambda*D + sum_gvvxx)\sum_gvvxy;
            DXEGE = D * X* E * G *  E;
            W( :,k ) = DXEGE * ( ( lambda*eye(n) + X' * DXEGE )\Y(:,k) );
        end
        
        % finished current iteration, use new W to generate d, g, H etc.
        Wi = sqrt(sum(W.*W , 2)+eps);
        d = 2* Wi;
        
        
        H = (X' * W - Y) .* V;
        Hi = sqrt(sum(H.*H , 2)+eps);
        g = 0.5 ./ Hi;
        
        
        objs(iter) = sum(Hi) + lambda * sum(Wi);
        % fprintf('CSFS_iter_obj_values(%d) is %f\n', iter, objs(iter));
    end;
end
end


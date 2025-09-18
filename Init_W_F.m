function [W,F,obj] = Init_W_F(X,F,n_classes)
% model: min_{Wv,F } sum{v=1-m} Tr(W'_vX_vHnX_v'W_v-2W'_vX_vHnF-FHcF')
% Becasue X is centered, the matrix H is removed

% X is a cell matrix with each column represent a view (original view)
% F is the initinal indicator matrix
% n_classes is the number of labels

maxIter = 80;
% tic
numView = length(X); % the number of original views
n_samples = size(X{1},1); % the number of samples in each view


% F = litekmeans(X{2}, n_classes); % Initalize the  shared cluster indicator matrix 
% F = TransformL(F, n_classes);
IdX = zeros(1,numView);

StX = cell(1, numView);
W = cell(1, numView);
for v = 1:numView
    StX{v} = X{v}'*X{v};
    IdX(v) = size(X{v},2);
end
temp_regu = 1e-5;
obj = zeros(1,maxIter);
for Iter = 1:maxIter
  
   % update Wv
   WTXHn =  0;
    for v = 1:numView
        W{v} = (StX{v}+temp_regu*eye(IdX(v)))\(X{v}'*F);
        WTXHn = WTXHn + X{v}*W{v};
    end

    % update F
    F = zeros(n_samples,n_classes);
    [~, indices] = max(WTXHn, [], 2);
    linearIndices = sub2ind(size(F), (1:size(F,1))', indices);
    F(linearIndices) = 1; 
    
    %  objective function 
    for v = 1:numView
        temp1 = X{v}'*F;
        obj(Iter) = obj(Iter) + trace(W{v}'*StX{v}*W{v}-2*W{v}'*temp1+trace(F'*F));
    end
    
    if Iter > 1 && abs(obj(Iter - 1) - obj(Iter)) / abs(obj(Iter - 1)) < 1e-5
        obj =obj(1:Iter);
        break
    end
%     t=1;

end

% [~, ind] = max(F, [], 2);
% Tim = toc; 
function [alpha,ind,Tim,obj] = SMRC(X,Z,c,r,beta)
% model2: min_{W'v Wv=I} Tr(W'_vXHX'W_v-2W'_vX_vHF) �Ĵ���
% X is a cell matrix with each column represent a view (original view)
% Becasue X is centered, the matrix H is removed
% Z is the bipartite matrix of each view (original view)
% c is the number of labels

maxIter = 80;
obj = zeros(1,maxIter);
tic
numView = length(X); % the number of original views
n = size(X{2},1); % the number of samples in each view
Hn = eye(n)-ones(n)/n;
alpha = ones(1,numView)/numView;

F = litekmeans(Z{2}, c,'MaxIter', 50, 'Replicates', 10);  % Initalize the  shared cluster indicator matrix 
F = TransformL(F, c);
W = cell(1, numView); %  restore projection matrices of all views
St = cell(1, numView);
Q = cell(1, numView); %  restore projection matrices of all views
StZ = cell(1, numView);

for v = 1:numView
    d = size(X{v},2);
    W{v} = orth(rand(d,d));
    W{v} = W{v}(:,1:c);
    St{v} = X{v}'*X{v};
    temp = X{v}'*F;
    W{v}=GPI(W{v},St{v},temp);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d = size(Z{v},2);
    Q{v} = orth(rand(d,d));
    Q{v} = Q{v}(:,1:c);
    StZ{v} = Z{v}'*Z{v};
    temp = Z{v}'*F;
    Q{v}=GPI(Q{v},StZ{v},temp);
end


for Iter = 1:maxIter
  
    



    
    % update W, Q and objective function 
    temp_obj = zeros(1,numView);
    for v = 1:numView
        temp1 = X{v}'*F;
        W{v} = GPI(W{v},St{v},temp1);
        temp2 = Z{v}'*F;
        Q{v} = GPI(Q{v},StZ{v},temp2);
        v1 = X{v}*W{v}-Hn*F;
        v2 = Z{v}*Q{v}-Hn*F;
        temp_obj(v) = beta* trace(v1*v1') + (1-beta)*trace(v2*v2');
        obj(Iter) = obj(Iter) + alpha(v)^r*temp_obj(v);

    end
    
    if Iter > 1 && abs(obj(Iter - 1) - obj(Iter)) / abs(obj(Iter - 1)) < 1e-5
        obj =obj(1:Iter);
        break
    end

    %  update alpha
    rr = 1/(1-r);
    for v = 1:numView
        alpha(v) = (r*temp_obj(v))^rr;
    end

    alpha = alpha./(sum(alpha,2));

    % update F

    F = zeros(n,c);
    F_temp = zeros(n,c);
    for v = 1:numView
        B = beta*X{v}*W{v}+(1-beta)*Z{v}*Q{v};
        F_temp = F_temp + alpha(v)^r*B;
    end
    [~, indices] = max(F_temp, [], 2);
    linearIndices = sub2ind(size(F), (1:size(F,1))', indices);
    F(linearIndices) = 1;
    
    

end

[~, ind] = max(F, [], 2);
Tim = toc; 
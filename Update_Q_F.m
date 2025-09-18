function [U,F] = Update_Q_F(Z,F)

obj = [];
maxiter = 10;
for i=1:maxiter
    Q = Z'*F;
    Q = Q*diag(sqrt(1./(diag(Q'*Q)+eps)));
    G = 2*G.*(alpha*G + eps)./(tempG1 + tempG2 - tempG3 + alpha*G*tempG4 + eps);
    tempG = G'*G;
    G = G*diag(sqrt(1./(diag(tempG)+eps)));
end



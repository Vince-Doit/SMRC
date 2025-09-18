% Generalized power iteration method (GPI) for solving 
% min_{W'W=I} Tr(W'AW-2W'B)
function [W,obj]=GPI(W,A,B)
%Input: 
% A as any symmetric matrix with dimension m*m; B as any skew matrix with dimension m*k,(m>=k);
% s can be chosen as 1 or 0, which stand for different ways of determining relaxation parameter alpha. i.e. 1 for the power method and 0 for the eigs function.
%Output: 
% W and convergent curve.

% Feiping Nie, Rui Zhang, Xuelong Li. A generalized power iteration method for solving quadratic problem on the Stiefel manifold. SCIENCE CHINA Information Sciences 60, 112101, 2017. doi: 10.1007/s11432-016-9021-9
%View online: http://engine.scichina.com/doi/10.1007/s11432-016-9021-9


[m,~]=size(B);
A=max(A,A');
alpha=abs(eigs(A,1))*100;
        
err=1;t=1;
A_til=alpha.*eye(m)-A;
obj=[];
while err>1e-3
    M=2*A_til*W+2*B;
    [U,~,V]=svd(M,'econ');
    W=U*V';
    obj(t)=trace(W'*(-A)*W+2*W'*B);
    if t>=2
        err=abs(obj(t-1)-obj(t))/abs(obj(t-1));
    end
        t=t+1;
    if  t>=1
        break;
    end
end

    
    
    
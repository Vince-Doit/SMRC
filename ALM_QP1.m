% sovling problem min_{x'1=1, x>=0} x'Ax-x'b
% using ALM to the counterpart min_{x'1=1, x=v, v>=0} x'Av-x'b
% written by HanZhang
% 2018. 12.4
function [x, v, ob, eta]=ALM_QP1(A, b, x0)
NIter = 500;
[n] = size(A,1);
if nargin < 3
    x = 1/n*ones(n,1);
else
    x = x0;
end
mu = 1.5;
eta = ones(size(b,1),1);
rho = 1.01;

for iter = 1:NIter
    inmu = 1/mu;
	
    z = x+(eta(:,iter)-A'*x)*inmu;
    v = max(z,0);

    e = v - (eta(:,iter)+A*v-b)*inmu;
    phi = (1-sum(e))/n;
    x = e+phi*ones(n,1);
	
    ob(iter) = x'*A*x - x'*b;
    if iter > 2
        err = abs(ob(iter)-ob(iter-1));
%         err = norm(x-v,'fro');
        err = norm(eta(:,iter)-eta(:,iter-1),'fro');
        if err < 1e-6
            break;
        end
    end
    eta(:,iter+1) = eta(:,iter)+mu*(x-v);
    mu = rho*mu; 
end
end

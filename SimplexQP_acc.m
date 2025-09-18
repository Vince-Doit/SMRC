function [x, obj] = SimplexQP_acc(A, b,x0)
%  min  x'*A*x - x'*b
%  s.t. x'1=1, x>=0
NIter = 30;
NStop = 20;

[n] = size(A,1);
if nargin < 4
    x = 1/n*ones(n,1);
else
    x = x0;
end

x1 = x;
t = 1;
t1 = 0;
r = 1.01;  % r=1/mu;
obj = zeros(NIter,1);
for iter = 1:NIter
    p = (t1-1)/t;
    s = x + p*(x-x1);
    x1 = x;
    g = 2*A*s - b;
    z_num = size(g,1);
    ob1 = x'*A*x - x'*b;
    for it = 1:NStop
        z = s - r*g;
        z = EProjSimplex_new(z,1);  % z'1=1;z>=0; z=alpha;      
        ob = z'*A*z - z'*b;
        if ob1 < ob
            r = 0.5*r; % rho=2;
        else
            break;
        end
    end
    if it == NStop
        obj(iter) = ob;
        %disp('not');
        break;
    end
    x = z;
    t1 = t;
    t = (1+sqrt(1+4*t^2))/2;
    
    
    obj(iter) = ob;
end

obj = obj(1:iter);
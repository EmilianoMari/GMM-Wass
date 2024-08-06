clear
for g=1:10000
x0=[rand; rand; rand; rand; rand; rand; rand];
Aeq=[1 1 1 1 0 0 0];
beq=1;
lb = [0 0 0 0.01 -inf 0.000002 -inf];
ub = [1 1 1 0.02 inf inf inf];
[x ll] = fmincon('rig_eng',x0,[],[],Aeq,beq,lb,ub);
if rig_eng(x) <5e-10
    break
    else
    end
end
x'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=[x(1)    x(2)    x(3)    x(4)];
m=[0.4856 0.4790 0.5064 x(5)];	
v=[0.0670^2 0.0221^2 0.1651^2 x(6)];
a=size(m);
n=a(2);
for j=1:n
    x1(j)=m(j);
    x2(j)=v(j)+m(j)^2;
    x3(j)=m(j)^3+3*m(j)*v(j);
    x4(j)=m(j)^4+6*m(j)^2*v(j)+3*v(j)^2;
end
X1=w*x1';
X2=w*x2';
X3=w*x3';
X4=w*x4';
mu=X1;
sig=sqrt(X2-X1^2);
sk=(X3-3*X2*X1+2*X1^3)/sig^3;
kur=(X4-4*X3*X1+6*X2*X1^2-3*X1^4)/sig^4;
A=[mu+x(7) sig sk kur]

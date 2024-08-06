clear
nobs=1825; 
for g=1:10000
b=[rand,rand,rand,rand,rand,rand,rand,rand,rand];
Aeq=[0 0 0 0 0 0 1 1 1];
beq=1;
lb=[-inf,0.0001,-inf,0.0001,-inf,0.0001,0,0,0];
ub=[inf,inf,inf,inf,inf,inf,1,1,1];
options=optimset('MaxFunEvals',1e22)
[x,ll,ar,af,ag,grad,hess]=fmincon('threegmm',b,[],[],Aeq,beq,lb,ub,[],options)
if threegmm(x) < -2247.
    break
    else
    end
end
C=sqrt(inv(hess));
D=diag(C)'
SC=2*ll+(length(b)-1)*log(nobs)
x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=[x(7) x(8) x(9)];
m=[x(1) x(3) x(5)];	
v=[x(2)^2 x(4)^2 x(6)^2];
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
A=[mu sig sk kur]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load baryc_ave.dat
X=baryc_ave;
mu = [x(1) x(1);x(3) x(3);x(5) x(5)];                    
sigma = cat(3,[x(2)^2 0;0 x(2)^2],[x(4)^2 0;0 x(4)^2],[x(6)^2 0;0 x(6)^2]);
p=[x(7);x(8);x(9)];
gm = gmdistribution(mu,sigma,p);
r=random(gm,nobs);
Y=r(:,1);
SX=sort(X);
SY=sort(Y);
ffff=sum(abs(SX-SY))/(nobs-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[f0,xi] = ksdensity(X);
[f1,xi1] = ksdensity(Y);
plot(xi,f0);
hold on
plot(xi1,f1);
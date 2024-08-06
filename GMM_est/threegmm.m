function f=threegmm(b)
load baryc_ave.dat; 
x=baryc_ave;
h=size(x);
nobs=h(1);
for k=1:nobs
    lik(k)=b(7)/sqrt(2*pi*b(2)^2)*exp(-1/(2*b(2)^2)*(x(k)-b(1))^2)...
          +b(8)/sqrt(2*pi*b(4)^2)*exp(-1/(2*b(4)^2)*(x(k)-b(3))^2)...
          +b(9)/sqrt(2*pi*b(6)^2)*exp(-1/(2*b(6)^2)*(x(k)-b(5))^2);
if lik(k)==0
      lik=exp(-15)*ones(1,nobs-1);
       break
   else
       lik(k)=lik(k);
   end    
   end
f=-sum(log(lik))
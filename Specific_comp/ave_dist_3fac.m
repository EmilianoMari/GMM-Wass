clear
load gas_1826.dat
x1=log(gas_1826); 
T1=smooth(x1,0.1,'loess'); 
y1=x1-T1; 
hh=size(x1);
n=hh(1);
for i=1:n-1
    r1(i)=y1(i+1)-y1(i); 
end
X=(r1-min(r1))/(max(r1)-min(r1));
a=[0.3882    0.5490    0.0483    0.0145    0.4827    0.0460   -0.0571];
%a=[0.7281    0.0408    0.1431    0.0880    0.3584    0.0007    0.0698];
b=[0.4856 0.0670 0.4790 0.0221 0.5064 0.1651];
mu = [b(1) b(1);b(3) b(3);b(5) b(5); a(5) a(5)];                    
sigma = cat(3,[b(2)^2 0;0 b(2)^2],[b(4)^2 0;0 b(4)^2],[b(6)^2 0;0 b(6)^2],[a(6) 0;0 a(6)]);
p=[a(1); a(2); a(3); a(4)];
gm = gmdistribution(mu,sigma,p);
for g=1:1000
r=random(gm,n-1)+a(7);
Y=r(:,1);
SX=sort(X);
SY=sort(Y);
ffff(g)=sum(abs(SX'-SY))/(n-1);
end
[mean(ffff) std(ffff)]
clear
load power_ave_1826.dat
x1=log(power_ave_1826); 
T1=smooth(x1,0.1,'loess'); 
y1=x1-T1; 
hh=size(x1);
n=hh(1);
for i=1:n-1
    r1(i)=y1(i+1)-y1(i); 
end
X=(r1-min(r1))/(max(r1)-min(r1));
%a=[0.3517    0.5788    0.0475    0.0220    0.4828    0.0382   -0.0569];
a=[0.8059 0.0216 0.1374 0.0351 0.6759 0.0379^2 0.0519];
b=[0.4856 0.0670 0.4790 0.0221 0.5064 0.1651];
mu = [b(1) b(1);b(3) b(3);b(5) b(5); a(5) a(5)];                    
sigma = cat(3,[b(2)^2 0;0 b(2)^2],[b(4)^2 0;0 b(4)^2],[b(6)^2 0;0 b(6)^2],[a(6) 0;0 a(6)]);
p=[a(1); a(2); a(3); a(4)];
gm = gmdistribution(mu,sigma,p);
for g=1:100000
r=random(gm,n-1)+a(7);
Y=r(:,1);
SX=sort(X);
SY=sort(Y);
ffff=sum(abs(SX'-SY))/(n-1)
if ffff < 0.0020
    break
    else
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[f0,xi] = ksdensity(X);
[f1,xi1] = ksdensity(Y);
plot(xi,f0);
hold on
plot(xi1,f1);
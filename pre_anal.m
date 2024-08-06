clear
load power_ave_1826.dat; load gas_1826.dat; 
x1=log(power_ave_1826); x2=log(gas_1826); 
n=1826;
T1=smooth(x1,0.1,'loess'); T2=smooth(x2,0.1,'loess');
y1=x1-T1; y2=x2-T2; 
for i=1:n-1
    r1(i)=y1(i+1)-y1(i); r2(i)=y2(i+1)-y2(i);
end
%z1=normalize(r1); z2=normalize(r2);  
z1=(r1-min(r1))/(max(r1)-min(r1)); z2=(r2-min(r2))/(max(r2)-min(r2));
[f1,a1] = ksdensity(z1); [f2,a2] = ksdensity(z2);
s1=sort(z1); s2=sort(z2); 
sb=(s1+s2)/2;
[fb,ab] = ksdensity(sb);
Ab=[mean(sb) std(sb) skewness(sb) kurtosis(sb)]
A1=[mean(s1) std(s1) skewness(s1) kurtosis(s1)]
A2=[mean(s2) std(s2) skewness(s2) kurtosis(s2)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('baryc_ave.dat', 'w'); fprintf(fid, '%d\n', sb); fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(ab,fb)
hold on
plot(a2,f2,'red')
hold on
plot(a1,f1,'green')
%plot(r1,'green')
%hold on
%plot(r2,'red')

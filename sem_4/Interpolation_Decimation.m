%Interpolation and Decimation
clc
clear

xn = input("Enter the sequence x[n]");
I = input("Enter the interpolation factor");
D = input("Enter the decimation factor");
N = length(xn);
n = 0:1:N-1;
subplot(2,2,1);
stem(n,xn);
title('Input Sequence');
xlabel('Timestep n');
ylabel('Amplitude');

%Interpolation
yn = [zeros(1,I*N)];
k = 0;
for i = 1:I*N
    if mod(i-1,I)==0
        k = k+1;
        yn(i) = xn(k);
    else
        yn(i) = 0;
    end
end
j = 0:1:(I*N-1);
subplot(2,2,2);
stem(j,yn);
title('Interpolated Sequence');
xlabel('Timestep n');
ylabel('Amplitude');

%Decimation
p = 0;
for i=1:N
    if mod(i-1,D)==0
        p = p+1;
        z(p) = xn(i);
    end
end

if mod((N/D),1)==0
    m=N/D-1;
else
    m = floor(N/D);
end

n1 = 0:1:m;
subplot(2,2,3);
stem(n1,z);
title('Decimated Sequence');
xlabel('Timestep n');
ylabel('Amplitude');



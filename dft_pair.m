%DFT PAIR
clc
clear

%Generation of DFT of a sequence
xn = input('Enter the sequence x[n]');
n = input('Enter the number of points');
n0 = length(xn);
if n>n0
    xn = [xn zeros(1,n-n0)];
else
    xn = xn(1,1:n);
end

n0 = length(xn);
Xk = zeros(1,n);
   

for ni = 0:n-1
    for k = 0:n-1
        Xk(k+1) = Xk(k+1) + (xn(ni+1)*exp(((-1i)*2*pi*k*ni)/n0));
    end
end
disp("DFT of the input sequence");
disp(Xk);

%Generation of IDFT of a sequence
Xk = input('Enter the sequence X[k]');
n = input('Enter the number of points');
n0 = length(Xk);
if n>n0
    Xk = [Xk zeros(1,n-n0)];
else
    Xk = Xk(1,1:n);
end
xn = zeros(1,n);
n0 = length(Xk);


for ni = 0:n-1
    for k = 0:n-1
        xn(ni+1) = xn(ni+1) + (Xk(k+1)*exp(((1i)*2*pi*k*ni)/n0));
    end
end
xn = xn/n;
disp("IDFT of the input sequence");
disp(xn);
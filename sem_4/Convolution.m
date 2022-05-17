%Convolution
clc
clear

%LINEAR CONVOLUTION
disp('Linear Convolution using Matrix Method');
xn = input("Enter the input sequence x[n]");
hn = input("Enter the impulse response h[n]");
n1 = length(xn);
n2 = length(hn);
N = n1+n2-1;
subplot(4,3,1); stem(0:1:n1-1,xn); title('Input Sequence'); 
xlabel('Timestep n'); ylabel('Amplitude');
subplot(4,3,2); stem(0:1:n2-1,hn); title('Impulse Response');
xlabel('Timestep n'); ylabel('Amplitude');


%Creating the matrix for convolution
if n1>n2
    x = zeros(N,n2);
    xn = [xn zeros(1,N-n1)];
    x(:,1) = xn;
    for i = 2:n2
        x(:,i) = [x(N,i-1) ; x(1:N-1,i-1)]; 
    end
    yn = x * hn';
else
    x = zeros(N,n1);
    hn = [hn zeros(1,N-n2)];
    x(:,1) = hn;
    disp(x);
    for i = 2:n1
        x(:,i) = [x(N,i-1) ; x(1:N-1,i-1)]; 
    end
    yn = x * xn';
end

subplot(4,3,3); stem(0:1:N-1,yn); title('Convoluted Output');
xlabel('Timestep n'); ylabel('Amplitude');
disp('Linear Convolution using Matrix Method');
disp(yn);

%CIRCULAR CONVOLUTION
disp('Circular Convolution using Matrix Method');
xn = input("Enter the input sequence x[n]");
hn = input("Enter the impulse response h[n]");
n1 = length(xn);
n2 = length(hn);

subplot(4,3,4); stem(0:1:n1-1,xn); title('Input Sequence'); 
xlabel('Timestep n'); ylabel('Amplitude');
subplot(4,3,5); stem(0:1:n2-1,hn); title('Impulse Response');
xlabel('Timestep n');ylabel('Amplitude');

N = max(n1,n2);
if n1<N
    xn = [xn zeros(1,N-n1)];
else
    hn = [hn zeros(1,N-n2)];
end

% Creating the circularly rotated matrix
x = zeros(N,N); 
x(:,1) = xn;

for i = 2:N
    x(:,i) = [x(N,i-1) ; x(1:N-1,i-1)]; % Shifting to the right
end

yn = x * hn'; %Matrix Multiplication

subplot(4,3,6);stem(0:1:N-1,yn);title('Convoluted Output');
xlabel('Timestep n');ylabel('Amplitude');

disp(yn);

%LINEAR CONVOLUTION IN FREQUENCY DOMAIN (USING DFT)
disp('Linear Convolution in Frequency Domain');
xn = input("Enter the input sequence x[n]");
hn = input("Enter the impulse response h[n]");
n1 = length(xn);
n2 = length(hn);
N = n1+n2-1;

subplot(4,3,7);stem(0:1:n1-1,xn);title('Input Sequence');
xlabel('Timestep n');ylabel('Amplitude');
subplot(4,3,8);stem(0:1:n2-1,hn);title('Impulse Response');
xlabel('Timestep n');ylabel('Amplitude');

if n1<N
    xn = [xn zeros(1,(N-n1))];
end

if n2<N
    hn = [hn zeros(1,(N-n2))];
end

Xk = fft(xn,N);
Hk = fft(hn,N);

Yk = Xk.*Hk;
yn = ifft(Yk);

subplot(4,3,9);stem(0:1:N-1,yn);title('Convoluted Output');
xlabel('Timestep n');ylabel('Amplitude');

disp(yn);

%CIRCULAR CONVOLUTION IN FREQUENCY DOMAIN (USING DFT)
disp('Circular Convolution in Frequency Domain');
xn = input("Enter the input sequence x[n]");
hn = input("Enter the impulse response h[n]");
n1 = length(xn);
n2 = length(hn);
N = max(n1,n2);

subplot(4,3,10);stem(0:1:n1-1,xn);title('First Input Sequence');
xlabel('Timestep n');ylabel('Amplitude');
subplot(4,3,11);stem(0:1:n2-1,hn);title('Second Input Sequence');
xlabel('Timestep n'); ylabel('Amplitude');

if N~=n1
    xn = [xn zeros(1,n2)];
else
    hn = [hn zeros(1,n1)];
end

Xk = fft(xn,N);
Hk = fft(hn,N);

Yk = Xk.*Hk;
yn = ifft(Yk);

subplot(4,3,12);stem(0:1:N-1,yn);title('Convoluted Output');
xlabel('Timestep n');ylabel('Amplitude');

disp(yn);

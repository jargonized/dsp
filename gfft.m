function fm = gfft(x,N,k)
if length(x) < N
    x = [x zeros(1,N-length(x))];
end
x1 = [x 0];
d1 = 2*cos(2*pi*k/N);
W = exp(-i*2*pi*k/N);
y = filter(1,[1 -d1 1],x1);
fm = y(N+1) - W*y(N);
    
end

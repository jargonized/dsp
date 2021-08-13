%IIR Filter
 [n,wc] = cheb1ord(1,5.7512,3,20,'s');
 [b,a] = cheby1(n,3,wc,'low','s');
 
 [n,wc] = buttord(1,5.7512,3,20,'s');
 [b,a] = butter(n,3,wp,'low','s');
 
 
%FIR Filter
y = rectwin(N1);
% y = blackman(N1);
% y = hanning(N1);
% y = hamming(N1);
b=fir1(N,wc,m,y); 
X=fft(x); 
z=filter(b,1,x); 




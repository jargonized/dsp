% ISL Tasks Set 1

%3i
% A = 2;
% w = 0.5;
% N = 30;
% n = 0:N-1;
% y = A.*sin(w*n);
% subplot(221);
% stem(n,y);
% title('Sequence');
% xlabel('Timestep n');
% ylabel('Amplitude');
% 
% subplot(222);
% stem(n/2,y);
% title('Sequence - n/2');
% xlabel('Timestep n');
% ylabel('Amplitude');
% 
% 
% I = 2;
% yn = [zeros(1,I*N)];
% k = 0;
% for i = 1:I*N
%     if mod(i-1,I)==0
%         k = k+1;
%         yn(i) = y(k);
%     else
%         yn(i) = 0;
%     end
% end
% j = 0:1:(I*N-1);
% subplot(223);
% stem(j,yn);
% title('Time-scaled sequence - Expansion');
% xlabel('Timestep n');
% ylabel('Amplitude');
% 
% yn = interp(y,2);
% subplot(224);
% stem(j,yn);
% title('Time-scaled sequence - Interpolation');
% xlabel('Timestep n');
% ylabel('Amplitude');
% 
% 
% %3ii
% 
% H = tf([1 -0.5],[1 0.5 -0.1875],-1);
% pzmap(H)
% 
%4
clc
close 

f = 10;
fs = input('Enter the sampling frequency');

t = 0:0.01:4; % for continuous plot
ts = 0:1/fs:1-1/fs; % for sampling
n = length(ts);

%continous - time plot of the signal
y = sin(2*pi*f*t);
subplot(2,2,1);
plot(t,y);
title('Sum of sinusoids');
xlabel('Time');
ylabel('Amplitude');

%sampled version of the signal
y1 = sin(2*pi*f*ts);
subplot(2,2,2);
stem(1:n,y1);
title('Sampled Signal');
xlabel('Timestep');
ylabel('Amplitude');


%frequency spectrum of the signal
X = fftshift(fft(y));
c = abs(X);
subplot(2,2,3);
plot(c);
xlim([0 length(t)]);
title('Frequency Spectrum');
xlabel('Frequency');
ylabel('Magnitude');



    

% ISL MATLAB QUESTION

% Message signal maximum frequency, fm = 1000 Hz
% Nquist Frequency,fs >= 2fm implies fs>= 2000 Hz

clc
close 

fs = input('Enter the sampling frequency');

t = 0:1e-4:3/1; % for continuous plot
ts = 0:1/fs:5; % for sampling

%continous - time plot of the signal
y = sin(2*pi*1*t);
subplot(2,2,1);
plot(t,y);
title('Sum of sinusoids');
xlabel('Time');
ylabel('Amplitude');

%sampled version of the signal
y1 =sin(2*pi*1*ts);
subplot(2,2,2);
stem(ts,y1);
title('Sampled Signal');
xlabel('Timestep');
ylabel('Amplitude');


% %frequency spectrum of the signal
% X = fftshift(fft(y));
% df = fs/size(ts,1);
% f = fs/2*linspace(-1,1,fs);
% subplot(2,2,3);
% stem(f,abs(X));
% title('Frequency Spectrum');
% xlabel('Frequency');
% ylabel('Magnitude');

%signal reconstruction
%using inbuilt function rectplus which implements zeroth-order
%interpolation
% n = 0:1/fs:1-1/fs;
% N = length(n);
% ta = 0:0.001:1;
% Na = length(ta);
% z = y*rectpuls(fs*(ones(N,1)*ta-n'*ones(1,Na)));

% z = zeros(1,length(t));
% samples = length(ts);
% for i = 1:1:length(t)
%     for n = 1:1:samples
%         z(i) = z(i) + y(n)*sinc((t(i)-n*ts)/ts); 
%     end
% end

%zeorth order interpolation
% n=0:0.01:1;%time index
% N=length(n);%number of sampled points
% ta=0:0.001:1;%reconstruction time
% y1=[]; % can we preallocated for speed
% for i=1:N-1
%     y1=[y1 ones(1,10)*y(i)];
% end
% y1=[y1 y(end)];%it was one element too short
% subplot(2,2,4);
% plot(ta,y1);
% title('Reconstructed Signal');
% xlabel('Time');
% ylabel('Amplitude');










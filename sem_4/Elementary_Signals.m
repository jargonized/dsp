%Generation of Elementary Signals
clc
clear

% %Unit Impulse Signal
% n = -2:1:2;
% amp = [zeros(1,2),ones(1,1),zeros(1,2)];
% subplot(3,3,1);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Unit Impulse Signal");
% 
% %Unit Step Signal
% k = input("Enter the value of n: ");
% n = -k:1:k;
% amp = [zeros(1,k), ones(1,k+1)];
% subplot(3,3,2);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Unit Step Signal");
% 
% %Ramp Signal
% k = input("Enter the value of n: ");
% n = -k:1:k;
% amp = zeros(1,2*k+1);
% for i = k+1:2*k+1
%     amp(i) = n(i);
% end
% subplot(3,3,3);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Ramp Signal");
% 
% %Time shifted Unit Impulse
% n0 = input("Enter the value of time shift(+ for advance, - for delay): ");
% n = -2-n0:1:2-n0;
% amp = [zeros(1,2),ones(1,1),zeros(1,2)];
% subplot(3,3,4);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Time Shifted Unit Impulse Signal");
% 
% %Time shifted Unit Step
% k = input("Enter the value of n: ");
% n0 = input("Enter the value of time shift(+ for advance, - for delay): ");
% n = -k-n0:1:k-n0;
% amp = [zeros(1,k), ones(1,k+1)];
% subplot(3,3,5);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Time shifted Unit Step Signal");

%Time shifted Ramp Signal
k = input("Enter the value of n: ");
n0 = input("Enter the value of time shift(+ for advance, - for delay): ");
n = -k-n0:1:k-n0;

amp = zeros(1,2*k+1);
for i = -k-n0:k-n0
    if i>=1
        amp(i) = i;
    end
end 
subplot(111);
stem(n,amp);
xlabel("Timestep n");
ylabel("Function value y[n]");
title("Ramp Signal");

% %Growing Exponential Signal
% k = input("Enter the value of n: ");
% a = input("Enter the value of a>1: ");
% n = -k:1:k;
% amp = zeros(1,2*k+1);
% for i = -k:k
%     amp(i+k+1) = a.^i;
% end
% subplot(3,3,6);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Growing Exponential Signal");
% 
% %Decaying Exponential Signal
% k = input("Enter the value of n: ");
% a = input("Enter the value of 0<a<1: ");
% n = -k:1:k;
% amp = zeros(1,2*k+1);
% for i = -k:k
%     amp(i+k+1) = a.^i;
% end
% subplot(3,3,7);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Decaying Exponential Signal");
% 
% %Zigzag Growing Exponential Signal
% k = input("Enter the value of n: ");
% a = input("Enter the value of a<-1: ");
% n = -k:1:k;
% amp = zeros(1,2*k+1);
% for i = -k:k
%     amp(i+k+1) = a.^i;
% end
% subplot(3,3,8);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Zigzag Growing Exponential Signal");
% 
% %Zigzag Decaying Exponential Signal
% k = input("Enter the value of n: ");
% a = input("Enter the value of -1<a<0: ");
% n = -k:1:k;
% amp = zeros(1,2*k+1);
% for i = -k:k
%     amp(i+k+1) = a.^i;
% end
% subplot(3,3,9);
% stem(n,amp);
% xlabel("Timestep n");
% ylabel("Function value y[n]");
% title("Zigzag Decaying Exponential Signal");


















clc;
clear all;
close all;

Rb = 1e3; Tb = 1/Rb;
Nb = 100;
fs = Rb*Nb;
Ts = 1/fs;
n = 0:1:Nb-1;
b = randi([0,1],Nb,1);
func_array = {@UNRZ,@PNRZ,@Manchester,@RCP};
array = {'Unipolar NRZ', 'Polar NRZ', 'Manchester', "Nyquist Pulse", 'Raised Cosine Pulse'};

for i=1:5
    if (i==5)
        fun = func_array{i-1};
    else
        fun = func_array{i};
    end

    if (i==4)
        alpha = 0;
        [a,v] = fun(b,alpha,Tb,Ts);
    elseif (i==5)
        alpha = 0.5;
        [a,v] = fun(b,alpha,Tb,Ts);
    else
        [a,v] = fun(b,Nb,Ts);
    end

 imptrain = zeros(1,(Nb-1)*Nb+1);
 imptrain(1:Nb:end) = a;
 encoded = conv(imptrain,v);
 %[px,fx] = pspectrum(encoded,fs,'FrequencyResolution',100);
 [px,fx] = pwelch(encoded,[],[],[],fs);
 t1 = 0:Ts:(length(encoded)-1)*Ts;
 subplot(4,1,2);
 plot(t1,encoded);
 subplot(4,1,3);
 plot(fx,10*log10(px));
 subplot(4,1,4);
 stem(n*Tb,b);
    
end

function [a,v] = UNRZ(b,N,Ts)
    a = b;
    t = (0:N-1)*Ts;
    v = ones(1,N);
    figure;subplot(4,1,1);
    plot(t,v);title("UNRZ")
end

function [a,v] = PNRZ(b,N,Ts)
    a = b; a(a==0)=-1;
    t = (0:N-1)*Ts;
    v = ones(1,N);
    figure;subplot(4,1,1);
    plot(t,v);title('PNRZ')
end

function [a,v] = Manchester(b,N,Ts)
    a = b; a(a==0) = -1;
    t = (0:N-1)*Ts;
    v = [ones(1,N/2) -ones(1,N/2)];
    figure;subplot(4,1,1);
    plot(t,v);title('man')
end

function [a,v] = RCP(b,alpha,Tb,Ts)
    a = b; a(a==0) = -1;
    Ntow = 3;
    delta = 1e-12*Tb;
    t = -Ntow*Tb+delta:Ts:Ntow*Tb;
    v = sinc(t/Tb).*cos(pi*alpha*t/Tb)./(1-(4*(alpha^2)*(t.^2))/(Tb^2));
    figure;subplot(4,1,1);
    plot(t,v);title('RCP')
end



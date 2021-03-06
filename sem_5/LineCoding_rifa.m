clc;
clear all;
close all;

nb = 100; %No.of bits
br = 2e3; tb = 1/br; ts = tb/nb; fs = 1/ts; N = tb/ts;

n = 0:(nb - 1);
b = randi([0 1],1,nb);

A = 1;
i=1;

for j = 1:5
    if (i==1)
        %UNIPOLAR NRZ
        v = ones(1,N);
        a = A*b;
        figure;
        subplot(3,1,1);plot((nb+1)*tb,v);title('UNIPOLAR NRZ CODING SCHEME');xlabel('t(s)');ylabel('Amplitude');
        axis([-tb, (nb+1)*tb min(v)-0.3 max(v)+0.3]);

        subplot(3,1,2);stem(n*tb,b);title('Random Signal');xlabel('t(s)');ylabel('Amplitude');
        axis([-tb, (nb+1)*tb min(b)-0.3 max(b)+0.3]);

        imp_train = zeros(1,(nb-1)*(N+1));
        imp_train(1:N:end) = a;
        x = conv(imp_train,v);
        t = 0:ts:[length(x)-1]*ts;
        subplot(3,1,3);plot(t,x);title('Coded Output');xlabel('t(s)');ylabel('Amplitude');
        axis([-tb, (nb+1)*tb min(x)-0.3 max(x)+0.3])

        [p,f] = pspectrum(x,fs,'FrequencyResolution',130);
        figure;
        plot(fs,10*log10(p));title('Spectrum Analysis');xlabel('f(Hz)');ylabel('Power(dB)');
        %axis([0 10e3 -70 10]);
    end

%     if (i==2)
%         %POLAR NRZ
%         v = ones(1,N);
%         a = A*b; a(a==0)=-1
%         figure;
%         subplot(3,1,1);plot((nb+1)*tb,v);title('POLAR NRZ CODING SCHEME');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(v)-0.3 max(v)+0.3]);
% 
%         subplot(3,1,2);stem(n*tb,b);title('Random Signal');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(b)-0.3 max(b)+0.3]);
% 
%         imp_train = zeros(1,(nb-1)*(N+1));
%         imp_train(1:N:end) = a;
%         x = conv(imp_train,v);
%         t = 0:ts:[length(x)-1]*ts;
%         subplot(3,1,3);plot(t,x);title('Coded Output');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(x)-0.3 max(x)+0.3])
% 
%         [p,f] = pspectrum(x,fs,'FrequencyResolution',130);
%         figure;
%         plot(fs,10*log10(p));title('Spectrum Analysis');xlabel('f(Hz)');ylabel('Power(dB)');
%         axis([0 10e3 -70 10]);
%     end
% 
%     if(i==3)
%         %MANCHESTER
%         v = [ones(1,N/2) -ones(1,N/2)];
%         a = A*b; a(a==0)=-1
%         figure;
%         subplot(3,1,1);plot((nb+1)*tb,v);title('MANCHESTER CODING SCHEME');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(v)-0.3 max(v)+0.3]);
% 
%         subplot(3,1,2);stem(n*tb,b);title('Random Signal');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(b)-0.3 max(b)+0.3]);
% 
%         imp_train = zeros(1,(nb-1)*(N+1));
%         imp_train(1:N:end) = a;
%         x = conv(imp_train,v);
%         t = 0:ts:[length(x)-1]*ts;
%         subplot(3,1,3);plot(t,x);title('Coded Output');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(x)-0.3 max(x)+0.3])
% 
%         [p,f] = pspectrum(x,fs,'FrequencyResolution',130);
%         figure;
%         plot(fs,10*log10(p));title('Spectrum Analysis');xlabel('f(Hz)');ylabel('Power(dB)');
%         axis([0 10e3 -70 10]);
%     end
% 
%     if i==4
%         %POLAR NYQUIST PULSE
%         nt = 3; t = -nt*tb:ts:nt*tb; BW = br/20;
%         v = sinc(2*BW*t);
%         a = A*b; a(a==0)=-1
%         figure;
%         subplot(3,1,1);plot((nb+1)*tb,v);title('POLAR NYQUIST PULSE CODING SCHEME');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(v)-0.3 max(v)+0.3]);
% 
%         subplot(3,1,2);stem(n*tb,b);title('Random Signal');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(b)-0.3 max(b)+0.3]);
% 
%         imp_train = zeros(1,(nb-1)*(N+1));
%         imp_train(1:N:end) = a;
%         x = conv(imp_train,v);
%         t = 0:ts:[length(x)-1]*ts;
%         subplot(3,1,3);plot(t,x);title('Coded Output');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(x)-0.3 max(x)+0.3])
% 
%         [p,f] = pspectrum(x,fs,'FrequencyResolution',130);
%         figure;
%         plot(fs,10*log10(p));title('Spectrum Analysis');xlabel('f(Hz)');ylabel('Power(dB)');
%         axis([0 10e3 -70 10]);
%     end
% 
%     if i==5
%         nt = 3; alpha = 0.5; k = (16*BW^2)*(alpha^2); del =tb*1e-10; BW = br/20;
%         t = -nt*tb+del: ts : nt*tb;
%         v = sinc(2*BW*t).*cos(2*pi*alpha*BW*t)./(1-(k*t).^2);
%         a = A*b; a(a==0)=-1
%         figure;
%         subplot(3,1,1);plot((nb+1)*tb,v);title('POLAR RAISED COSINE PULSE CODING SCHEME');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(v)-0.3 max(v)+0.3]);
% 
%         subplot(3,1,2);stem(n*tb,b);title('Random Signal');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(b)-0.3 max(b)+0.3]);
% 
%         imp_train = zeros(1,(nb-1)*(N+1));
%         imp_train(1:N:end) = a;
%         x = conv(imp_train,v);
%         t = 0:ts:[length(x)-1]*ts;
%         subplot(3,1,3);plot(t,x);title('Coded Output');xlabel('t(s)');ylabel('Amplitude');
%         axis([-tb, (nb+1)*tb min(x)-0.3 max(x)+0.3])
% 
%         [p,f] = pspectrum(x,fs,'FrequencyResolution',130);
%         figure;
%         plot(fs,10*log10(p));title('Spectrum Analysis');xlabel('f(Hz)');ylabel('Power(dB)');
%         axis([0 10e3 -70 10]);
%     end

end




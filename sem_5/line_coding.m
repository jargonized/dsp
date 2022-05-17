clc;
clear all;
close all;

%declarations
Rb = 1e3 ; %Bit rate
Tb = 1/Rb;
Nb = 100;
Ts = Tb/Nb;
fs = 1/Ts;
n=0:Nb-1;


b = randi([0, 1],Nb,1);
fun_array = {@NRZ,@PolarNRZ, @Manchester, @Raised_Cosine_Pulse};
array = {'Unipolar NRZ', 'Polar NRZ', 'Manchester', 'Nyquist Pulse', 'Raised Cosine Pulse(alpha=0.5)'};


for i = 1:5
    figure(i);
    annotation('textbox', [0.48, 0.88, 0.1, 0.1], 'String',array{i})
    if i==5
        func = fun_array{i-1};
    else
        func = fun_array{i};
    end
    
    if i==4
        [a,v] = func(b,0,Tb,Ts);
        
    elseif i==5
         [a,v] = func(b,0.5,Tb,Ts);
    else
       [a,v] = func(b,Nb,Ts);
    end
    
    
    imptrain = zeros(1,(Nb-1)*Nb+1);
    imptrain((1:Nb:end)) = a;
    x = conv(imptrain,v);
    t1 = 0:Ts:(length(x)-1)*Ts;
    [px,f] = pspectrum(x,fs,'FrequencyResolution',100);
    subplot(4,1,2);stem(n*Tb,b);
    title('Message bits');xlabel('Index(i)');ylabel('High(1) or Low(0)'); 
    subplot(4,1,3);plot(t1,x);
    title('Encoded Signal');xlabel('Time(s)');ylabel('Amplitude'); axis([0 0.1 -2.5 2.5]);
    subplot(4,1,4);plot(f,10*log10(px));
    title('Power Spectrum of the Encoded Signal');xlabel('Frequency(Hz)');ylabel('Power(dB)');axis([0 5000 -100 10]);
end

function [a,v] = NRZ(b,N,Ts)
    a = b;
    v = ones(1,N);
    t = (0:N-1)*Ts;
    subplot(4,1,1);plot(t,v);
    title('Basic Pulse Function');xlabel('Time(s)');ylabel('Amplitude');
end

function [a,v] = PolarNRZ(b,N,Ts)
    a=b;
    a(b==0) = -1;
    v = ones(1,N);
    t = (0:N-1)*Ts;
    subplot(4,1,1);plot(t,v);
    title('Basic Pulse Function');xlabel('Time(s)');ylabel('Amplitude');
end

function [a,v] = Manchester(b,N,Ts)
    a=b;
    a(b==0) = -1;
    v = [ones(1,N/2) -ones(1,N/2)];
    t = (0:N-1)*Ts;
    subplot(4,1,1);plot(t,v);
    title('Basic Pulse Function');xlabel('Time(s)');ylabel('Amplitude');
end

function [a,v] = Raised_Cosine_Pulse(b,alpha,Tb,Ts)
    a=b; a(a==0) = -1;
    Ntow=3;
    delta = Tb*1e-10;
    t = -Ntow*Tb+delta:Ts:Ntow*Tb;
    v = sinc(t/Tb).*cos(pi*alpha*t/Tb)./(1-((4*(alpha^2)*(t.^2))/(Tb^2)));
    subplot(4,1,1);plot(t,v);
    title('Basic Pulse Function');xlabel('Time(s)');ylabel('Amplitude');
    
end


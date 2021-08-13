function [B] = decode(Z,A,fa,d)
%
% This programm analyze a frequency coded signalvector and sort the won
% frequencies its key.
%
% example:     [B] = decode(Z,A,4000) 
%
% Z         : frequency coded signalvector 
% A         : dtmf key vector 
% fa        : sampling rate in hz
% d         : time in seconds
% B         : key vector

n=length(A);

for k=1:n
    % fft analyze of the frequency coded signalvector
    temp=abs(fft(Z(k,:)));                        

    % Analyze to the half sampling rate, because the frequencies after are
    % not interesting for analyze. They were created by sampling the signal 
    x=1:(fa/2)*d;
    % maximum of the array
    [a,i]=max(temp(x));
    % frequency 1 
    f1=(i/d)-1;
    % set the actuall x coordinate at area +/-10 to 0 
    i=i-10:i+10;
    temp(i)=0; 
    % maximum of the array
    [a,i]=max(temp(x));
    % frequency 2 
    f2=(i/d)-1;
    % frequency sort
    if f1>1000
        var=f1;
        f1=f2;
        f2=var;
    elseif f1<1000
    end
    % msgbox(num2str(f1));
    % msgbox(num2str(f2));
   
    % include frequency tolerance and sort the key frequencies (the actuall  
    % tolerance are at with time: >= 0.0499 s and sampling rate: 3300Hz)
    if ((f1>692) && (f1<720))
       f1=697;
         elseif ((f1>765) && (f1<800))
            f1=770;
              elseif ((f1>847) && (f1<880))
                 f1=852;
                   elseif ((f1>936) && (f1<960))
                      f1=941;
    end
                  
    if ((f2>1204) && (f2<1240))
       f2=1209;
         elseif ((f2>1331) && (f2<1360))
            f2=1336;
              elseif ((f2>1472) && (f2<1500))
                 f2=1477;
                   elseif ((f2>1628) && (f2<1660))
                      f2=1633;
    end         
            
    % msgbox(num2str(f1))
    % msgbox(num2str(f2))
    % sort the evaluated frequencies to the keys
    switch(f1);
       case{697};
           switch(f2);
               case{1209};
                   taste='1';
               case{1336};
                   taste='2';
               case{1477};
                   taste='3';
               case{1633};
                   taste='A';
           end
       case{770};
           switch(f2);
               case{1209};
                   taste='4';
               case{1336};
                   taste='5';
               case{1477};
                   taste='6';
               case{1633};
                   taste='B';
           end
        case{852};
           switch(f2);
               case{1209};
                   taste='7';
               case{1336};
                   taste='8';
               case{1477};
                   taste='9';
               case{1633};
                   taste='C';
           end
        case{941};
           switch(f2);
               case{1209};
                   taste='*';
               case{1336};
                   taste='0';
               case{1477};
                   taste='#';
               case{1633};
                   taste='D';
           end
    end
    % the evaluated key into vector 
    B(k)=taste;
    % increase variable 
    k=k+1;
    
end
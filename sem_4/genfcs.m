function [Z] = genfcs(A,d,fa)
%
% This program gives a dtmf key vector to function "encode.m", and generate
% frequency coded signalvector with the parameter from "encode.m".
%
% example:     [Z] = genfcs(A,1,4000);
%
% fa        : sampling rate in hz 
% d         : time in seconds
% A         : dtmf key vector
% Z         : frequency coded signalvector

% sampling time
Ta=1/fa;                                       
n=length(A);                                    

for k=1:n;                                          
    % elements dtmf key vector to function "encode.m" and save won
    % parameter into x,t
    [x,t]=encode(A(k),d,Ta);                       
    % fft analyze frequency coded signalvector
    % yabs=abs(fft(x));                              
    % figure;                                        
    % stem(yabs);                                    
    % generate frequency coded signalvector
    Z(k,:)=x;                                       
    % increase variable 
    k=k+1;
end
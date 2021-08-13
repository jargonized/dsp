clear;
clc;

% dtmf key vector
A=[1,2,3,'A',4,5,6,'B',7,8,9,'C','*',0,'#','D'];

% function call "ausgabe.m" with X time and sampling rate of 4000Hz, because
% the highest signalfrequency is 1633Hz. With this sampling rate we are 
% safe, because of Shannon (sampling rate = 2 * signalfrequency).
% The following configurations have been tested:
% 
%            | 0.0499s | 0.0500s | 0.0860s | 0.0870s | 0.1000s | 0.5000s | 1s | 2s | 50s |
% ----------------------------------------------------------------------------------------
% 3266.0341Hz|    x    |    x    |    x    |    x    |    x    |    x    | ok | ok |  ok |
% ----------------------------------------------------------------------------------------
% 3267.0000Hz|    x    |    x    |    x    |    ok   |    ok   |    ok   | ok | ok |  ok |
% ----------------------------------------------------------------------------------------
% 3300.0000Hz|    ok   |    ok   |    ok   |    ok   |    ok   |    ok   | ok | ok |  ok |
% ----------------------------------------------------------------------------------------
% 3500.0000Hz|    ok   |    ok   |    ok   |    ok   |    ok   |    ok   | ok | ok |  ok |
% ----------------------------------------------------------------------------------------
% 4000.0000Hz|    ok   |    ok   |    ok   |    ok   |    ok   |    ok   | ok | ok |  ok |
% ----------------------------------------------------------------------------------------
% 8000.0000Hz|    ok   |    ok   |    ok   |    ok   |    ok   |    ok   | ok | ok |  ok |
%
% 
% 3267Hz border with time d=0.08636836628511967289829...

d=0.5;              
fa=3267;
[Z]=genfcs(A,d,fa);

% function call analyze
[B]=decode(Z,A,fa,d);
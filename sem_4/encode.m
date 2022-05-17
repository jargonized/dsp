function [x,t] = encode(key,d,Ta)
%
%        [x,t] = encode(key,d,Ta)
%
% This program encode the dtmf key vector.
%
% example:   [x,t]=encode(5,0.2,0.0003)
%
% key:      key
% d:        time in seconds
% Ta;       sampling time

% f1:       frequency in y-coordinate in Hz(from DTMF matrix)
% f2:       frequency in x-coordinate in Hz(from DTMF matrix)

if d<=0;                                                
    disp(' ');                                          
    disp('ERROR: time must be greater 0 !');      
    disp(' ')
    return;
else;
    switch (key);                  
        case {1 2 3 'a' 'A'};
            f1=697;
        case {4 5 6 'b' 'B'};
            f1=770;
        case {7 8 9 'c' 'C'};
            f1=852;
        case {'*' 0 '0' '#' 'D'};
            f1=941;
        otherwise;
            disp(' ');              
            disp('ERROR: incorrect entry !');
            disp('only entry: 1 2 3 4 5 6 7 8 9 0 a b c d # * ');
            disp(' ');
            return;
    end;

    switch (key);                     
        case {1 4 7 '*'};
            f2=1209;
        case {2 5 8 0 '0'};
            f2=1336;
        case {3 6 9 '#'};
            f2=1477;
        case {'a' 'b' 'c' 'd' 'A' 'B' 'C' 'D'};
            f2=1633;
    end;

    t = 0:Ta:d;
    x = sin(2*pi*f1*t)+sin(2*pi*f2*t);       
    if nargout==0 sound(x,1/Ta);  end;       
end;
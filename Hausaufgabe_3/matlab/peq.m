function [b,a] = peq(fs, f0, G, Q)


    % get memory for coefficients
    b  = zeros(1,3);
    a  = zeros(1,3);
    
    
    A  = sqrt( 10^(G/20) );
    w0 = 2*pi*f0/fs;
    alpha = sin(w0)/(2*Q);
    
    
    % peakingEQ:  H(s) = (s^2 + s*(A/Q) + 1) / (s^2 + s/(A*Q) + 1)
    % calc coefficients (by website)

            b(1) =   1 + alpha*A;
            b(2) =  -2*cos(w0);
            b(3) =   1 - alpha*A;
            a(1) =   1 + alpha/A;
            a(2) =  -2*cos(w0);
            a(3) =   1 - alpha/A;
            
function y=irfft(x)
% IRFFT - Computes the Inverse Real FFT.
%
%     y = irfft(x)
%
% Computes the inverse rfft of x
%
% Contributed by Prof. Okan Ersoy, Purdue University
%
%  $Id: irfft.m,v 1.1 1997/12/02 18:22:55 jak Exp $
%

    n=length(x);
    x=comin(x);
    x=rfft(x);
    y=comin(x)/(4*n);

%
% History:
% $Log: irfft.m,v $
% Revision 1.1  1997/12/02 18:22:55  jak
% Bug fixes and code additions. -jak
%
%

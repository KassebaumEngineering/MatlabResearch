
function p = display( p )
% display - iodata Class Method
%
%     p = display( p )
%
% Description: Display iodata object info.
%
% $Id: display.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

    fprintf( 1, ...
        '%s: %d samples, %d inputs, %d outputs \n', ...
        getLabel( p ), getSampleSize( p ), getInputSize( p ), ...
        getOutputSize( p ) ...
    );
%    plot( getSample( p, 1:getSampleSize( p )) );
%    plot( p.outputmatrix );

% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%


function Smat = getOutputSample( p, sampleno )
% getOutputSample - iodata Class Method
%
%     Smat = getOutputSample( p, sampleno )
%
% Description: 
%
% $Id: getOutputSample.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

    Smat = p.outputmatrix( sampleno, : );

% endfunction getOutputSample

%*****************************************************
% History:
% 
% $Log: getOutputSample.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%


function aSize = getInputSize( p )
% getInputSize - @iodata Class Method
%
%     aSize = getInputSize( p )
%
% Description: Return the nuber of input
% variables in the data set.
%
% $Id: getInputSize.m,v 1.1.1.1 1997/10/28 18:38:40 jak Exp $
%

  %aSize = getInputSize( p.data );
  aSize = p.inputs;

% endfunction getInputSize

%*****************************************************
% History:
% 
% $Log: getInputSize.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:40  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%

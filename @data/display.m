
function p = display( p )
% display - data Class Method
%
%     p = display( p )
%
% Description: Display data object info.
%
% $Id: display.m,v 1.1.1.1 1997/10/28 18:38:37 jak Exp $
%

  fprintf(1, '%s: %d samples, %d inputs \n', p.label, p.samples, p.inputs);
%  plot( p.datamatrix );
  
% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:37  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%

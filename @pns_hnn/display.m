
function p = display( p )
% display - @pns_hnn Class Method
%
%     p = display( p )
%
% Description:  Display shows the strucure of the
% assembled PNS tree.
%
% $Id: display.m,v 1.2 1997/11/07 05:40:16 jak Exp $
%

  if isempty( p.N )
      fprintf( 1, 'Net' );
  else
      display( p.P );
      display( p.N );
      display( p.S );
      display( p.pnsReject );
  end

% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.2  1997/11/07 05:40:16  jak
% More code - not working yet though!  -jak
%
% Revision 1.1  1997/11/04 16:54:31  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%

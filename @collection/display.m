
function p = display( p )
% display - collection Class Method
%
%     p = display( p )
%
% Description: Calls display on each of the 
% data sets in the collection.
%
% $Id: display.m,v 1.1 1997/10/28 18:38:44 jak Exp $
%

  fprintf( 1, '%s - data collection:\n', p.label );
  for i=1:p.sets
      display( p.dataArray(i) );
  end
  
% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1  1997/10/28 18:38:44  jak
% Initial revision
%
%
